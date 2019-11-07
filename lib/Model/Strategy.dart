import 'package:twelve_balls/Model/Ball.dart';
import 'package:twelve_balls/Model/Balls.dart';
import 'dart:math';

mixin WeightingStrategy on Balls {
  int _stepLeftExhaustion() {
    // using exhaustion to search for steps
    // not supported by this version
    return null;
  }

  int _stepLeftForUnknown(int unknown, int good) {
    if (unknown == 1 && good <= 0) {
      return null;
    }

    if (unknown == 2 && good <= 0) {
      return null;
    }

    var step = 1;
    var maxBalls = good > 0 ? 1 : 0;

    while (maxBalls < unknown) {
      maxBalls = good > 0 ? maxBalls * 3 + 1 : (maxBalls + 1) * 3;
      step++;
    }

    if (good > 0 && maxBalls + 1 <= unknown) {
      return step;
    } else {
      return step;
    }
  }

  int _stepLeftForDirectionInfo(
      int possiblyLighter, int possiblyHeavier, int good) {
    int directionInfo = (possiblyLighter + possiblyHeavier);

    if (directionInfo == 1) {
      return 0;
    }

    if (possiblyLighter == 1 && possiblyHeavier == 1 && good <= 0) {
      return null;
    }

    return (log(directionInfo) / log(3)).ceil();
  }

  int getMinimumStep() {
    var groups = stateGroup();
    if (groups.length < BallState.values.length) {
      return null;
    }

    int unknown = groups[BallState.unknown.index];
    int possiblyLighter = groups[BallState.possiblyLighter.index];
    int possiblyHeavier = groups[BallState.possiblyHeavier.index];
    int good = groups[BallState.good.index];

    int directionInfo = (possiblyLighter + possiblyHeavier);

    if (unknown > 0 && directionInfo > 0) {
      return _stepLeftExhaustion();
    }

    if (directionInfo > 0) {
      return _stepLeftForDirectionInfo(possiblyLighter, possiblyHeavier, good);
    }

    if (unknown > 0) {
      return _stepLeftForUnknown(unknown, good);
    }

    return null;
  }

//}

//mixin WeightingStrategy on StepStrategy {

  List<List<int>> _getBestWeightingStrategyForUnknown(
      List<Ball> unknownBalls, List<Ball> goodBalls) {
    int unknown = unknownBalls.length;
    int good = goodBalls.length;

    if (unknown == 1 && good == 0) {
      return null;
    }

    if (unknown == 2 && good == 0) {
      return null;
    }

    int leftGroupNum = (unknown + 1) ~/ 3;
    int remainder = unknown.remainder(3);
    List<Ball> candidateBalls = List<Ball>.from(
        unknownBalls); //unknownBalls.map((ball) => ball).toList();

    if (good > 0 && remainder == 1) {
      leftGroupNum++;
      candidateBalls.insert(0, goodBalls.first);
    }

    var leftGroup = candidateBalls
        .sublist(0, leftGroupNum)
        .map((ball) => ball.index)
        .toList();
    var rightGroup = candidateBalls
        .sublist(leftGroupNum, leftGroupNum + leftGroupNum)
        .map((ball) => ball.index)
        .toList();

    return [leftGroup, rightGroup];
  }

  Iterable<T> _merge2by2<T>(Iterable<T> c1, Iterable<T> c2) sync* {
    var it1 = c1.iterator;
    var it2 = c2.iterator;
    var active = true;
    while (active) {
      active = false;

      for (int _ in [1, 2]) {
        if (it1.moveNext()) {
          active = true;
          yield it1.current;
        }
      }

      for (int _ in [1, 2]) {
        if (it2.moveNext()) {
          active = true;
          yield it2.current;
        }
      }
    }
  }

  List<List<int>> _getBestWeightingStrategyForDirectionInfo(
      List<Ball> possiblyLighterBalls,
      List<Ball> possiblyHeavierBalls,
      List<Ball> goodBalls) {
    int possiblyLighter = possiblyLighterBalls.length;
    int possiblyHeavier = possiblyHeavierBalls.length;
    int good = goodBalls.length;

    int directionInfo = (possiblyLighter + possiblyHeavier);

    if (directionInfo == 1) {
      return null;
    }

    if (possiblyLighter == 1 && possiblyHeavier == 1 && good == 0) {
      return null;
    }

    if (possiblyLighter == 1 && possiblyHeavier == 1 && good > 0) {
      return [
        [possiblyLighterBalls[0].index],
        [goodBalls[0].index]
      ];
    }

    List<Ball> candidateBalls = _merge2by2(
            possiblyLighter > possiblyHeavier
                ? possiblyLighterBalls
                : possiblyHeavierBalls,
            possiblyLighter > possiblyHeavier
                ? possiblyHeavierBalls
                : possiblyLighterBalls)
        .toList();

    int leftGroupNum = (directionInfo + 1) ~/ 3;

    var leftGroup = List<
        int>(); //candidateBalls.where((ball) => ).sublist(0, leftGroupNum).map((ball) => ball.index).toList();
    var rightGroup = List<
        int>(); //candidateBalls.sublist(leftGroupNum, leftGroupNum + leftGroupNum).map((ball) => ball.index).toList();

    for (int i = 0; i < leftGroupNum; i++) {
      leftGroup.add(candidateBalls[2 * i].index);
      rightGroup.add(candidateBalls[2 * i + 1].index);
    }

    return [leftGroup, rightGroup];
  }

  List<List<int>> getBestWeightingStrategy() {
    var groups = stateBallGroup();
    if (groups.length < BallState.values.length) {
      return null;
    }

    List<Ball> unknown = groups[BallState.unknown.index];
    List<Ball> possiblyLighter = groups[BallState.possiblyLighter.index];
    List<Ball> possiblyHeavier = groups[BallState.possiblyHeavier.index];
    List<Ball> good = groups[BallState.good.index];

    int directionInfo = (possiblyLighter.length + possiblyHeavier.length);

    if (unknown.length > 0 && directionInfo > 0) {
      return null;
    }

    if (directionInfo > 0) {
      return _getBestWeightingStrategyForDirectionInfo(
          possiblyLighter, possiblyHeavier, good);
    }

    if (unknown.length > 0) {
      return _getBestWeightingStrategyForUnknown(unknown, good);
    }

    return null;
  }
}
