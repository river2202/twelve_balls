
import 'package:twelve_balls/Ball.dart';
import 'package:twelve_balls/Balls.dart';
import 'package:twelve_balls/Strategy.dart';

class Quiz extends Balls with StepStrategy, WeightingStrategy {
  Quiz(int number) : super(number);
  Quiz.fromBalls(balls): super.fromBalls(balls);
  Quiz.from({String symbols}): super.from(symbols: symbols);

  Ball result() {
    Ball result;
    for(Ball ball in balls) {
      switch(ball.state) {
        case State.unknown:
          return null;
        case State.possiblyLighter:
        case State.possiblyHeavier:
          if(result != null) {
            return null;
          } else {
            result = ball;
          }
          break;
        case State.good:
          break;
      }
    }
    return result;
  }

  Quiz testApplyingWeighting(List<int> leftGroup, List<int> rightGroup, {State leftGroupState}) {
    var testQuiz = Quiz.from(symbols: this.description());
    testQuiz.applyWeighting(leftGroup, rightGroup, leftGroupState: leftGroupState);
    return testQuiz;
  }
}