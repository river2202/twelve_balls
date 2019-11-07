import 'package:flutter/material.dart';

import 'package:twelve_balls/Model/Ball.dart';

typedef ClickedBallCallback = void Function(Ball ball, BuildContext context);

class BallView extends StatelessWidget {
  final double _radius = 25;
  final Ball _ball;
  final bool selected;
  final ClickedBallCallback _onClickedBall;
  final bool showIndex;

  BallView(this._ball, this._onClickedBall,
      {this.selected = false, this.showIndex = false, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: selected
          ? null
          : () {
              _onClickedBall(_ball, context);
            },
      child: _ballView(),
    );
  }

  _getChildren() {
    var c = <Widget>[
      CircleAvatar(
        backgroundColor: Colors.blueAccent,
        radius: _radius,
        child: Text(
          "${_ball.symbol()}",
          style: TextStyle(
              fontSize: _radius,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    ];

    if (this.showIndex) {
      c.add(Positioned(
          right: 0.0,
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: _radius / 3,
            child: Text(
              "${_ball.index + 1}",
              style: TextStyle(
                  fontSize: _radius / 2,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          )));
    }

    return c;
  }

  _ballView() {
    return Opacity(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: _getChildren(),
        ),
        opacity: selected ? 0.45 : 1.0);
  }
}
