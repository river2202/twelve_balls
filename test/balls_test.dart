import 'package:test/test.dart';
import 'package:twelve_balls/Model/Ball.dart';
import 'package:twelve_balls/Model/Balls.dart';
import 'package:twelve_balls/Model/Quiz.dart';
import 'package:collection/collection.dart';

Function eq = const ListEquality().equals;

void main() {
  group('Ball tests', () {
    test("Ball init from symbol", () {
      var ballSymbols = [
        ["?"],
        ["↑"],
        ["↓"],
        ["-"],
        ["a", "?"],
        ["-1", "?"],
      ];

      ballSymbols.forEach((symbols) {
        var symbol = symbols[0];
        var expectSymbol = symbol;
        try {
          expectSymbol = symbols[1];
        } catch (e) {}

        var ball = Ball.from(0, symbol: symbol);

        expect(ball.symbol(), expectSymbol);
      });
    });

    test('Ball status', () {
      var index = 0;
      var balls =
          BallState.values.map((value) => Ball(index++, value)).toList();

      var ballIsWeighted = [false, true, true, true];
      var ballSymbols = ["?", "↑", "↓", "-"];

      balls.forEach((item) {
        print(
            'ball[${item.index}] is weighted = ${item.isWeighted()}, symbol=${item.symbol()}');
        expect(item.isWeighted(), ballIsWeighted[item.index]);
        expect(item.symbol(), ballSymbols[item.index]);
      });
    });

    test('defalut value', () {
      var ball = Ball(100);
      print("Ball defalut is weighted=${ball.isWeighted()}");
      expect(ball.isWeighted(), false);
    });

    test('apply status', () {
      var statusChanges = [
        [BallState.unknown, BallState.unknown, BallState.unknown],
        [BallState.unknown, BallState.good, BallState.good],
        [
          BallState.unknown,
          BallState.possiblyHeavier,
          BallState.possiblyHeavier
        ],
        [
          BallState.unknown,
          BallState.possiblyLighter,
          BallState.possiblyLighter
        ],
        [BallState.possiblyLighter, BallState.possiblyHeavier, BallState.good],
        [
          BallState.possiblyLighter,
          BallState.possiblyLighter,
          BallState.possiblyLighter
        ],
        [BallState.possiblyLighter, BallState.good, BallState.good],
        [
          BallState.possiblyLighter,
          BallState.unknown,
          BallState.possiblyLighter
        ],
        [BallState.possiblyHeavier, BallState.possiblyLighter, BallState.good],
        [
          BallState.possiblyHeavier,
          BallState.possiblyHeavier,
          BallState.possiblyHeavier
        ],
        [BallState.possiblyHeavier, BallState.good, BallState.good],
        [
          BallState.possiblyHeavier,
          BallState.unknown,
          BallState.possiblyHeavier
        ],
        [BallState.good, BallState.possiblyLighter, BallState.good],
        [BallState.good, BallState.possiblyHeavier, BallState.good],
        [BallState.good, BallState.good, BallState.good],
        [BallState.good, BallState.unknown, BallState.good],
      ];

      statusChanges.forEach((statusChange) {
        var ball = Ball(0, statusChange[0]);
        ball.applyStatus(statusChange[1]);
        print(
            "${Ball.stateSymbol(statusChange[0])} apply ${Ball.stateSymbol(statusChange[1])} should become ${Ball.stateSymbol(statusChange[2])} ");
        expect(ball.state, statusChange[2]);
      });
    });
  });

  group('Balls tests', () {
    test("init with number of balls", () {
      var quiz = Quiz(12);
      expect(quiz.description(), "????????????");
    });

    test("init balls from symbols", () {
      var initSymbols = [
        "?↑↓???????????-",
        "--↑↑↑↑↓↓↓↓????-",
        "???↑↑↑↑?????-",
        "↑↑↑↑↑↑↑↑↑↑",
        "↑↑↑↑↑↑↓↓??↓↓??↓↓??",
      ];

      initSymbols.forEach((symbols) {
        var quiz = Balls.from(symbols: symbols);
        expect(quiz.description(), symbols);
      });
    });

    test("applyWeighting", () {
      var applyWeightingData = [
        [
          "????????????",
          [0, 1, 2],
          [3, 4],
          BallState.unknown,
          "????????????"
        ],
        [
          "????????????",
          [0, 1, 2],
          [3, 4],
          BallState.possiblyHeavier,
          "????????????"
        ],
        [
          "????????????",
          [0, 1, 2],
          [3, 4],
          BallState.possiblyLighter,
          "????????????"
        ],
        [
          "????????????",
          [0, 1, 2],
          [3, 4],
          BallState.good,
          "????????????"
        ],
        [
          "????????????",
          [0, 1],
          [3, 4],
          BallState.unknown,
          "????????????"
        ],
        [
          "????????????",
          [0, 1],
          [3, 4],
          BallState.possiblyHeavier,
          "↓↓-↑↑-------"
        ],
        [
          "????????????",
          [0, 1],
          [3, 4],
          BallState.possiblyLighter,
          "↑↑-↓↓-------"
        ],
        [
          "????????????",
          [0, 1],
          [3, 4],
          BallState.good,
          "--?--???????"
        ],
        [
          "????????????",
          [0, 1, 2],
          [3, 4, 5],
          BallState.unknown,
          "????????????"
        ],
        [
          "????????????",
          [0, 1, 2],
          [3, 4, 5],
          BallState.possiblyLighter,
          "↑↑↑↓↓↓------"
        ],
        [
          "????????????",
          [0, 1, 2],
          [3, 4, 5],
          BallState.possiblyHeavier,
          "↓↓↓↑↑↑------"
        ],
        [
          "????????????",
          [0, 1, 2],
          [3, 4, 5],
          BallState.good,
          "------??????"
        ],
        [
          "↓↓-↑↑-------",
          [0, 1],
          [3, 4],
          BallState.possiblyLighter,
          "------------"
        ],
        [
          "↓↓↑",
          [0],
          [1],
          BallState.possiblyLighter,
          "-↓-"
        ],
      ];

      applyWeightingData.forEach((data) {
        var quiz = Balls.from(symbols: data[0]);
        quiz.applyWeighting(data[1], data[2], leftGroupState: data[3]);
        if (quiz.description() != data[4]) {
          print("expect: ${data[4]}, got: ${quiz.description()}");
        }
        expect(quiz.description(), data[4]);
      });
    });

    test("Balls state group", () {
      var data = [
        [
          "",
          [0, 0, 0, 0]
        ],
        [
          "?",
          [1, 0, 0, 0]
        ],
        [
          "?-",
          [1, 0, 0, 1]
        ],
        [
          "↑↑↑",
          [0, 3, 0, 0]
        ],
        [
          "↓↓↓",
          [0, 0, 3, 0]
        ],
        [
          "↑↑↑↓↓↓",
          [0, 3, 3, 0]
        ],
        [
          "↑↑↑↓↓↓---",
          [0, 3, 3, 3]
        ],
        [
          "???",
          [3, 0, 0, 0]
        ],
        [
          "????-",
          [4, 0, 0, 1]
        ],
        [
          "↓↓↓↓↓↓↓↓↓",
          [0, 0, 9, 0]
        ],
        [
          "????????????",
          [12, 0, 0, 0]
        ],
      ];

      data.forEach((data) {
        var quiz = Balls.from(symbols: data[0]);

        if (!eq(quiz.stateGroup(), data[1])) {
          print(
              "quiz: ${quiz.description()}, stateGroup should be: ${data[1]}, got: ${quiz.stateGroup()}");
          expect(quiz.stateGroup(), data[1]);
        }
      });
    });
  });

  group('Quiz tests', () {
    test("result", () {
      var data = [
        ["????????????", null],
        ["?????????????-", null],
        ["?????????????-", null],
        ["----↑---↑-", null],
        [
          "--------↑-",
          [8, "↑"]
        ],
        [
          "--↓-------",
          [2, "↓"]
        ],
        ["?-↑-------", null],
        ["-↑-------?", null],
        ["-↑--↓----?", null],
        [
          "--↑-------",
          [2, "↑"]
        ],
      ];

      data.forEach((data) {
        var quiz = Quiz.from(symbols: data[0]);
        var resultBall = quiz.result;

        var resultArray =
            resultBall == null ? null : [resultBall.index, resultBall.symbol()];

        if (!eq(resultArray, data[1])) {
          print(
              "quiz: ${quiz.description()}, result should be: ${data[1]}, got: $resultArray");
          expect(resultArray, data[1]);
        }
      });
    });
  });
}
