import 'package:test/test.dart';
import 'package:twelve_balls/Model/Ball.dart';
import 'package:twelve_balls/Model/Quiz.dart';
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
          print(
              "quiz: ${quiz.description()}, minimum step should be: ${data[1]}, got: ${quiz.getMinimumStep()}");
          expect(quiz.getMinimumStep(), data[1]);
        }
      });
    });

    testQuizNextWeighting(Quiz quiz) {
      const weightingResults = [
        BallState.possiblyLighter,
        BallState.possiblyHeavier,
        BallState.good
      ];

      var minimumStep = quiz.getMinimumStep();
      print("Quiz: ${quiz.description()}");

      var bestWeightingStrategy = quiz.getBestWeightingStrategy();
      print("best: $bestWeightingStrategy");

      if ((bestWeightingStrategy?.length ?? 0) < 2) {
        print("Quiz:${quiz.description()}, weighting: $bestWeightingStrategy");
        fail("Not validate bestWeightingStrategy");
      }

      for (BallState weightingResult in weightingResults) {
        var testQuiz = quiz.testApplyingWeighting(
            bestWeightingStrategy[0], bestWeightingStrategy[1],
            leftGroupState: weightingResult);
        print("apply left: $weightingResult");
        var testMinimumStep = testQuiz.getMinimumStep();

        if (testMinimumStep != null) {
          if (testMinimumStep < minimumStep) {
            if (testQuiz.result != null) {
              print("OK, solved, result is ${testQuiz.description()}");
            } else if (testMinimumStep > 0) {
              testQuizNextWeighting(testQuiz);
            } else {
              print("Something went wrong!");
            }
          } else {
            print(
                "Failed: Quiz: ${testQuiz.description()}, weighting: $bestWeightingStrategy, result:$weightingResult");
            expect(testMinimumStep, lessThan(minimumStep));
          }
        } else {
          print("OK, this path has no solution");
        }
      }
    }

    test("Best weighting strategy", () {
      var data = [
        Quiz(12),
        Quiz(15),
        Quiz(39),
        Quiz(40),
        Quiz.from(symbols: "----↑----↓-----"),
      ];

      data.forEach((quiz) => testQuizNextWeighting(quiz));
    });

    test("test apply weighting", () {
      var data = [
        [
          "????--------",
          [0, 1],
          [2, 3],
          BallState.good,
          "------------"
        ],
      ];

      data.forEach((item) {
        var quiz = Quiz.from(symbols: item[0]);
        var testQuiz = quiz.testApplyingWeighting(item[1], item[2],
            leftGroupState: item[3]);

        print(
            "quiz: ${quiz.description()}, weighting: ${item[1]}, ${item[2]}, ${item[3]}, got: ${testQuiz.description()}, expect: ${item[4]}");
        expect(testQuiz.description(), item[4]);
      });
    });
  });
}
