import 'package:flutter/material.dart';
import 'package:twelve_balls/Model/Ball.dart';
import 'package:twelve_balls/Model/WeightingStep.dart';
import 'package:twelve_balls/View/BallGroupView.dart';
import 'package:twelve_balls/View/BallView.dart';

import 'TwelveBallsQuizPageVM.dart';

// Plan:
// - Done: move data and logic to TwelveBallsQuizVM - fast done, just for demo
//    benefit - can unit test VM and easier to exhaust all edge cases
//    benefit - can use mock VM to have screenshot of all state of TwelveBallsQuizPage
// - Skip: add unit test for TwelveBallsQuizVM and test most cases
// - Skip: mock and golden test most state of TwelveBallsQuizPage with mock vm
//    have to fast forward otherwise can't finish in time
// - done: add riverpod and freezed
// - Todo: refactor to state - declarative way
//    problem for vm: allow error state and logic is not clear enough
// - Todo: unit test TwelveBallsQuizVMProvider

class TwelveBallsQuizPage extends StatefulWidget {
  static const candidateBallGroupViewKey = Key("candidateBallGroupViewKey");
  static const leftBallGroupViewKey = Key("leftBallGroupViewKey");
  static const rightBallGroupViewKey = Key("rightBallGroupViewKey");
  static const historyStepGroupViewKey = Key("historyStepGroupViewKey");

  static const errMsgSelectSameNumberBall = "Select same balls for both side";
  static const errMsgApplyResult = "Please apply reslut before next step.";

  TwelveBallsQuizPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TwelveBallsQuizPageState createState() => _TwelveBallsQuizPageState();
}

enum QuizPageStatus {
  loading,
  applying,
  resetting,
  success,
  fail,
}

class _TwelveBallsQuizPageState extends State<TwelveBallsQuizPage> {
  TwelveBallsQuizVM vm = TwelveBallsQuizVM();

  _TwelveBallsQuizPageState() {}

  _showSnackBarMessage(String message, BuildContext context) {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(message),
    ));
  }

  _checkResult() {
    if (vm.activeQuizSolved()) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: new Text("Nice, you solve one branch of puzzle."),
                content: new Text("Use puzzle pannel to solve other branches."),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
    }
  }

  _setState() => setState(() {});

  void _doWeighting(BuildContext context) {
    if (vm.weightResult() == BallState.unknown) {
      if (vm.isReadyToWeight()) {
        var _weightResults = vm.activeQuiz
            .getWorstWeightingResult(vm.leftIndex(), vm.rightIndex());
        if (_weightResults.length > 0) {
          vm.activeQuiz.leftGroupState = _weightResults.first;
          print("_weightResult: ${vm.weightResult()}");

          // todo: move this animation to widget
          if (vm.weightResult() == BallState.good) {
            vm.activeQuiz.leftGroupState = BallState.possiblyHeavier;
            Future.delayed(const Duration(milliseconds: 250), () {
              vm.activeQuiz.leftGroupState = BallState.possiblyLighter;
              setState(() {});

              Future.delayed(const Duration(milliseconds: 350), () {
                vm.activeQuiz.leftGroupState = BallState.good;
                setState(() {});
              });
            });
          }
          setState(() {});
        } else {
          _showSnackBarMessage("No result!", context);
        }
      } else {
        _showSnackBarMessage(
            TwelveBallsQuizPage.errMsgSelectSameNumberBall, context);
      }
    } else {
      if (vm.history.contains(vm.activeQuiz)) {
        var index = vm.history.indexOf(vm.activeQuiz);
        vm.history.removeRange(index, vm.history.length);
        vm.quiz = WeightingStep.from(vm.activeQuiz);
        vm.setActiveQuiz(vm.quiz);
      }

      vm.history.add(WeightingStep.from(vm.activeQuiz));
      // Apply and check
      vm.activeQuiz.doWeighting();
      vm.activeGroup = vm.activeQuiz.leftGroup;
      _setState();
      _checkResult();
    }
  }

  void _clickCandidateBall(Ball ball, BuildContext context) {
    vm.clickCandidateBall(ball);
    setState(() {});
  }

  void _clickLeftGroupBall(Ball ball, BuildContext context) {
    vm.clickLeftGroupBall(ball);
    setState(() {});
  }

  void _clickRightGroupBall(Ball ball, BuildContext context) {
    vm.clickRightGroupBall(ball);
    setState(() {});
  }

  void _clickLeftGroup() {
    print("Select Left Group");
    vm.clickLeftGroup();
    setState(() {});
  }

  void _clickRightGroup() {
    print("Select Right Group");
    vm.clickRightGroup();
    setState(() {});
  }

  _historyStepTapped(WeightingStep? historyStep) {
    vm.setActiveQuiz(historyStep);
    _setState();
  }

  Color _getWeightButtonColor() {
    if (vm.weightResult() == BallState.unknown) {
      return vm.isReadyToWeight() ? Colors.blue : Colors.grey;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    var candidateBallViews = vm.activeQuiz.balls
        .map((ball) => BallView(ball, _clickCandidateBall,
            selected: vm.isBallSeleced(ball), key: Key("${ball.index}")))
        .toList();

    var leftBallViews = vm.activeQuiz.leftGroup
        .map((index) => BallView(
            vm.activeQuiz.balls[index], _clickLeftGroupBall,
            key: Key("$index")))
        .toList();

    var rightBallViews = vm.activeQuiz.rightGroup
        .map((index) => BallView(
            vm.activeQuiz.balls[index], _clickRightGroupBall,
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
                key: TwelveBallsQuizPage.candidateBallGroupViewKey,
                ballViews: candidateBallViews),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: new BallGroupView(
                        key: TwelveBallsQuizPage.leftBallGroupViewKey,
                        ballViews: leftBallViews,
                        onClicked: _clickLeftGroup,
                        selected: vm.activeGroup == vm.activeQuiz.leftGroup,
                        reverseDirection: true,
                        groupBallState: vm.getLeftWeightResult()),
                  ),
                  Expanded(
                    child: new BallGroupView(
                        key: TwelveBallsQuizPage.rightBallGroupViewKey,
                        ballViews: rightBallViews,
                        onClicked: _clickRightGroup,
                        selected: vm.activeGroup == vm.activeQuiz.rightGroup,
                        reverseDirection: true,
                        groupBallState: vm.getRightWeightResult()),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    color: _getWeightButtonColor(),
                    onPressed: () => _doWeighting(context),
                    child: Text(vm.getWeightButtonText()),
                  ),
                ),
                getHistoryRow(activeStep: vm.activeQuiz),
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

  Widget getHistoryRow({WeightingStep? activeStep}) {
    int length = vm.history.length;
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
          key: TwelveBallsQuizPage.historyStepGroupViewKey,
          spacing: 5.0,
          alignment: WrapAlignment.end,
          children: [
            for (int i = 0; i < length; i++)
              _getView(vm.history[i], i, activeStep == vm.history[i]),
            _getView(null, length, !vm.history.contains(activeStep))
          ]),
    ));
  }

  static const double _radius = 15;
  static const int minimumStep = 3;

  _getView(WeightingStep? step, int index, bool active) {
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
      onTap: () => _historyStepTapped(step),
      child: circle,
    );
  }
}
