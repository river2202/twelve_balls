import 'package:twelve_balls/Model/Ball.dart';
import 'package:twelve_balls/Model/WeightingStep.dart';

class TwelveBallsQuizVM {
  WeightingStep quiz = WeightingStep(12);
  WeightingStep? _historyStep;
  late List<int> activeGroup;
  WeightingStep get activeQuiz => _historyStep ?? quiz;
  List<WeightingStep> history = [];

  TwelveBallsQuizVM() {
    setActiveQuiz(quiz);
    activeGroup = activeQuiz.leftGroup;
  }

  bool activeQuizSolved() {
    return activeQuiz.solved;
  }

  setActiveQuiz(WeightingStep? value) {
    _historyStep = value ?? quiz;
  }

  leftIndex() {
    return activeQuiz.leftGroup;
  }

  rightIndex() {
    return activeQuiz.rightGroup;
  }

  weightResult() {
    return activeQuiz.leftGroupState;
  }

  setLoading() {
    activeQuiz.leftGroupState = BallState.unknown;
  }

  void clickCandidateBall(Ball ball) {
    setLoading();

    if (activeGroup.indexOf(ball.index) < 0) {
      activeGroup.add(ball.index);
      activeGroup.sort((a, b) => b.compareTo(a));
    }
  }

  void clickLeftGroupBall(Ball ball) {
    setLoading();
    activeQuiz.leftGroup.remove(ball.index);
  }

  void clickRightGroupBall(Ball ball) {
    setLoading();
    activeQuiz.rightGroup.remove(ball.index);
  }

  void clickLeftGroup() {
    print("Select Left Group");
    activeGroup = activeQuiz.leftGroup;
  }

  void clickRightGroup() {
    print("Select Right Group");
    activeGroup = activeQuiz.rightGroup;
  }

  bool isReadyToWeight() =>
      activeQuiz.leftGroup.length > 0 &&
      activeQuiz.leftGroup.length == activeQuiz.rightGroup.length;

  bool isBallSeleced(Ball ball) =>
      activeQuiz.leftGroup.indexOf(ball.index) >= 0 ||
      activeQuiz.rightGroup.indexOf(ball.index) >= 0;

  BallState getLeftWeightResult() {
    return weightResult();
  }

  BallState getRightWeightResult() {
    return Ball.getOppositeState(weightResult());
  }

  String getWeightButtonText() {
    if (weightResult() == BallState.unknown) {
      return isReadyToWeight() ? "Weight" : "Loading";
    } else {
      return "Apply";
    }
  }

  addHistory(WeightingStep step) {
    history.add(step);
  }
}
