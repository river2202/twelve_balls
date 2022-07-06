import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twelve_balls/Model/Ball.dart';
import 'package:twelve_balls/Model/WeightingStep.dart';

part 'TwelveBallsQuizStateProvider.freezed.dart';

///
/// Todo:
// Think about data
// 12 balls (list of balls)
// Left scale (list of balls)
// Right scale (list of balls)
// current active scale (left or right)
// History node (steps)
// current step
//
// Think about state - more declarative
// Left active (WeightingStep, history)
// Right active (WeightingStep, history)
// History active (history, active index)

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
}

class TwelveBallsQuizNotifier extends StateNotifier<TwelveBallsState> {
  TwelveBallsQuizNotifier()
      : super(TwelveBallsState.leftGroupActive(WeightingStep(12), []));

  void clickCandidateBall(Ball ball) {}
  void clickLeftGroup() {}
  void clickRightGroup() {}
  void clickLeftGroupBall(Ball ball) {}
  void clickRightGroupBall(Ball ball) {}
}

final twelveBallsQuizStateProvider = StateNotifierProvider.autoDispose<
    TwelveBallsQuizNotifier, TwelveBallsState>((ref) {
  return TwelveBallsQuizNotifier();
});
