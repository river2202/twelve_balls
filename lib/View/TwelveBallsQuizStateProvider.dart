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
/// * phase 2:
/// 1. show and manage inline message.
/// 2. list all branches to be solved
/// 2.
///
enum WeightingButtonType {
  weight,
  loading,
  apply,
}

@freezed
class TwelveBallsState with _$TwelveBallsState {
  const factory TwelveBallsState.leftGroupActive(
      WeightingStep quiz, List<WeightingStep> history) = LeftGroupActive;
  const factory TwelveBallsState.rightGroupActive(
      WeightingStep quiz, List<WeightingStep> history) = RightGroupActive;
  const factory TwelveBallsState.historySetpActive(
      int index, List<WeightingStep> history) = HistorySetpActive;

  const TwelveBallsState._();

  WeightingStep get quiz => map(
        leftGroupActive: (s) => s.quiz,
        rightGroupActive: (s) => s.quiz,
        historySetpActive: (s) => s.history[s.index],
      );

  bool get leftGroupSelected => map(
        leftGroupActive: (s) => true,
        rightGroupActive: (s) => false,
        historySetpActive: (s) => false,
      );

  bool get rightGroupSelected => map(
        leftGroupActive: (s) => false,
        rightGroupActive: (s) => true,
        historySetpActive: (s) => false,
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

  WeightingButtonType get weightButtonType => map(
        leftGroupActive: (s) => _getWeightButtonType(s.quiz),
        rightGroupActive: (s) => _getWeightButtonType(s.quiz),
        historySetpActive: (s) => WeightingButtonType.apply,
      );

  List<WeightingStep> get history => map(
        leftGroupActive: (s) => s.history,
        rightGroupActive: (s) => s.history,
        historySetpActive: (s) => s.history,
      );

  int get historyActiveIndex => map(
        leftGroupActive: (s) => s.history.length,
        rightGroupActive: (s) => s.history.length,
        historySetpActive: (s) => s.index,
      );
}

class TwelveBallsQuizNotifier extends StateNotifier<TwelveBallsState> {
  TwelveBallsQuizNotifier()
      : super(TwelveBallsState.leftGroupActive(WeightingStep(12), []));

  void clickCandidateBall(Ball ball) {
    state.when(
      leftGroupActive: (quiz, history) {
        quiz.leftGroupState = BallState.unknown;
        if (quiz.leftGroup.indexOf(ball.index) < 0) {
          quiz.leftGroup.add(ball.index);
          quiz.leftGroup.sort((a, b) => b.compareTo(a));
        }
        state = TwelveBallsState.leftGroupActive(quiz, history);
      },
      rightGroupActive: (quiz, history) {
        quiz.leftGroupState = BallState.unknown;
        if (quiz.rightGroup.indexOf(ball.index) < 0) {
          quiz.rightGroup.add(ball.index);
          quiz.rightGroup.sort((a, b) => b.compareTo(a));
        }
        state = TwelveBallsState.rightGroupActive(quiz, history);
      },
      historySetpActive: (index, history) {
        state = TwelveBallsState.historySetpActive(index, history);
      },
    );
  }

  void clickLeftGroup() {
    state.when(
      leftGroupActive: (quiz, history) {},
      rightGroupActive: (quiz, history) {
        state = TwelveBallsState.leftGroupActive(quiz, history);
      },
      historySetpActive: (index, history) {
        state = TwelveBallsState.leftGroupActive(history[index], history);
      },
    );
  }

  void clickRightGroup() {
    state.when(
      leftGroupActive: (quiz, history) {
        state = TwelveBallsState.rightGroupActive(quiz, history);
      },
      rightGroupActive: (quiz, history) {},
      historySetpActive: (index, history) {
        state = TwelveBallsState.rightGroupActive(history[index], history);
      },
    );
  }

  void clickLeftGroupBall(Ball ball) {
    state.when(
      leftGroupActive: (quiz, history) {
        quiz.removeFromLeftGroup(ball.index);
        state = TwelveBallsState.leftGroupActive(quiz, history);
      },
      rightGroupActive: (quiz, history) {
        quiz.removeFromLeftGroup(ball.index);
        state = TwelveBallsState.leftGroupActive(quiz, history);
      },
      historySetpActive: (index, history) {},
    );
  }

  void clickRightGroupBall(Ball ball) {
    state.when(
      leftGroupActive: (quiz, history) {
        quiz.removeFromRightGroup(ball.index);
        state = TwelveBallsState.rightGroupActive(quiz, history);
      },
      rightGroupActive: (quiz, history) {
        quiz.removeFromRightGroup(ball.index);
        state = TwelveBallsState.rightGroupActive(quiz, history);
      },
      historySetpActive: (index, history) {},
    );
  }

  void doWeighting() {
    _weight(WeightingStep quiz, List<WeightingStep> history) {
      if (quiz.hasResult) {
        history.add(quiz);
        quiz.doWeighting();

        state = state.map(
          leftGroupActive: (s) =>
              TwelveBallsState.leftGroupActive(quiz, history),
          rightGroupActive: (s) =>
              TwelveBallsState.rightGroupActive(quiz, history),
          historySetpActive: (s) =>
              TwelveBallsState.historySetpActive(s.index, history),
        );
      } else if (quiz.isReadToWeight) {
        final _weightResults = quiz.getWorstWeightingResult(
          quiz.leftGroup,
          quiz.rightGroup,
        );

        if (_weightResults.length > 0) {
          quiz.leftGroupState = _weightResults.first;
          state = TwelveBallsState.leftGroupActive(quiz, history);
        }
      }
    }

    state.when(
      leftGroupActive: _weight,
      rightGroupActive: _weight,
      historySetpActive: (index, history) {
        final quiz = history[index];
        quiz.doWeighting();
        history.removeRange(index + 1, history.length);
        state = TwelveBallsState.leftGroupActive(quiz, history);
      },
    );
  }

  void onHistoryTap(int index) {
    // state = TwelveBallsState.historySetpActive(index, state.history);
  }
}

final twelveBallsQuizStateProvider = StateNotifierProvider.autoDispose<
    TwelveBallsQuizNotifier, TwelveBallsState>((ref) {
  return TwelveBallsQuizNotifier();
});
