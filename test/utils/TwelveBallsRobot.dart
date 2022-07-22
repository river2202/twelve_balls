import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:twelve_balls/View/BallView.dart';
import 'package:twelve_balls/View/TwelveBallsQuizPageOld.dart';

import 'threshold_file_comparator.dart';

typedef RobotCallback = void Function();

class Robot {
  WidgetTester tester;
  Widget get testTarget => _testTarget;
  Widget _testTarget;

  final _builder = DeviceBuilder()
    ..overrideDevicesForAllScenarios(devices: [Device.phone]);
  final _goldenComparer = GoldenComparer();

  Finder findWidgetInGroup(String groupKey, String key) {
    return find.descendant(
        of: find.byKey(Key(groupKey)), matching: find.byKey(Key(key)));
  }

  Robot(this.tester, this._testTarget);

  startApp() async {
    _builder.addScenario(
      widget: testTarget,
    );
    await tester.pumpDeviceBuilder(_builder);
    await tester.pumpWidget(_testTarget);
  }

  doing(RobotCallback it) async {
    it();
    await tester.pump();
  }

  doIt() async {
    await tester.pump();
  }

  done() async {
    await tester.pumpAndSettle();
  }

  waitMs(int milliseconds) async {
    await this.wait(Duration(milliseconds: milliseconds));
  }

  wait(Duration duration) async {
    await tester.pump(duration);
  }

  iSee(Finder item, int number) {
    expect(item, findsNWidgets(number));
  }

  findWidget(Key groupKey, int? index, Type type) {
    if (index != null) {
      return find.descendant(
          of: find.byKey(groupKey), matching: find.byKey(Key("$index")));
    } else {
      return find.descendant(
          of: find.byKey(groupKey), matching: find.byType(type));
    }
  }

  findText(Key groupKey, String text) {
    return find.descendant(of: find.byKey(groupKey), matching: find.text(text));
  }

  goldenTest(String name) async {
    await _goldenComparer.screenMatchesThreshold(
      tester,
      'goldens/$name',
      threshold: 0.005,
    );
  }
}

class TwelveBallsRobot extends Robot {
  TwelveBallsRobot(WidgetTester tester, Widget testTarget)
      : super(tester, testTarget);

  Finder _findBallView(Key groupKey, int? index) {
    return findWidget(groupKey, index, BallView);
  }

  Finder _candidateBall([int? index]) =>
      _findBallView(TwelveBallsQuizPage.candidateBallGroupViewKey, index);
  Finder _leftBall([int? index]) =>
      _findBallView(TwelveBallsQuizPage.leftBallGroupViewKey, index);
  Finder _rightBall([int? index]) =>
      _findBallView(TwelveBallsQuizPage.rightBallGroupViewKey, index);
  Finder historyStep([int? index]) => findWidget(
      TwelveBallsQuizPage.historyStepGroupViewKey, index, CircleAvatar);

  tapCandidate(int i) async => await tester.tap(_candidateBall(i));
  tapLeft(int i) async => await tester.tap(_leftBall(i));
  tapRight(int i) async => await tester.tap(_rightBall(i));
  tapWeight() async => await tester.tap(find.text("Weight"));
  tapApply() async => await tester.tap(find.text("Apply"));
  tapHistory(int i) async => await tester.tap(historyStep(i));

  selectLeft() async =>
      await tester.tap(find.byKey(TwelveBallsQuizPage.leftBallGroupViewKey));
  selectRight() async =>
      await tester.tap(find.byKey(TwelveBallsQuizPage.rightBallGroupViewKey));

  // expect
  iSeeCandidateBalls(String symbols) => _iSeeBalls(_candidateBall(), symbols);
  iSeeLeftBalls(String symbols) => _iSeeBalls(_leftBall(), symbols);
  iSeeRightBalls(String symbols) => _iSeeBalls(_rightBall(), symbols);

  void _iSeeBalls(Finder balls, String symbols) {
    expect(balls, findsNWidgets(symbols.runes.length));
    for (int i = 0; i < symbols.runes.length; i++) {
      var symbol = String.fromCharCode(symbols.runes.elementAt(i));

      expect(
          find.descendant(of: balls.at(i), matching: find.byKey(Key(symbol))),
          findsOneWidget);
    }
  }

  iSeeHistorySteps(int steps) {
    var historySteps = historyStep();
    iSee(historySteps, steps);
  }

  iSeeHistoryStepBackgroundColor(int index, Color backgroundColor) {
    var step = tester.firstWidget(historyStep(index)) as CircleAvatar;
    expect(step.backgroundColor, backgroundColor);
  }

  iSeeHistoryStepText(int index, String text) {
    var stepText = findText(TwelveBallsQuizPage.historyStepGroupViewKey, text);
    expect(stepText, findsOneWidget);
  }
}
