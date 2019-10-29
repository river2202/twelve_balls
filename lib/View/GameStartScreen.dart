import 'package:flutter/material.dart';
import 'package:twelve_balls/Model/Ball.dart';
import 'package:twelve_balls/View/TwelveBallsQuiz.dart';
import 'BallView.dart';
import 'SizeConfig.dart';

class GameStartScreen extends StatefulWidget {
  GameStartScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GameStartScreenState createState() => _GameStartScreenState();
}

_startGame(BuildContext context) {
  Navigator.push(
    context,
    new MaterialPageRoute(builder: (context) => new TwelveBallsQuizPage()),
  );
}

class _GameStartScreenState extends State<GameStartScreen> {
  String name;
  _GameStartScreenState() {
    name = "12 Balls";
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var _scaffold = Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          GestureDetector(
            onTap: () => _startGame(context),
            child: Container(
              color: Colors.white,
            ),
          ),
          buildMinion(0),
          buildMinion(240),
          buildMinion(120),
          buildMinion(0, alignment: Alignment.center),
        ],
      ),
    );

    return MaterialApp(
      title: '12 Balls',
      home: _scaffold,
    );
  }

  Center buildMinion(double angle,
      {Alignment alignment = Alignment.bottomLeft}) {
    return Center(
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(angle / 360),
        child: AnimatedContainer(
          child: BallView(Ball(0), (ball, context) => _startGame(context)),
          height: SizeConfig.blockSizeVertical * 25,
          width: SizeConfig.blockSizeVertical * 25,
          duration: Duration(milliseconds: 5000),
          alignment: alignment,
        ),
      ),
    );
  }
}
