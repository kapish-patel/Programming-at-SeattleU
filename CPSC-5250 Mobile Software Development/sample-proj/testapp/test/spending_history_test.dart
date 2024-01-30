import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testapp/spending_history.dart';
import 'package:testapp/spending_event.dart';

void main() {
  testWidgets("this is a test which check the addition of new data:---", (widgetTester) async {
    List <SpendingEvent> events = [
      SpendingEvent(
        merchant: "Walmart",
        category: "Groceries",
        amount: 100.00,
        date: DateTime.now(),
      ),
      SpendingEvent(
        merchant: "Target",
        category: "Groceries",
        amount: 100.00,
        date: DateTime.now(),
      ),
      SpendingEvent(
        merchant: "Costco",
        category: "Groceries",
        amount: 100.00,
        date: DateTime.now(),
      ),
    ];

    await widgetTester.pumpWidget(MaterialApp(home: Material( child: SpendingHistory(events))));
    
    expect(find.text("It"), findsOneWidget);
    expect(find.text("Target"), findsOneWidget);
    expect(find.text("Costco"), findsOneWidget);
  });
}