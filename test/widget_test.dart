// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:crewcall_flutter/main.dart';

void main() {
  testWidgets('App loads signup page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CrewCallApp());

    // Verify that the signup page loads.
    expect(find.text('Create a Talent Account'), findsOneWidget);
    expect(find.text('CrewCall'), findsOneWidget);
  });
}
