// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:twelve_balls/View/BallView.dart';
import 'package:twelve_balls/View/TwelveBallsQuiz.dart';
import 'package:twelve_balls/main.dart';

import 'utils/TwelveBallsRobot.dart';
import 'utils/load_fonts.dart';

void main() {
  loadFonts();

  Finder _findBallView(Key groupKey, int? index) {
    if (index != null) {
      return find.descendant(
          of: find.byKey(groupKey), matching: find.byKey(Key("$index")));
    } else {
      return find.descendant(
          of: find.byKey(groupKey), matching: find.byType(BallView));
    }
  }

  Finder _candidateBall([int? index]) =>
      _findBallView(TwelveBallsQuizPage.candidateBallGroupViewKey, index);
  Finder _leftBall([int? index]) =>
      _findBallView(TwelveBallsQuizPage.leftBallGroupViewKey, index);
  Finder _rightBall([int? index]) =>
      _findBallView(TwelveBallsQuizPage.rightBallGroupViewKey, index);

  Widget getTwelveBallsQuizApp({bool newPage = true}) => ProviderScope(
        child: TwelveBallsQuizApp(),
        overrides: [
          testNewFeatureToggleProvider.overrideWithValue(newPage),
        ],
      );

  testWidgets('Select ball to weight', (WidgetTester tester) async {
    await tester.pumpWidget(getTwelveBallsQuizApp());
    expect(find.byKey(TwelveBallsQuizPage.candidateBallGroupViewKey),
        findsOneWidget);
    expect(
        find.byKey(TwelveBallsQuizPage.leftBallGroupViewKey), findsOneWidget);
    expect(
        find.byKey(TwelveBallsQuizPage.rightBallGroupViewKey), findsOneWidget);
    expect(
        find.descendant(
            of: find.byKey(TwelveBallsQuizPage.candidateBallGroupViewKey),
            matching: find.byKey(Key("1"))),
        findsOneWidget);

    expect(_candidateBall(1), findsOneWidget);
    expect(_leftBall(1), findsNothing);

    await tester.tap(_candidateBall(1));
    await tester.pump();

    expect(_candidateBall(1), findsOneWidget);
    expect(_leftBall(1), findsOneWidget,
        reason: "add ball to active group when click");

    await tester.tap(_candidateBall(1));
    await tester.pump();

    expect(_candidateBall(1), findsOneWidget);
    expect(_leftBall(1), findsOneWidget,
        reason: "should not add same ball twice");

    await tester.tap(_leftBall(1));
    await tester.pump();
    expect(_leftBall(1), findsNothing,
        reason: "Remove ball from left group when click");
  });

  testWidgets('Test selected ball backward ordered',
      (WidgetTester tester) async {
    await tester.pumpWidget(getTwelveBallsQuizApp());
    await tester.tap(_candidateBall(0));
    await tester.tap(_candidateBall(1));
    await tester.pump();

    var leftBalls = _leftBall();
    expect(leftBalls, findsNWidgets(2));
    expect(
        find.descendant(
            of: leftBalls.at(0),
            matchRoot: true,
            matching: find.byKey(Key("1"))),
        findsOneWidget);
    expect(
        find.descendant(
            of: leftBalls.at(1),
            matchRoot: true,
            matching: find.byKey(Key("0"))),
        findsOneWidget);

    await tester.tap(_leftBall(0));
    await tester.tap(_leftBall(1));
    await tester.pump();
    expect(leftBalls, findsNWidgets(0), reason: "unselect balls");

    await tester.tap(_candidateBall(1));
    await tester.tap(_candidateBall(0));
    await tester.pump();
    expect(leftBalls, findsNWidgets(2));
    expect(
        find.descendant(
            of: leftBalls.at(0),
            matchRoot: true,
            matching: find.byKey(Key("1"))),
        findsOneWidget,
        reason: "tap 1 then 0, shoudl get same order");
    expect(
        find.descendant(
            of: leftBalls.at(1),
            matchRoot: true,
            matching: find.byKey(Key("0"))),
        findsOneWidget,
        reason: "tap 1 then 0, shoudl get same order");
  });

  testWidgets('Test switch loading group', (WidgetTester tester) async {
    await tester.pumpWidget(getTwelveBallsQuizApp());
    await tester.tap(_candidateBall(0));
    await tester.tap(_candidateBall(1));

    await tester.tap(find.byKey(TwelveBallsQuizPage.rightBallGroupViewKey));
    await tester.tap(_candidateBall(2));
    await tester.pump();

    var leftBalls = _leftBall();
    expect(leftBalls, findsNWidgets(2),
        reason: "left group has 2 balls - 0 and 1");
    expect(
        find.descendant(
            of: leftBalls.at(0),
            matchRoot: true,
            matching: find.byKey(Key("1"))),
        findsOneWidget);
    expect(
        find.descendant(
            of: leftBalls.at(1),
            matchRoot: true,
            matching: find.byKey(Key("0"))),
        findsOneWidget);
    var rightBalls = _rightBall();
    expect(rightBalls, findsNWidgets(1), reason: "right group has 1 balls - 2");
    expect(
        find.descendant(
            of: rightBalls.at(0),
            matchRoot: true,
            matching: find.byKey(Key("2"))),
        findsOneWidget);

    await tester.tap(_candidateBall(0));
    await tester.tap(_candidateBall(1));
    await tester.tap(_candidateBall(2));
    await tester.pump();
    expect(leftBalls, findsNWidgets(2),
        reason: "tap selected balls, no change");
    expect(rightBalls, findsNWidgets(1));

    await tester.tap(_leftBall(0));
    await tester.tap(_leftBall(1));
    await tester.tap(_rightBall(2));
    await tester.pump();
    expect(leftBalls, findsNWidgets(0), reason: "unselected balls");
    expect(rightBalls, findsNWidgets(0));
  });

  testGoldens('Test apply weighting', (WidgetTester tester) async {
    var robot = TwelveBallsRobot(tester, getTwelveBallsQuizApp(newPage: false));
    await robot.startApp();
    robot.iSeeCandidateBalls("????????????");
    robot.iSeeHistorySteps(1);

    await robot.selectLeft();
    await robot.tapCandidate(0);
    await robot.tapCandidate(1);
    await robot.selectRight();
    await robot.tapCandidate(2);
    await robot.tapCandidate(3);
    await robot.doIt();

    robot
      ..iSeeCandidateBalls("????????????")
      ..iSeeLeftBalls("??")
      ..iSeeRightBalls("??");

    await robot.tapWeight();
    await robot.done();

    await robot.goldenTest("can see apply button");

    await robot.tapApply();
    await robot.doIt();
    robot
      ..iSeeCandidateBalls("----????????")
      ..iSeeHistorySteps(2)
      ..iSeeHistoryStepBackgroundColor(0, Colors.grey)
      ..iSeeHistoryStepBackgroundColor(1, Colors.blue)
      ..iSeeHistoryStepText(0, "3")
      ..iSeeHistoryStepText(1, "2");

    var step2 = () async {
      await robot.selectLeft();
      await robot.tapCandidate(4);
      await robot.tapCandidate(5);
      await robot.tapCandidate(6);
      await robot.tapCandidate(7);
      await robot.selectRight();
      await robot.tapCandidate(8);
      await robot.tapCandidate(9);
      await robot.tapCandidate(10);
      await robot.tapCandidate(11);
      await robot.doIt();

      robot
        ..iSeeCandidateBalls("----????????")
        ..iSeeLeftBalls("????")
        ..iSeeRightBalls("????");

      await robot.tapWeight();
      await robot.doIt();

      await robot.waitMs(600);

      await robot.tapApply();
      await robot.doIt();
      robot
        ..iSeeCandidateBalls("----↑↑↑↑↓↓↓↓")
        ..iSeeHistorySteps(3)
        ..iSeeHistoryStepBackgroundColor(0, Colors.grey)
        ..iSeeHistoryStepBackgroundColor(1, Colors.grey)
        ..iSeeHistoryStepBackgroundColor(2, Colors.blue)
        ..iSeeHistoryStepText(0, "3")
        ..iSeeHistoryStepText(1, "2")
        ..iSeeHistoryStepText(2, "1");
    };

    await step2();

    await robot.tapHistory(1);
    await robot.doIt();

    robot
      ..iSeeCandidateBalls("----????????")
      ..iSeeLeftBalls("????")
      ..iSeeRightBalls("????")
      ..iSeeHistorySteps(3)
      ..iSeeHistoryStepBackgroundColor(0, Colors.grey)
      ..iSeeHistoryStepBackgroundColor(1, Colors.blue)
      ..iSeeHistoryStepBackgroundColor(2, Colors.grey)
      ..iSeeHistoryStepText(0, "3")
      ..iSeeHistoryStepText(1, "2")
      ..iSeeHistoryStepText(2, "1");

    await robot.tapHistory(0);
    await robot.doIt();

    robot
      ..iSeeCandidateBalls("????????????")
      ..iSeeLeftBalls("??")
      ..iSeeRightBalls("??")
      ..iSeeHistorySteps(3)
      ..iSeeHistoryStepBackgroundColor(0, Colors.blue)
      ..iSeeHistoryStepBackgroundColor(1, Colors.grey)
      ..iSeeHistoryStepBackgroundColor(2, Colors.grey)
      ..iSeeHistoryStepText(0, "3")
      ..iSeeHistoryStepText(1, "2")
      ..iSeeHistoryStepText(2, "1");

    await robot.tapApply();
    await robot.doIt();

    robot
      ..iSeeCandidateBalls("----????????")
      ..iSeeHistorySteps(2)
      ..iSeeHistoryStepBackgroundColor(0, Colors.grey)
      ..iSeeHistoryStepBackgroundColor(1, Colors.blue)
      ..iSeeHistoryStepText(0, "3")
      ..iSeeHistoryStepText(1, "2");

    await step2();
  });

  // Done: 1. select ball and remove ball
  // Done: 2. switch loading group
  // Done: 3. Doing and Applying weighting
  // Done: 4. test history steps
  // Done: 4. resetting to history step
  // Todo: 5. UI tests 1. Robot pattern, 2. more test

  testGoldens('TwelveBalls Golden test', (tester) async {
    var robot = TwelveBallsRobot(tester, getTwelveBallsQuizApp());

    await robot.startApp();
    robot.iSeeCandidateBalls("????????????");
    robot.iSeeHistorySteps(1);
    await robot.goldenTest('first');

    await robot.selectLeft();
    await robot.tapCandidate(0);
    await robot.tapCandidate(1);
    await robot.selectRight();
    await robot.tapCandidate(2);
    await robot.tapCandidate(3);
    await robot.doIt();

    robot
      ..iSeeCandidateBalls("????????????")
      ..iSeeLeftBalls("??")
      ..iSeeRightBalls("??");

    await robot.goldenTest('second');
  });
}
