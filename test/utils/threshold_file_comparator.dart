// Inspired by https://github.com/flutter/cocoon/dashboard/test/utils/golden.dart

import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:path/path.dart' as path;

class GoldenComparer {
  GoldenComparer() {
    _absPath = (goldenFileComparator as LocalFileComparator).basedir.toString();
  }
  late String _absPath;

  Future<void> screenMatchesThreshold(
    WidgetTester tester,
    String name, {
    double? threshold,
    bool? autoHeight,
    Finder? finder,
    CustomPump? customPump,
    @Deprecated('This method level parameter will be removed in an upcoming release. This can be configured globally. If you have concerns, please file an issue with your use case.')
        bool? skip,
  }) {
    goldenFileComparator = ThresholdFileComparator(
      path.join(
        _absPath,
        name,
      ),
    );
    if (threshold != null) {
      (goldenFileComparator as ThresholdFileComparator).setThreshold(threshold);
    }

    return GoldenToolkit.runWithConfiguration(
      () async => screenMatchesGolden(
        tester,
        name,
        autoHeight: autoHeight,
        finder: finder,
        customPump: customPump,
      ),
      config: GoldenToolkitConfiguration(
        fileNameFactory: (name) => '$_absPath$name.png',
      ),
    );
  }
}

/// A simple file comparator that accommodates a small threshold
class ThresholdFileComparator extends LocalFileComparator {
  ThresholdFileComparator(String testFile) : super(Uri.parse(testFile));

  factory ThresholdFileComparator.from(LocalFileComparator c) {
    return ThresholdFileComparator(c.toString());
  }

  double _threshold = 0.04; // 4%

  //Sets the threshold such that a difference that exceeds this threshold will cause a test failure
  double setThreshold(double threshold) => _threshold = threshold;

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final ComparisonResult result = await GoldenFileComparator.compareLists(
      imageBytes,
      await getGoldenBytes(golden),
    );

    if (!result.passed && result.diffPercent > _threshold) {
      final String error = await generateFailureOutput(result, golden, basedir);
      throw FlutterError(error);
    }
    if (!result.passed) {
      Println(
        'A tolerable difference of ${result.diffPercent * 100}% was found when '
        'comparing $golden.',
      );
    }
    return result.passed || result.diffPercent <= _threshold;
  }
}
