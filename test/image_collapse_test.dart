import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'package:image_collapse/image_collapse.dart';
import 'package:image_collapse/src/helper/gallery_helper.dart';

/// Unit Testing
void main() {
  group(
    'Given Initial Screen When Image Loaded',
    () {
      testWidgets(
        'With empty image url then findsNothing widget',
        (WidgetTester tester) async {
          /// ARRANGE
          await tester.pumpWidget(
            const ImageCollapse(
              imageUrls: [],
            ),
          );

          /// ACT
          final indicator = find.byKey(const ValueKey('037a00ea-cf6b-11ec-9d64-0242ac120002'));

          /// ASSERT
          expect(indicator, findsOneWidget);
        },
      );
    },
  );

  group(
    'Given isImage function when is running',
    () {
      test(
        'value should be return false',
        () {
          final isValidUrl = isImage(null);
          expect(isValidUrl, false);
        },
      );

      test(
        'value empty should be return false',
        () {
          final isValidUrl = isImage('');
          expect(isValidUrl, false);
        },
      );

      test(
        'value should be return true',
        () {
          final isValidUrl = isImage('image/image_collapse.png');
          expect(isValidUrl, true);
        },
      );

      test(
        'value application/vnd should be return false',
        () {
          final isValidUrl = isImage('application/vnd.lotus-1-2-3');
          expect(isValidUrl, false);
        },
      );
    },
  );

  group(
    'Given isImage function when is running',
    () {
      testGoldens(
        'then the images should be render exactly',
        (tester) async {
          /// ARRANGE
          await tester.pumpWidgetBuilder(
            const ImageCollapse(
              imageUrls: [
                "https://img.pikbest.com/05/81/63/10VpIkbEsT5s3.jpg-0.jpg!bw340",
              ],
            ),
          );

          /// ASSERT
          await screenMatchesGolden(tester, 'collapse_image');
        },
      );
    },
  );
}
