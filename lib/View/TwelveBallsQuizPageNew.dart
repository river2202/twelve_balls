import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'BallGroupView.dart';
import 'BallView.dart';
import 'TwelveBallsQuizStateProvider.dart';

typedef HistoryStepTapped = void Function(int);

class TwelveBallsQuizPageNew extends ConsumerWidget {
  static const candidateBallGroupViewKey = Key("candidateBallGroupViewKey");
  static const leftBallGroupViewKey = Key("leftBallGroupViewKey");
  static const rightBallGroupViewKey = Key("rightBallGroupViewKey");
  static const historyStepGroupViewKey = Key("historyStepGroupViewKey");

  static const errMsgSelectSameNumberBall = "Select same balls for both side";
  static const errMsgApplyResult = "Please apply reslut before next step.";

  const TwelveBallsQuizPageNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(twelveBallsQuizStateProvider.notifier);
    final state = ref.watch(twelveBallsQuizStateProvider);

    var candidateBallViews = state.quiz.balls
        .map((ball) => BallView(ball, (ball, _) => vm.clickCandidateBall(ball),
            selected: state.quiz.isBallSeleced(ball.index),
            key: Key("${ball.index}")))
        .toList();

    var leftBallViews = state.quiz.leftGroup
        .map((index) => BallView(
            state.quiz.balls[index], (ball, _) => vm.clickLeftGroupBall(ball),
            key: Key("$index")))
        .toList();

    var rightBallViews = state.quiz.rightGroup
        .map((index) => BallView(
            state.quiz.balls[index], (ball, _) => vm.clickRightGroupBall(ball),
            key: Key("$index")))
        .toList();

    var _scaffold = Scaffold(
      body: Builder(
        builder: (context) => new Column(
          children: <Widget>[
            Container(
              height: 68.0,
            ),
            BallGroupView(
                key: candidateBallGroupViewKey, ballViews: candidateBallViews),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: new BallGroupView(
                        key: leftBallGroupViewKey,
                        ballViews: leftBallViews,
                        onClicked: vm.clickLeftGroup,
                        selected: state.leftGroupSelected,
                        reverseDirection: true,
                        groupBallState: state.quiz.leftGroupState),
                  ),
                  Expanded(
                    child: new BallGroupView(
                        key: rightBallGroupViewKey,
                        ballViews: rightBallViews,
                        onClicked: vm.clickRightGroup,
                        selected: state.rightGroupSelected,
                        reverseDirection: true,
                        groupBallState: state.quiz.rightGroupState),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildRaisedButton(
                    vm.doWeighting,
                    state.weightButtonType,
                  ),
                ),
                getHistoryRow(state.history.length + 1,
                    state.historyActiveIndex, vm.onHistoryTap),
              ],
            ),
          ],
        ),
      ),
    );

    return MaterialApp(
      title: '12 Balls',
      home: _scaffold,
    );
  }

  RaisedButton _buildRaisedButton(
    VoidCallback callback,
    WeightingButtonType buttonType,
  ) {
    final buttonTexts = {
      WeightingButtonType.loading: "Loading",
      WeightingButtonType.weight: "Weight",
      WeightingButtonType.apply: "Apply",
    };

    final buttonColors = {
      WeightingButtonType.loading: Colors.grey,
      WeightingButtonType.weight: Colors.blue,
      WeightingButtonType.apply: Colors.red,
    };
    return RaisedButton(
      color: buttonColors[buttonType],
      child: Text(buttonTexts[buttonType] ?? ''),
      onPressed: callback,
    );
  }

  Widget getHistoryRow(int length, int activeIndex, HistoryStepTapped onTap) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
          key: historyStepGroupViewKey,
          spacing: 5.0,
          alignment: WrapAlignment.end,
          children: [
            for (int i = 0; i < length; i++)
              _getView(i, activeIndex == i, onTap),
          ]),
    ));
  }

  static const double _radius = 15;
  static const int minimumStep = 3;

  _getView(int index, bool active, HistoryStepTapped onTap) {
    var color = active ? Colors.blue : Colors.grey;
    var title = "${minimumStep - index}";
    var key = Key("$index");

    var circle = new CircleAvatar(
      key: key,
      backgroundColor: color,
      radius: _radius,
      child: Text(
        title,
        style: TextStyle(
            fontSize: _radius,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
    );
    return GestureDetector(
      onTap: () => active ? null : onTap(index),
      child: circle,
    );
  }
}
