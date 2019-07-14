import 'package:test/test.dart';
import 'package:twelve_balls/Ball.dart';
import 'package:twelve_balls/Balls.dart';
import 'package:collection/collection.dart';

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
      var balls = State.values.map((value) => Ball(index++, value)).toList();

      var ballIsWeighted = [false, true, true, true];
      var ballSymbols = ["?", "↑", "↓", "-"];

      balls.forEach((item) {
        print('ball[${item.index}] is weighted = ${item.isWeighted()}, symbol=${item.symbol()}');
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
        [State.unknown, State.unknown, State.unknown],
        [State.unknown, State.good, State.good],
        [State.unknown, State.possiblyHeavier, State.possiblyHeavier],
        [State.unknown, State.possiblyLighter, State.possiblyLighter],

        [State.possiblyLighter, State.possiblyHeavier, State.good],
        [State.possiblyLighter, State.possiblyLighter, State.possiblyLighter],
        [State.possiblyLighter, State.good, State.good],
        [State.possiblyLighter, State.unknown, State.possiblyLighter],

        [State.possiblyHeavier, State.possiblyLighter, State.good],
        [State.possiblyHeavier, State.possiblyHeavier, State.possiblyHeavier],
        [State.possiblyHeavier, State.good, State.good],
        [State.possiblyHeavier, State.unknown, State.possiblyHeavier],

        [State.good, State.possiblyLighter, State.good],
        [State.good, State.possiblyHeavier, State.good],
        [State.good, State.good, State.good],
        [State.good, State.unknown, State.good],
      ];

      statusChanges.forEach((statusChange) {
        var ball = Ball(0, statusChange[0]);
        ball.applyStatus(statusChange[1]);
        print("${Ball.stateSymbol(statusChange[0])} apply ${Ball.stateSymbol(statusChange[1])} should become ${Ball.stateSymbol(statusChange[2])} ");
        expect(ball.state, statusChange[2]);
      });
    });
  });

  group('Quiz tests', () {
    test("init quiz with number", () {
      var quiz = Balls(12);
      expect(quiz.description(), "????????????");
    });

    test("init quiz from symbols", () {
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
        ["????????????", [0,1,2], [3,4], State.unknown, "????????????"],
        ["????????????", [0,1,2], [3,4], State.possiblyHeavier, "????????????"],
        ["????????????", [0,1,2], [3,4], State.possiblyLighter, "????????????"],
        ["????????????", [0,1,2], [3,4], State.good, "????????????"],
        ["????????????", [0,1], [3,4], State.unknown, "????????????"],
        ["????????????", [0,1], [3,4], State.possiblyHeavier, "↓↓-↑↑-------"],
        ["????????????", [0,1], [3,4], State.possiblyLighter, "↑↑-↓↓-------"],
        ["????????????", [0,1], [3,4], State.good, "--?--???????"],
        ["????????????", [0,1,2], [3,4,5], State.unknown, "????????????"],
        ["????????????", [0,1,2], [3,4,5], State.possiblyLighter, "↑↑↑↓↓↓------"],
        ["????????????", [0,1,2], [3,4,5], State.possiblyHeavier, "↓↓↓↑↑↑------"],
        ["????????????", [0,1,2], [3,4,5], State.good, "------??????"],
        ["↓↓-↑↑-------", [0,1], [3,4], State.possiblyLighter, "------------"],
        ["↓↓↑", [0], [1], State.possiblyLighter, "-↓-"],
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
        ["",   [0,0,0,0]],

        ["?",  [1,0,0,0]],
        ["?-", [1,0,0,1]],
        ["↑↑↑",[0,3,0,0]],
        ["↓↓↓",[0,0,3,0]],
        ["↑↑↑↓↓↓",[0,3,3,0]],
        ["↑↑↑↓↓↓---",[0,3,3,3]],

        ["???",   [3,0,0,0]],
        ["????-", [4,0,0,1]],
        ["↓↓↓↓↓↓↓↓↓", [0,0,9,0]],

        ["????????????", [12,0,0,0]],
      ];

      data.forEach((data) {
        var quiz = Balls.from(symbols: data[0]);

        if (!DeepCollectionEquality().equals(quiz.stateGroup(), data[1])) {
          print("quiz: ${quiz.description()}, stateGroup should be: ${data[1]}, got: ${quiz.stateGroup()}");
          expect(quiz.stateGroup(), data[1]);
        }
      });

    });

    test("Step left for quiz", () {
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
      ];

      data.forEach((data) {
        var quiz = Balls.from(symbols: data[0]);

        if (quiz.stepsLeft() != data[1]) {
          print("quiz: ${quiz.description()}, steps should be: ${data[1]}, got: ${quiz.stepsLeft()}");
          expect(quiz.stepsLeft(), data[1]);
        }
      });

    });
  });
}