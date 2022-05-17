import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

/// Regress Testing
void main() {
  group(
    'Given Golden Tool Kit Testing',
    () {
      testGoldens(
        'then the images should be show exactly',
        (tester) async {
          /// ARRANGE
          final builder = GoldenBuilder.grid(columns: 1, widthToHeightRatio: 1)
            ..addScenario('Sunny', const Icon(Icons.sunny))
            ..addScenario('Raining', const Icon(Icons.ramen_dining))
            ..addScenario('Windy', const Icon(Icons.wb_sunny))
            ..addScenario('Flower', const Icon(Icons.file_download));

          /// ACT
          await tester.pumpWidgetBuilder(
            builder.build(),
            surfaceSize: const Size(500, 500),
          );

          /// ASSERT
          await screenMatchesGolden(tester, 'collapse_image_grid');
        },
      );
    },
  );
}
