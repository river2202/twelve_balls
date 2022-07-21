import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twelve_balls/Model/Ball.dart';
import 'package:twelve_balls/Model/WeightingStep.dart';

part 'TwelveBallsQuizStateProvider.freezed.dart';

///
/// === 12 balls quiz game ===
/// * phase 1: MVP
/// 1. list 12 candidate balls and their states
/// 2. show left and right scales with balls on scale
/// 3. one side is active, the other is inactive, active one showing yellow
/// 4. player can click balls to select them
/// 5. player can click balls on scale to remove them
/// 6. showing grey loading when no balls on scale or balls number is not same
/// 7. showing blue weight when balls on both side are the same and not 0
/// 8. player can click weight to see the result
/// 9. showing apply button when result is presented
/// 10. player can click apple to move to next step
/// 11. when only one ball is left within 3 steps, showing You Win!
/// 12. tap history number to show the history step
///
/// todo: * phase 2:
/// 1. show and manage inline message.
/// 2. list all branches to be solved
///
enum WeightingButtonType {
  weight,
  loading,
  apply,
}

@freezed
class TwelveBallsState with _$TwelveBallsState {
  const factory TwelveBallsState.leftGroupActive(
      List<WeightingStep> history, int index) = LeftGroupActive;
  const factory TwelveBallsState.rightGroupActive(
      List<WeightingStep> history, int index) = RightGroupActive;

  const TwelveBallsState._();

  WeightingStep get quiz => when(
        leftGroupActive: (history, index) => history[index],
        rightGroupActive: (history, index) => history[index],
      );

  bool get leftGroupSelected => map(
        leftGroupActive: (s) => true,
        rightGroupActive: (s) => false,
      );

  bool get rightGroupSelected => map(
        leftGroupActive: (s) => false,
        rightGroupActive: (s) => true,
      );

  WeightingButtonType _getWeightButtonType(WeightingStep quiz) {
    if (quiz.hasResult) {
      return WeightingButtonType.apply;
    } else {
      if (quiz.isReadToWeight)
        return WeightingButtonType.weight;
      else
        return WeightingButtonType.loading;
    }
  }

  WeightingButtonType get weightButtonType => _getWeightButtonType(quiz);

  List<WeightingStep> get history => map(
        leftGroupActive: (s) => s.history,
        rightGroupActive: (s) => s.history,
      );

  int get historyActiveIndex => map(
        leftGroupActive: (s) => s.index,
        rightGroupActive: (s) => s.index,
      );
}

class TwelveBallsQuizNotifier extends StateNotifier<TwelveBallsState> {
  TwelveBallsQuizNotifier()
      : super(TwelveBallsState.leftGroupActive([WeightingStep(12)], 0));

  void clickCandidateBall(Ball ball) {
    final quiz = state.quiz;

    state.map(
      leftGroupActive: (s) {
        if (quiz.leftGroup.indexOf(ball.index) < 0) {
          quiz.leftGroupState = BallState.unknown;
          quiz.leftGroup.add(ball.index);
          quiz.leftGroup.sort((a, b) => b.compareTo(a));

          _updateQuiz(quiz);
        }
      },
      rightGroupActive: (s) {
        if (quiz.rightGroup.indexOf(ball.index) < 0) {
          quiz.leftGroupState = BallState.unknown;
          quiz.rightGroup.add(ball.index);
          quiz.rightGroup.sort((a, b) => b.compareTo(a));

          _updateQuiz(quiz);
        }
      },
    );
  }

  void clickLeftGroup() {
    state.mapOrNull(
      rightGroupActive: (s) {
        state = TwelveBallsState.leftGroupActive(s.history, s.index);
      },
    );
  }

  void clickRightGroup() {
    state.mapOrNull(
      leftGroupActive: (s) {
        state = TwelveBallsState.rightGroupActive(s.history, s.index);
      },
    );
  }

  void _updateQuiz(WeightingStep quiz) {
    final history = state.history;
    final index = state.historyActiveIndex;
    history[index] = quiz;
    state = state.map(
      leftGroupActive: (s) => TwelveBallsState.leftGroupActive(history, index),
      rightGroupActive: (s) =>
          TwelveBallsState.rightGroupActive(history, index),
    );
  }

  void clickLeftGroupBall(Ball ball) {
    final quiz = state.quiz;
    quiz.removeFromLeftGroup(ball.index);
    _updateQuiz(quiz);
  }

  void clickRightGroupBall(Ball ball) {
    state = state.when(
      leftGroupActive: (history, index) {
        history[index].removeFromRightGroup(ball.index);
        return TwelveBallsState.rightGroupActive(history, index);
      },
      rightGroupActive: (history, index) {
        history[index].removeFromRightGroup(ball.index);
        return TwelveBallsState.rightGroupActive(history, index);
      },
    );
  }

  void doWeighting() {
    final quiz = state.quiz;
    var history = state.history;
    var index = state.historyActiveIndex;

    if (quiz.hasResult) {
      if (index < history.length - 1) {
        history.removeRange(index + 1, history.length);
      }
      final newStep = WeightingStep.from(quiz);
      history.add(newStep);
      index += 1;
      newStep.doWeighting();

      state = state.map(
        leftGroupActive: (s) =>
            TwelveBallsState.leftGroupActive(history, index),
        rightGroupActive: (s) =>
            TwelveBallsState.leftGroupActive(history, index),
      );
    } else if (quiz.isReadToWeight) {
      final _weightResults = quiz.getWorstWeightingResult(
        quiz.leftGroup,
        quiz.rightGroup,
      );

      // todo: save unsolved branches
      if (_weightResults.length > 0) {
        quiz.leftGroupState = _weightResults.first;
        _updateQuiz(quiz);
      }
    }
  }

  void onHistoryTap(int index) {
    print('onHistoryTap: $index');
    state = state.map(
        leftGroupActive: (s) =>
            TwelveBallsState.leftGroupActive(state.history, index),
        rightGroupActive: (s) =>
            TwelveBallsState.rightGroupActive(state.history, index));
  }
}

final twelveBallsQuizStateProvider = StateNotifierProvider.autoDispose<
    TwelveBallsQuizNotifier, TwelveBallsState>((ref) {
  return TwelveBallsQuizNotifier();
});
