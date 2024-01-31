
import 'package:flutter_test/flutter_test.dart';
import 'package:healthapp/main.dart';
import 'package:flutter/material.dart';
import 'package:healthapp/diet_recorder_form.dart';

void main() {
  testWidgets('Test to check if a new item has added to drop down in diet recorder form', (WidgetTester tester) async{
    //setup
    // load the app
    await tester.pumpWidget(const MyApp());

    // Tap on the "Diet" navigation destination
    await tester.tap(find.byIcon(Icons.restaurant));
    await tester.pumpAndSettle();

    // find the Diet recorder form 
    final dietRecorderForm = find.byType(DietRecorderForm);
    
    // find the text field for meal name
    final mealNameTextField = find.byKey(const Key("mealNameTextField"));

    // find the calories text field
    final caloriesTextField = find.byKey(const Key("caloriesTextField"));

    // find the quantity text field
    final quantityTextField = find.byKey(const Key("quantityTextField"));


    // execute
    // Enter values into the text fields
    await tester.enterText(mealNameTextField, 'Burger');
    await tester.enterText(caloriesTextField, '300');
    await tester.enterText(quantityTextField, '1');

    // wait for the text to be entered
    await tester.pumpAndSettle();

    // Find and tap on the submit button
    final submitButton = find.byType(ElevatedButton);
    await tester.press(submitButton);
    await tester.pumpAndSettle();

  
    // verify
    // find dropdown
    final dropdown = find.byKey(const Key("foodItemDropdown"));
    // tap on the dropdown
    await tester.tap(dropdown);
    await tester.pumpAndSettle();

    // expect the meal name to be present in the dropdown
    expect(find.text('Burger'), findsOneWidget);

  });
}
