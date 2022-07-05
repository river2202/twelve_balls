import 'package:collection/collection.dart';
import 'package:test/test.dart';
import 'package:twelve_balls/Model/Ball.dart';
import 'package:twelve_balls/Model/Quiz.dart';

Function eq = const ListEquality().equals;
Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;

void main() {
  group('12 Balls tests', () {
    test("Ball init from symbol", () {
      var quiz = Quiz(12);
      expect(quiz.description(), "????????????");
    });

    test("Worse weighting result", () {
      var data = [
        [
          "????????????",
          [1, 2, 3],
          [4, 5, 6],
          [BallState.good]
        ],
        [
          "????????????",
          [1, 2, 3, 4],
          [5, 6, 7, 8],
          [BallState.possiblyLighter, BallState.possiblyHeavier, BallState.good]
        ],
        [
          "????--------",
          [0, 1],
          [2, 3],
          [BallState.possiblyLighter, BallState.possiblyHeavier]
        ],
        [
          "--------????",
          [1, 2],
          [4, 5],
          [BallState.good]
        ],
        [
          "?--------???",
          [1, 2],
          [4, 5],
          [BallState.good]
        ],
        [
          "????",
          [0, 1],
          [2, 3],
          [BallState.possiblyLighter, BallState.possiblyHeavier]
        ],
        [
          "????",
          [1, 2],
          [3, 4],
          List<BallState>.empty()
        ],
      ];

      data.forEach((item) {
        var quiz = Quiz.from(symbols: item[0] as String);
        var worstWeightingResult = quiz.getWorstWeightingResult(
            item[1] as List<int>, item[2] as List<int>);
        List<BallState> resultList = item[3] as List<BallState>;
        print(
            "quiz: ${quiz.description()}, weighting: ${item[1]}, ${item[2]}, got: $worstWeightingResult, expect: ${item[3]}");
        expect(unOrdDeepEq(resultList, worstWeightingResult), true);
      });
    });
  });

  test("Balls isEquivalent", () {
    var data = [
      ["????????????", "????????????", true],
      ["--??????????", "??????????--", true],
      ["↑↑↑??????--?", "??--?????↑↑↑", true],
      ["↑↑↑????↓↓--?", "??--↓?↓??↑↑↑", true],
      ["↑↑????↓↓↓--?", "??--↓?↓??↑↑↑", true],
    ];

    data.forEach((item) {
      var quiz1 = Quiz.from(symbols: item[0] as String);
      var quiz2 = Quiz.from(symbols: item[1] as String);
      bool result = item[2] as bool;
      expect(quiz1.isEquivalent(quiz2), result,
          reason:
              "${quiz1.description()} should ${result ? "be" : "not be"} equivalent of ${quiz2.description()}");
    });
  });
}
