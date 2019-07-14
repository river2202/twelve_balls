import 'package:twelve_balls/Ball.dart';
import 'dart:math';

class Balls {
  List<Ball> balls;

  Balls(int number) {
    balls = Iterable<int>.generate(number).map((index) => Ball(index)).toList();
  }

  Balls.fromBalls(this.balls);
  Balls.from({String symbols}) {
    int index = 0;
    balls = symbols.runes.map((int char) {
      return Ball.from(index++, symbol: String.fromCharCode(char));
    }).toList();
  }

  List<int> stateGroup() {
    return State.values.map((state) {
      return balls.where((ball) => ball.state == state).length;
    }).toList();
  }

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

  int stepsLeft() {
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

  Ball result() {
    return null;
  }

  List<int> getWeightingStrategy() {
    return [0,1,2,4,5,6,7,8];
  }

  applyWeighting(List<int> leftGroup, List<int> rightGroup, {State leftGroupState}) {

    if (leftGroup.length != rightGroup.length || leftGroupState == State.unknown) {
      return;
    }

    State rightGroupState = [
      State.unknown,
      State.possiblyHeavier,
      State.possiblyLighter,
      State.good][leftGroupState.index];
    State restGroupState = [
      State.unknown,
      State.good,
      State.good,
      State.unknown][leftGroupState.index];

    balls.forEach((ball) {
      if (leftGroup.contains(ball.index)) {
        ball.applyStatus(leftGroupState);
      } else if (rightGroup.contains(ball.index)) {
        ball.applyStatus(rightGroupState);
      } else {
        ball.applyStatus(restGroupState);
      }
    });
  }

  String description() {
    try {
      return balls.map((ball) => ball.symbol()).reduce((a, b) => a + b);
    } catch (e) {
      return null;
    }
  }
}