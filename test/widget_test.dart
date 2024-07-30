import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/main.dart';

void main() {
  testWidgets('SmartTrack app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SmartTrackApp());

    // Verify that the app title is displayed
    expect(find.text('SmartTrack'), findsOneWidget);

    // Verify that the HomeScreen is the initial route
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text('Tips to manage budget!'), findsOneWidget);

    // Verify that the "Add Expense" and "Add Income" buttons are present
    expect(find.text('Add Expense'), findsOneWidget);
    expect(find.text('Add Income'), findsOneWidget);

    // Tap the Budgets icon and trigger a frame.
    await tester.tap(find.text('Budgets'));
    await tester.pumpAndSettle();

    // Verify that we've navigated to the BudgetsScreen
    expect(find.text('Budgets'), findsOneWidget);
    expect(find.text('Total Budget'), findsOneWidget);
    expect(find.text('Total Spent'), findsOneWidget);
    expect(find.text('Balance'), findsOneWidget);
  });
}
