import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  group(
    'My example application context',
    () {
      testWidgets(
        'Then the app title should be correctly',
        (WidgetTester tester) async {
          await tester.pumpWidget(const MyApp());
          final appTitle = find.byKey(const Key('title_key'));
          expect(appTitle, findsOneWidget);
        },
      );

      testWidgets(
        'Then image collapse library should be render correctly',
        (WidgetTester tester) async {
          await tester.pumpWidget(const MyApp());
          final imageCollapse = find.byKey(const Key('image_collapse_key'));
          expect(imageCollapse, findsOneWidget);
        },
      );
    },
  );
}
