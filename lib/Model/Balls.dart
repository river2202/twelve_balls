import 'package:twelve_balls/Model/Ball.dart';

class Balls {
  late List<Ball> balls;

  Balls(int number) {
    balls = Iterable<int>.generate(number).map((index) => Ball(index)).toList();
  }

  Balls.fromBalls(this.balls);
  Balls.from({String symbols = "?"}) {
    int index = 0;
    balls = symbols.runes.map((int char) {
      return Ball.from(index++, symbol: String.fromCharCode(char));
    }).toList();
  }

  List<int> stateGroup() {
    return stateBallGroup().map((group) => group.length).toList();
  }

  List<List<Ball>> stateBallGroup() {
    return BallState.values.map((state) {
      return balls.where((ball) => ball.state == state).toList();
    }).toList();
  }

  // _badWeighting() {
  //   balls.forEach((ball) {
  //     ball.applyStatus(BallState.good);
  //   });
  // }

  bool validatingWeighting(
      List<int> leftGroup, List<int> rightGroup, BallState leftGroupState) {
    if (leftGroup.length != rightGroup.length ||
        leftGroupState == BallState.unknown) {
      return false;
    }

    int ballNum = balls.length;

    for (int index in leftGroup) {
      if (index < 0 || index >= ballNum) {
        return false;
      }

      if (rightGroup.contains(index)) {
        return false;
      }
    }

    for (int index in rightGroup) {
      if (index < 0 || index >= ballNum) {
        return false;
      }

      if (leftGroup.contains(index)) {
        return false;
      }
    }

    return true;
  }

  applyWeighting(List<int> leftGroup, List<int> rightGroup,
      {required BallState leftGroupState}) {
    if (!validatingWeighting(leftGroup, rightGroup, leftGroupState)) {
      print("_badWeighting: $leftGroup, $rightGroup, $leftGroupState");
      return;
    }

    BallState rightGroupState = Ball.getOppositeState(leftGroupState);
    BallState restGroupState = [
      BallState.unknown,
      BallState.good,
      BallState.good,
      BallState.unknown
    ][leftGroupState.index];

    balls.forEach((ball) {
      if (leftGroup.contains(ball.index)) {
        ball.applyStatus(leftGroupState);
      } else if (rightGroup.contains(ball.index)) {
        ball.applyStatus(rightGroupState);
      } else {
        ball.applyStatus(restGroupState);
      }
    });

    print(
        "apply Weighting: $leftGroup, $rightGroup, $leftGroupState, got: ${description()}");
  }

  String description() {
    try {
      return balls.map((ball) => ball.symbol()).reduce((a, b) => a + b);
    } catch (e) {
      return "";
    }
  }
}
