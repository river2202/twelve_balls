import 'dart:core';

import 'package:twelve_balls/Model/Ball.dart';
import 'package:twelve_balls/Model/Quiz.dart';

class WeightingStep extends Quiz {
  WeightingStep(int number) : super(number) {
    this.leftGroup = [];
    this.rightGroup = [];
    this.leftGroupState = BallState.unknown;
  }

  WeightingStep.from(WeightingStep step)
      : super.from(symbols: step.description()) {
    this.leftGroup = [...step.leftGroup];
    this.rightGroup = [...step.rightGroup];
    this.leftGroupState = step.leftGroupState;
  }

  List<int> leftGroup;
  List<int> rightGroup;
  BallState leftGroupState;

  bool get solved {
    if (result == null) {
      return false;
    }

    return true;
  }

  doWeighting() {
    applyWeighting(leftGroup, rightGroup, leftGroupState: leftGroupState);
    leftGroupState = BallState.unknown;
    leftGroup = [];
    rightGroup = [];
  }
}

class Step {
  Step(
    this.quiz, {
    this.leftGroupState,
  });

  Step.from(this.quiz, this.leftGroupState, this.leftGroup, this.rightGroup,
      this.results);

  BallState leftGroupState;
  Quiz quiz;

  List<int> leftGroup;
  List<int> rightGroup;

  bool _solved = false;
  bool get solved {
    if (_solved) {
      return true;
    }

    if (quiz.result != null) {
      _solved = true;
      return true;
    }

    if (results.length > 0) {
      _solved = results
          .map((step) => step.solved)
          .reduce((first, next) => first && next);
    }

    return _solved;
  }

  List<Step> results = [];

  act(List<int> leftGroup, List<int> rightGroup) {
    this.leftGroup = leftGroup;
    this.rightGroup = rightGroup;

    List<Step> candidates = quiz
        .getWorstWeightingResult(leftGroup, rightGroup)
        .map((possibleResult) {
      Quiz q = quiz.testApplyingWeighting(leftGroup, rightGroup,
          leftGroupState: possibleResult);
      return Step(q, leftGroupState: possibleResult);
    }).toList();

    results = [];
    for (var step in candidates) {
      if (!_listContains(results, step)) {
        results.add(step);
      }
    }
  }

  bool _isEquivalent(Step step) => quiz.isEquivalent(step.quiz);
  bool _listContains(List<Step> list, Step step) =>
      list.firstWhere((it) => it._isEquivalent(step), orElse: () => null) !=
      null;
}
