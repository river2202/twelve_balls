import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:twelve_balls/Model/Ball.dart';
import 'package:twelve_balls/View/BallView.dart';

import 'utils/load_fonts.dart';
import 'utils/threshold_file_comparator.dart';

void main() {
  loadFonts();

  testGoldens('BallView Golden test', (tester) async {
    final builder = GoldenBuilder.grid(columns: 2, widthToHeightRatio: 1);
    final _goldenComparer = GoldenComparer();

    BallState.values.forEach(
        (e) => builder.addScenario(e.name, BallView(Ball(0, e), null)));

    await tester.pumpWidgetBuilder(builder.build());
    await _goldenComparer.screenMatchesThreshold(
      tester,
      'goldens/BallView_grid',
      threshold: 0.8,
    );
  });
}
