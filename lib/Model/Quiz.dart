import 'package:twelve_balls/Model/Ball.dart';
import 'package:twelve_balls/Model/Balls.dart';
import 'package:twelve_balls/Model/Strategy.dart';

class Quiz extends Balls with WeightingStrategy {
  Quiz(int number) : super(number);
  Quiz.fromBalls(balls) : super.fromBalls(balls);
  Quiz.from({required String symbols}) : super.from(symbols: symbols);

  Ball? get result {
    Ball? result;
    for (Ball ball in balls) {
      switch (ball.state) {
        case BallState.unknown:
          return null;
        case BallState.possiblyLighter:
        case BallState.possiblyHeavier:
          if (result != null) {
            return null;
          } else {
            result = ball;
          }
          break;
        case BallState.good:
          break;
      }
    }
    return result;
  }

  Quiz testApplyingWeighting(List<int> leftGroup, List<int> rightGroup,
      {required BallState leftGroupState}) {
    var testQuiz = Quiz.from(symbols: this.description());
    testQuiz.applyWeighting(leftGroup, rightGroup,
        leftGroupState: leftGroupState);
    return testQuiz;
  }

  List<BallState> getWorstWeightingResult(
      List<int> leftGroup, List<int> rightGroup) {
    if (leftGroup.length != rightGroup.length) {
      return [];
    }

    const weightingResults = [
      BallState.possiblyLighter,
      BallState.possiblyHeavier,
      BallState.good
    ];
    List<int?> minimumSteps = weightingResults.map((possibleResult) {
      if (!validatingWeighting(leftGroup, rightGroup, possibleResult)) {
        return null;
      }

      var testQuiz = testApplyingWeighting(leftGroup, rightGroup,
          leftGroupState: possibleResult);
      print(
          "${description()} apply $possibleResult got ${testQuiz.description()}");
      return testQuiz.getMinimumStep();
    }).toList();

    var worst = minimumSteps.reduce((a, b) {
      if (a == null) {
        return b;
      }

      if (b == null) {
        return a;
      }

      return a > b ? a : b;
    });
    print(minimumSteps);
    print(worst);

    if (worst == null) {
      return [];
    }

    var i = 0;
    List<BallState> result = [];
    for (BallState state in weightingResults) {
      if (minimumSteps[i] == worst) {
        result.add(state);
      }
      i++;
    }

    return result;
  }

  bool isEquivalent(Quiz? quiz) {
    List<int> group1 = stateGroup();
    List<int> group2 = quiz?.stateGroup() ?? [];

    var compare = () {
      return BallState.values
          .map((v) => group1[v.index] == group2[v.index])
          .reduce((first, next) => first && next);
    };

    if (compare()) {
      return true;
    }

    int m = group1[BallState.possiblyHeavier.index];
    group1[BallState.possiblyHeavier.index] =
        group1[BallState.possiblyLighter.index];
    group1[BallState.possiblyLighter.index] = m;

    return compare();
  }
}
