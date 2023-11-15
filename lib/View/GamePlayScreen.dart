import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twelve_balls/Game/World.dart';
import 'package:twelve_balls/Model/Quiz.dart';

import 'BallGroupView.dart';
import 'BallView.dart';

class GamePlayScreen extends ConsumerWidget {
  GamePlayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final world = ref.read(worldProvider);

    var _scaffold = Scaffold(
      body: Builder(
        builder: (context) => SafeArea(
          child: Stack(
            children: <Widget>[
              buildBallsView(world),
              buildScale(world.leftScale, Colors.green),
              buildScale(world.rightScale, Colors.red),
              buildScale(world.scale, Colors.orange),
              buildScale(world.historyBar, Colors.black),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
    );

    return _scaffold;
  }

  Widget buildScale(Rect rect, Color color) {
    return Positioned.fromRect(
      rect: rect,
      child: Container(
        color: color,
      ),
    );
  }

  Widget buildBallsView(World game) {
    var activeQuiz = Quiz(12);
    var candidateBallViews = activeQuiz.balls
        .map((ball) =>
            BallView(ball, null, selected: false, key: Key("${ball.index}")))
        .toList();

    var ballGroupView = Positioned(
      width: game.ballGroup.width,
      height: game.ballGroup.height,
      left: game.ballGroup.left,
      top: game.ballGroup.top,
      child: Container(
        height: game.ballGroup.height,
        child: BallGroupView(ballViews: candidateBallViews),
      ),
    );
    return ballGroupView;
  }
}
