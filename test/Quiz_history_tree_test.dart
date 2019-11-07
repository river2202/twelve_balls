import 'package:test/test.dart';
import 'package:twelve_balls/Model/Ball.dart';
import 'package:twelve_balls/Model/Quiz.dart';
import 'package:collection/collection.dart';
import 'package:twelve_balls/Model/WeightingStep.dart';

Function eq = const ListEquality().equals;

void main() {
  group('Quiz history tree tests', () {
    test("Root history node", () {
      Step root = Step(Quiz(12));

      expect(root.solved, false);
      expect(root.results.length, 0);
      expect(root.leftGroup, null);
      expect(root.rightGroup, null);
      expect(root.leftGroupState, null);
    });

    test("Ball one weight step", () {
      var data = [
        [
          Step.from(
            Quiz(12),
            null,
            [1, 2, 3, 4],
            [1, 2, 3, 4],
            [],
          ),
          false,
          "1 - invalidate move",
        ],
        [
          Step.from(
            Quiz(12),
            null,
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [
              Step.from(Quiz.from(symbols: "-↑↑↑↑↓↓↓↓---"),
                  BallState.possiblyLighter, [], [], []),
              Step.from(Quiz.from(symbols: "?--------???"), BallState.good, [],
                  [], []),
            ],
          ),
          false,
          "2 - first move - good move",
        ],
        [
          Step.from(
            Quiz(12),
            null,
            [1, 2, 3],
            [5, 6, 7],
            [
              Step.from(Quiz.from(symbols: "?---?---????"), BallState.good, [],
                  [], [])
            ],
          ),
          false,
          "3 - first move with bad move",
        ],
        [
          Step.from(
            Quiz(12),
            null,
            [0, 1, 2, 3, 4],
            [5, 6, 7, 8, 9],
            [
              Step.from(Quiz.from(symbols: "↑↑↑↑↑↓↓↓↓↓--"),
                  BallState.possiblyLighter, [], [], [])
            ],
          ),
          false,
          "4 - first move with bad move",
        ],
        [
          Step.from(
            Quiz(12),
            null,
            [0, 1, 2, 3],
            [4, 5, 6, 7],
            [
              Step.from(Quiz.from(symbols: "↑↑↑↑↓↓↓↓----"),
                  BallState.possiblyLighter, [], [], []),
              Step.from(Quiz.from(symbols: "--------????"), BallState.good, [],
                  [], [])
            ],
          ),
          false,
          "5 - good move with different ball number",
        ],
        [
          Step.from(
            Quiz.from(symbols: "↑↑↑↑↓↓↓↓----"),
            null,
            [0, 1, 4],
            [2, 3, 6],
            [
              Step.from(Quiz.from(symbols: "↑↑----↓-----"),
                  BallState.possiblyLighter, [], [], []),
              Step.from(Quiz.from(symbols: "-----↓-↓----"), BallState.good, [],
                  [], []),
            ],
          ),
          false,
          "6 - second move",
        ],
        [
          Step.from(
            Quiz.from(symbols: "↑↑----↓-----"),
            null,
            [0],
            [1],
            [
              Step.from(Quiz.from(symbols: "↑-----------"),
                  BallState.possiblyLighter, [], [], [])
            ],
          ),
          true,
          "7 - step states are all passed (one direction ball left), so return just one equivalent.",
        ],
      ];

      data.forEach((dataItem) {
        Step item = dataItem[0];
        var step = Step(Quiz.from(symbols: item.quiz.description()));
        String message = dataItem[2];
        print("Testing test case: $message");

        step.act(item.leftGroup, item.rightGroup);

        expect(step.leftGroup, item.leftGroup);
        expect(step.rightGroup, item.rightGroup);
        expect(step.leftGroupState, item.leftGroupState);
        expect(step.solved, dataItem[1]);

        expect(step.results.length, item.results.length);
        for (int i = 0; i < step.results.length; i++) {
          expect(
              step.results[i].leftGroupState, item.results[i].leftGroupState);
          expect(step.results[i].quiz.description(),
              item.results[i].quiz.description());
        }
      });
    });
  });
}
