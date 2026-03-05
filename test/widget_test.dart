import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:packlite/main.dart';

void main() {
  testWidgets('Home screen loads correctly', (WidgetTester tester) async {

    // Build the app
    await tester.pumpWidget(const PackLiteApp());

    // Verify app title
    expect(find.text('PackLite'), findsOneWidget);

    // Verify Personal Trips section
    expect(find.text('Personal Trips'), findsOneWidget);

    // Verify Group Trips section
    expect(find.text('Group Trips'), findsOneWidget);

    // Verify sample trip names
    expect(find.text('Weekend Getaway'), findsOneWidget);
    expect(find.text('small trip'), findsOneWidget);

  });
}