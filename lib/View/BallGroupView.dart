import 'package:flutter/material.dart';
import 'package:twelve_balls/Model/Ball.dart';

import 'BallView.dart';

typedef TapCallback = void Function();

class BallGroupView extends StatelessWidget {
  final List<BallView> ballViews;
  final TapCallback? onClicked;
  final bool selected;
  final BallState groupBallState;
  final bool reverseDirection;

  BallGroupView({
    Key? key,
    required this.ballViews,
    this.onClicked,
    this.selected = false,
    this.groupBallState = BallState.unknown,
    this.reverseDirection = false,
  }) : super(key: key);

  Alignment _getAlignment() {
    return [
      Alignment.center,
      Alignment.topCenter,
      Alignment.bottomCenter,
      Alignment.center
    ][groupBallState.index];
  }

  // _animate() {
  // todo: animation for equal, and left/right (up/down)
//    var _weightResult = groupBallState;
//
//    if(_weightResult == BallState.good) {
//      _weightResult = BallState.possiblyHeavier;
//      Future.delayed(const Duration(milliseconds: 250), () {
//        _weightResult = BallState.possiblyLighter;
//        setState(() {});
//
//        Future.delayed(const Duration(milliseconds: 350), () {
//          _weightResult = BallState.good;
//          setState(() {});
//        });
//      });
//    }
  // }

  @override
  Widget build(BuildContext context) {
    var wrap = new Wrap(
      alignment: WrapAlignment.center,
      spacing: 5.0, // gap between adjacent chips
      runSpacing: 5.0, // gap between lines
      verticalDirection:
          reverseDirection ? VerticalDirection.up : VerticalDirection.down,
      textDirection: reverseDirection ? TextDirection.rtl : TextDirection.ltr,
      children: ballViews,
    );

    var constraints = new BoxConstraints(
      minHeight: 250.0,
    );

    var container = new AnimatedContainer(
      padding: EdgeInsets.all(5),
      color: selected ? Colors.yellow : Colors.black26,
      alignment: _getAlignment(),
      constraints: onClicked != null ? constraints : null,
      child: wrap,
      duration: Duration(milliseconds: 500),
    );

    return GestureDetector(
      onTap: onClicked == null
          ? null
          : () {
              onClicked?.call();
            },
      child: container,
    );
  }
}
