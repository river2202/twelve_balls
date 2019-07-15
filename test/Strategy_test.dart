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
        ["----------", null],
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
      const weightingResults = [State.possiblyLighter, State.possiblyHeavier, State.good];

      var minimumStep = quiz.getMinimumStep();
      print("Quiz: ${quiz.description()}");

      var bestWeightingStrategy = quiz.getBestWeightingStrategy();
      print("best: $bestWeightingStrategy");

      if((bestWeightingStrategy?.length ?? 0) < 2) {
        print("Quiz:${quiz.description()}, weighting: $bestWeightingStrategy");
        fail("Not validate bestWeightingStrategy");
      }

      for(State weightingResult in weightingResults) {
        var testQuiz = quiz.testApplyingWeighting(bestWeightingStrategy[0], bestWeightingStrategy[1], leftGroupState: weightingResult);
        print("apply left: $weightingResult");
        var testMinimumStep = testQuiz.getMinimumStep();

        if (testMinimumStep != null) {
          if(testMinimumStep < minimumStep) {
            if (testQuiz.result() != null) {
              print("OK, solved, result is ${testQuiz.description()}");
            } else if(testMinimumStep > 0) {
              testQuizNextWeighting(testQuiz);
            } else {
              print("Something went wrong!");
            }
          } else {
            print("Failed: Quiz: ${testQuiz.description()}, weighting: $bestWeightingStrategy, result:$weightingResult");
            expect(testMinimumStep, lessThan(minimumStep));
          }
        } else {
          print("OK, this path has no solution");
        }
      }
    }

    test("Best weighting strategy", () {
//      var quiz = Quiz(12);
//      testQuizNextWeighting(quiz);

      var data = [
        Quiz(12),
        Quiz(15),
        Quiz(39),
        Quiz(40),
        Quiz.from(symbols: "----↑----↓-----"),
      ];

      data.forEach((quiz) => testQuizNextWeighting(quiz));
    });
  });
}