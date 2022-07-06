import 'package:flutter/material.dart';
import 'package:twelve_balls/Model/Ball.dart';
import 'package:twelve_balls/Model/WeightingStep.dart';
import 'package:twelve_balls/View/BallGroupView.dart';
import 'package:twelve_balls/View/BallView.dart';

// Todo:
// - move data and logic to TwelveBallsQuizVM
// - add riverpod and freezed
// - refactor to state
// - unit test TwelveBallsQuizVMProvider
// - mock and golden test most state of TwelveBallsQuizPage

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
  WeightingStep _quiz = WeightingStep(12);
  WeightingStep? _historyStep;
  late List<int> activeGroup;

  WeightingStep get activeQuiz => _historyStep ?? _quiz;
  _setActiveQuiz(WeightingStep value) {
    _historyStep = value;
  }

  _TwelveBallsQuizPageState() {
    _setActiveQuiz(_quiz);
    activeGroup = activeQuiz.leftGroup;
  }

  _leftIndex() {
    return activeQuiz.leftGroup;
  }

  _rightIndex() {
    return activeQuiz.rightGroup;
  }

  _weightResult() {
    return activeQuiz.leftGroupState;
  }

  _showSnackBarMessage(String message, BuildContext context) {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(message),
    ));
  }

  _checkResult() {
    if (activeQuiz.solved) {
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

  void _doWeighting(BuildContext context) {
    if (_weightResult() == BallState.unknown) {
      if (_isReadyToWeight()) {
        var _weightResults =
            activeQuiz.getWorstWeightingResult(_leftIndex(), _rightIndex());
        if (_weightResults.length > 0) {
          activeQuiz.leftGroupState = _weightResults.first;
          print("_weightResult: $_weightResult");

          // todo: move this animation to widget
          if (_weightResult() == BallState.good) {
            activeQuiz.leftGroupState = BallState.possiblyHeavier;
            Future.delayed(const Duration(milliseconds: 250), () {
              activeQuiz.leftGroupState = BallState.possiblyLighter;
              setState(() {});

              Future.delayed(const Duration(milliseconds: 350), () {
                activeQuiz.leftGroupState = BallState.good;
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
      if (history.contains(activeQuiz)) {
        var index = history.indexOf(activeQuiz);
        history.removeRange(index, history.length);
        _quiz = WeightingStep.from(activeQuiz);
//        activeQuiz = _quiz;
        _setActiveQuiz(_quiz);
      }

      history.add(WeightingStep.from(activeQuiz));
      // Apply and check
      activeQuiz.doWeighting();
      activeGroup = activeQuiz.leftGroup;
      _setState();
      _checkResult();
    }
  }

  _setLoading() {
    activeQuiz.leftGroupState = BallState.unknown;
  }

  void _clickCandidateBall(Ball ball, BuildContext context) {
    _setLoading();

    if (activeGroup.indexOf(ball.index) < 0) {
      activeGroup.add(ball.index);
      activeGroup.sort((a, b) => b.compareTo(a));
    }
    setState(() {});
  }

  void _clickLeftGroupBall(Ball ball, BuildContext context) {
    _setLoading();

    activeQuiz.leftGroup.remove(ball.index);
    setState(() {});
  }

  void _clickRightGroupBall(Ball ball, BuildContext context) {
    _setLoading();

    activeQuiz.rightGroup.remove(ball.index);
    setState(() {});
  }

  void _clickLeftGroup() {
    print("Select Left Group");
    activeGroup = activeQuiz.leftGroup;
    setState(() {});
  }

  void _clickRightGroup() {
    print("Select Right Group");
    activeGroup = activeQuiz.rightGroup;
    setState(() {});
  }

  bool _isReadyToWeight() =>
      activeQuiz.leftGroup.length > 0 &&
      activeQuiz.leftGroup.length == activeQuiz.rightGroup.length;

  bool _isBallSeleced(Ball ball) =>
      activeQuiz.leftGroup.indexOf(ball.index) >= 0 ||
      activeQuiz.rightGroup.indexOf(ball.index) >= 0;

  BallState _getLeftWeightResult() {
    return _weightResult();
  }

  BallState _getRightWeightResult() {
    return Ball.getOppositeState(_weightResult());
  }

  String _getWeightButtonText() {
    if (_weightResult() == BallState.unknown) {
      return _isReadyToWeight() ? "Weight" : "Loading";
    } else {
      return "Apply";
    }
  }

  Color _getWeightButtonColor() {
    if (_weightResult() == BallState.unknown) {
      return _isReadyToWeight() ? Colors.blue : Colors.grey;
    } else {
      return Colors.red;
    }
  }

  _setState() => setState(() {});

  historyStepTapped(WeightingStep? historyStep) {
    _setActiveQuiz(historyStep ?? _quiz);
    _setState();
  }

  @override
  Widget build(BuildContext context) {
    var candidateBallViews = activeQuiz.balls
        .map((ball) => BallView(ball, _clickCandidateBall,
            selected: _isBallSeleced(ball), key: Key("${ball.index}")))
        .toList();

    var leftBallViews = activeQuiz.leftGroup
        .map((index) => BallView(activeQuiz.balls[index], _clickLeftGroupBall,
            key: Key("$index")))
        .toList();

    var rightBallViews = activeQuiz.rightGroup
        .map((index) => BallView(activeQuiz.balls[index], _clickRightGroupBall,
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
                        selected: activeGroup == activeQuiz.leftGroup,
                        reverseDirection: true,
                        groupBallState: _getLeftWeightResult()),
                  ),
                  Expanded(
                    child: new BallGroupView(
                        key: TwelveBallsQuizPage.rightBallGroupViewKey,
                        ballViews: rightBallViews,
                        onClicked: _clickRightGroup,
                        selected: activeGroup == activeQuiz.rightGroup,
                        reverseDirection: true,
                        groupBallState: _getRightWeightResult()),
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
                    child: Text(_getWeightButtonText()),
                  ),
                ),
                getHistoryRow(activeStep: activeQuiz),
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

  List<WeightingStep> history = [];
  double _radius = 15;
  int minimumStep = 3;

  addHistory(WeightingStep step) {
    history.add(step);
  }

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
      onTap: () => historyStepTapped(step),
      child: circle,
    );
  }

  Widget getHistoryRow({WeightingStep? activeStep}) {
    int length = history.length;
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
          key: TwelveBallsQuizPage.historyStepGroupViewKey,
          spacing: 5.0,
          alignment: WrapAlignment.end,
          children: [
            for (int i = 0; i < length; i++)
              _getView(history[i], i, activeStep == history[i]),
            _getView(null, length, !history.contains(activeStep))
          ]),
    ));
  }
}
