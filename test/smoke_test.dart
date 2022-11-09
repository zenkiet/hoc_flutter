import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hoc_flutter/main.dart';

void main() {
  testWidgets('smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
  });
}
