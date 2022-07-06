import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'BallGroupView.dart';
import 'BallView.dart';
import 'TwelveBallsQuizStateProvider.dart';

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
            state.quiz.balls[index], (ball, _) => vm.clickLeftGroupBall,
            key: Key("$index")))
        .toList();

    var rightBallViews = state.quiz.rightGroup
        .map((index) => BallView(
            state.quiz.balls[index], (ball, _) => vm.clickRightGroupBall,
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: <Widget>[
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: RaisedButton(
            //         color: _getWeightButtonColor(),
            //         onPressed: () => _doWeighting(context),
            //         child: Text(vm.getWeightButtonText()),
            //       ),
            //     ),
            //     getHistoryRow(activeStep: vm.activeQuiz),
            //   ],
            // ),
          ],
        ),
      ),
    );

    return MaterialApp(
      title: '12 Balls',
      home: _scaffold,
    );
  }
}
