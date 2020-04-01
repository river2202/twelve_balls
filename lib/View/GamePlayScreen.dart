import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:twelve_balls/Model/Quiz.dart';

import 'BallGroupView.dart';
import 'BallView.dart';

class GamePlayScreen extends StatefulWidget {
  GamePlayScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GamePlayScreenState createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  String name;
  _GamePlayScreenState() {
    name = "12 Balls";
  }

  @override
  Widget build(BuildContext context) {
    var _scaffold = Scaffold(
      body: Builder(
        builder: (context) => SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildBallsView(),
              buildScale(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.pop(context);
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
    );

    return _scaffold;
  }

  bool isOpen = false;
  Widget buildScale() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isOpen = !isOpen;
        });
      },
      child: Container(
        color: Colors.black12,
        child: SizedBox.fromSize(
          child: FlareActor('assets/Scale.flr',
              animation: isOpen ? 'normal' : 'to normal'),
          size: Size(400.0, 300.0),
        ),
      ),
    );
  }

  Container buildBallsView() {
    var activeQuiz = Quiz(12);
    var candidateBallViews = activeQuiz.balls
        .map((ball) =>
            BallView(ball, null, selected: false, key: Key("${ball.index}")))
        .toList();

    var ballGroupView = Container(
      height: 250,
      child: BallGroupView(ballViews: candidateBallViews),
    );
    return ballGroupView;
  }
}
