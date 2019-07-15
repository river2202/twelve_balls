import 'package:twelve_balls/Ball.dart';
import 'package:twelve_balls/Balls.dart';
import 'dart:math';

mixin StepStrategy on Balls {
  int _stepLeftExhaustion() {
    // using exhaustion to search for steps
    // not supported by this version
    return null;
  }

  int _stepLeftForUnknown(int unknown, int good) {

    if(unknown==1 && good==0) {
      return null;
    }

    if(unknown==2 && good==0) {
      return null;
    }

    var step = 1;
    var maxBalls = good > 0 ? 1 : 0;

    while(maxBalls < unknown) {
      maxBalls = good > 0 ? maxBalls*3+1 : (maxBalls+1)*3;
      step++;
    }

    if(good > 0 && maxBalls+1 <= unknown) {
      return step;
    } else {
      return step;
    }
  }

  int _stepLeftForDirectionInfo(int possiblyLighter, int possiblyHeavier, int good) {

    int directionInfo = (possiblyLighter+possiblyHeavier);

    if(directionInfo == 1) {
      return 0;
    }

    if(possiblyLighter == 1 && possiblyHeavier == 1 && good < 1) {
      return null;
    }

    return (log(directionInfo)/log(3)).ceil();
  }

  int getMinimumStep() {
    var groups = stateGroup();
    if(groups.length < State.values.length) {
      return null;
    }

    int unknown = groups[State.unknown.index];
    int possiblyLighter = groups[State.possiblyLighter.index];
    int possiblyHeavier = groups[State.possiblyHeavier.index];
    int good = groups[State.good.index];

    int directionInfo = (possiblyLighter+possiblyHeavier);

    if(unknown > 0 && directionInfo > 0) {
      return _stepLeftExhaustion();
    }

    if(directionInfo > 0) {
      return _stepLeftForDirectionInfo(possiblyLighter, possiblyHeavier, good);
    }

    if(unknown > 0) {
      return _stepLeftForUnknown(unknown, good);
    }

    return null;
  }
}

mixin WeightingStrategy on StepStrategy {

  List<List<int>> _getBestWeightingStrategyForUnknown(List<Ball> unknownBalls, List<Ball> goodBalls) {

    int unknown = unknownBalls.length;
    int good = goodBalls.length;

    if(unknown==1 && good==0) {
      return null;
    }

    if(unknown==2 && good==0) {
      return null;
    }

    int leftGroupNum = (unknown+1) ~/ 3;
    int remainder = unknown.remainder(3);
    List<Ball> candidateBalls = unknownBalls.map((ball) => ball).toList();

    if(good > 0 && remainder == 1) {
      leftGroupNum ++;
      candidateBalls.add(goodBalls.first);
    }

    var leftGroup = candidateBalls.sublist(0, leftGroupNum).map((ball) => ball.index).toList();
    var rightGroup = candidateBalls.sublist(leftGroupNum, leftGroupNum + leftGroupNum).map((ball) => ball.index).toList();

    return [leftGroup, rightGroup];
  }

  List<List<int>> _getBestWeightingStrategyForDirectionInfo(List<Ball> possiblyLighterBalls, List<Ball> possiblyHeavierBalls, List<Ball> goodBalls) {

    int possiblyLighter = possiblyLighterBalls.length;
    int possiblyHeavier = possiblyHeavierBalls.length;

    int directionInfo = (possiblyLighter+possiblyHeavier);

    if(directionInfo == 1) {
      return null;
    }

    if(possiblyLighter == 1 && possiblyHeavier == 1 && good < 1) {
      return null;
    }




    return null;// (log(directionInfo)/log(3)).ceil();
  }

  List<List<int>> getBestWeightingStrategy() {
    var groups = stateBallGroup();
    if(groups.length < State.values.length) {
      return null;
    }

    List<Ball> unknown = groups[State.unknown.index];
    List<Ball> possiblyLighter = groups[State.possiblyLighter.index];
    List<Ball> possiblyHeavier = groups[State.possiblyHeavier.index];
    List<Ball> good = groups[State.good.index];

    int directionInfo = (possiblyLighter.length + possiblyHeavier.length);

    if(unknown.length > 0 && directionInfo > 0) {
      return null;
    }

    if(directionInfo > 0) {
      return _getBestWeightingStrategyForDirectionInfo(possiblyLighter, possiblyHeavier, good);
    }

    if(unknown.length > 0) {
      return _getBestWeightingStrategyForUnknown(unknown, good);
    }

    return null;
  }
}
