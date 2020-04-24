import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twelve_balls/Game/World.dart';
import 'package:twelve_balls/View/GamePlayScreen.dart';

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
    new MaterialPageRoute(builder: (context) => new GamePlayScreen()),
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

    final game = Provider.of<World>(context);
    game.init(MediaQuery.of(context).size);

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

    return _scaffold;
  }

  Center buildMinion(double angle,
      {Alignment alignment = Alignment.bottomLeft}) {
    return Center(
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(angle / 360),
        child: AnimatedContainer(
          child: buildCircle(50),
          height: SizeConfig.blockSizeVertical * 25,
          width: SizeConfig.blockSizeVertical * 25,
          duration: Duration(milliseconds: 5000),
          alignment: alignment,
        ),
      ),
    );
  }

  Widget buildCircle(double radius, {Color color = Colors.green}) {
    return CircleAvatar(
      backgroundColor: color,
      radius: radius,
    );
  }
}
