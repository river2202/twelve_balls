import 'package:test/test.dart';
import 'package:twelve_balls/Ball.dart';
import 'package:twelve_balls/Balls.dart';
import 'package:twelve_balls/Strategy.dart';
import 'package:twelve_balls/Quiz.dart';
import 'package:collection/collection.dart';

Function eq = const ListEquality().equals;

void main() {

  group('Strategy tests', () {

    test("minimum step", () {
      var data = [
        ["", null],
        ["?", null],
        ["?-", 1],
        ["↓↓↓", 1],

        ["???", 2],
        ["????-", 2],
        ["↓↓↓↓↓↓↓↓↓", 2],

        ["????????????", 3],
        ["?????????????-", 3],

        ["??", null],
        ["??-", 2],
        ["↑↑", 1],
        ["↓↓", 1],
        ["↓↑", null],
        ["↓↑-", 1],
        ["????", 3],
        ["↓↓↑↑", 2],

        ["--------↑-", 0],
        ["--↓-------", 0],
      ];

      data.forEach((data) {
        var quiz = Quiz.from(symbols: data[0]);

        if (quiz.getMinimumStep() != data[1]) {
          print("quiz: ${quiz.description()}, minimum step should be: ${data[1]}, got: ${quiz.getMinimumStep()}");
          expect(quiz.getMinimumStep(), data[1]);
        }
      });
    });

    testQuizNextWeighting(Quiz quiz) {
      var minimumStep = quiz.getMinimumStep();
      var bestWeightingStrategy = quiz.getBestWeightingStrategy();
      const weightingResults = [State.possiblyLighter, State.possiblyHeavier, State.good];

      print("Quiz: ${quiz.description()}");
      print("best: $bestWeightingStrategy");

      if((bestWeightingStrategy?.length ?? 0) < 2) {
        print("Quiz:${quiz.description()}, weighting: $bestWeightingStrategy");
        fail("Not validate bestWeightingStrategy");
      }

      for(State weightingResult in weightingResults) {
        var testQuiz = quiz.testApplyingWeighting(bestWeightingStrategy[0], bestWeightingStrategy[1], leftGroupState: weightingResult);
        print("apply left: $weightingResult");
        var testMinimumStep = testQuiz.getMinimumStep();
        if(testMinimumStep < minimumStep) {
          if (testQuiz.result() == null || testMinimumStep > 0) {
            testQuizNextWeighting(testQuiz);
          }
        } else {
          print("Quiz:${testQuiz.description()}, weighting: $bestWeightingStrategy, result:$weightingResult");
          expect(testMinimumStep, lessThan(minimumStep));
        }
      }
    }

    test("Best weighting strategy", () {
      var quiz = Quiz(12);
      testQuizNextWeighting(quiz);
    });
  });
}