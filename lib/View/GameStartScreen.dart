import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twelve_balls/Game/World.dart';
import 'package:twelve_balls/View/GamePlayScreen.dart';

import 'SizeConfig.dart';

class GameStartScreen extends ConsumerWidget {
  GameStartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sizeConfig = SizeConfig(context);
    ref.read(worldProvider).init(MediaQuery.of(context).size);

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
          buildMinion(sizeConfig, 0),
          buildMinion(sizeConfig, 240),
          buildMinion(sizeConfig, 120),
          buildMinion(sizeConfig, 0, alignment: Alignment.center),
        ],
      ),
    );

    return _scaffold;
  }

  Center buildMinion(SizeConfig sizeConfig, double angle,
      {Alignment alignment = Alignment.bottomLeft}) {
    return Center(
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(angle / 360),
        child: AnimatedContainer(
          child: buildCircle(50),
          height: sizeConfig.blockSizeVertical * 25,
          width: sizeConfig.blockSizeVertical * 25,
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

_startGame(BuildContext context) {
  Navigator.push(
    context,
    new MaterialPageRoute(builder: (context) => new GamePlayScreen()),
  );
}
