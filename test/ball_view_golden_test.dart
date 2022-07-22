import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:twelve_balls/Model/Ball.dart';
import 'package:twelve_balls/View/BallView.dart';

import 'utils/load_fonts.dart';

void main() {
  loadFonts();

  testGoldens('BallView Golden test', (tester) async {
    final builder = GoldenBuilder.grid(columns: 2, widthToHeightRatio: 1);

    BallState.values.forEach(
        (e) => builder.addScenario(e.name, BallView(Ball(0, e), null)));

    await tester.pumpWidgetBuilder(builder.build());
    await screenMatchesGolden(tester, 'BallView_grid');
  });
}
