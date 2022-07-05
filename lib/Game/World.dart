import 'dart:math';
import 'dart:ui';

class World {
  World();

  late Size screenSize;

  late double ballSize;
  late Rect ballGroup;
  late Rect scale;
  late Rect leftScale;
  late Rect rightScale;
  late Rect historyBar;

  void init(Size screenSize) {
    this.screenSize = screenSize;

    ballSize = min(screenSize.width / 7, screenSize.height / 10);
    final width = ballSize * 6;

    // balls
    final ballGroupCenter =
        Offset(screenSize.width / 2, screenSize.height * 1 / 10);
    ballGroup = Rect.fromCenter(
        center: ballGroupCenter,
        width: width,
        height: screenSize.height * 2 / 10);

    // scale
    final scaleCenter =
        Offset(screenSize.width / 2, screenSize.height * 5 / 10);
    scale = Rect.fromCenter(
        center: scaleCenter,
        width: width / 2,
        height: screenSize.height * 3 / 10);

    final scaleLeftCenter =
        Offset(screenSize.width / 2 - width / 4, screenSize.height * 5 / 10);
    leftScale = Rect.fromCenter(
        center: scaleLeftCenter,
        width: width / 2,
        height: screenSize.height * 6 / 10);

    final scaleRightCenter =
        Offset(screenSize.width / 2 + width / 4, screenSize.height * 5 / 10);
    rightScale = Rect.fromCenter(
        center: scaleRightCenter,
        width: width / 2,
        height: screenSize.height * 6 / 10);

    // history bar
    final historyBarCenter =
        Offset(screenSize.width / 2, screenSize.height * 8.5 / 10);
    historyBar = Rect.fromCenter(
        center: historyBarCenter, width: width, height: screenSize.height / 10);
  }
}
