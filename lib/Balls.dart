import 'package:twelve_balls/Ball.dart';

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
    return stateBallGroup().map((group) => group.length).toList();
  }

  List<List<Ball>> stateBallGroup() {
    return State.values.map((state) {
      return balls.where((ball) => ball.state == state);
    }).toList();
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

