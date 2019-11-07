import 'package:test/test.dart';
import 'package:twelve_balls/Model/Ball.dart';
import 'package:twelve_balls/Model/Quiz.dart';
import 'package:collection/collection.dart';

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
          List<BallState>()
        ],
      ];

      data.forEach((item) {
        var quiz = Quiz.from(symbols: item[0]);
        var worstWeightingResult =
            quiz.getWorstWeightingResult(item[1], item[2]);
        List<BallState> resultList = item[3];
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
      var quiz1 = Quiz.from(symbols: item[0]);
      var quiz2 = Quiz.from(symbols: item[1]);
      bool result = item[2];
      expect(quiz1.isEquivalent(quiz2), result,
          reason:
              "${quiz1.description()} should ${result ? "be" : "not be"} equivalent of ${quiz2.description()}");
    });
  });
}
