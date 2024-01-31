import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthapp/main.dart';
import 'package:healthapp/workout_history.dart';

void main() {
  testWidgets('Test to check if a new card have been added after submitting workout form', (WidgetTester tester) async {

    //setup
    // load the app
    await tester.pumpWidget(const MyApp());

    // Tap on the "Workout" navigation destination
    await tester.tap(find.byIcon(Icons.fitness_center));
    await tester.pumpAndSettle();

    // Find the text fields
    final hoursTextField = find.byKey(const Key("hoursTextField"));
    final minutesTextField = find.byKey(const Key("minutesTextField"));


    // execute
    // Enter values into the text fields
    await tester.enterText(hoursTextField, '1');
    await tester.enterText(minutesTextField, '30');

    // wait for the text to be entered
    await tester.pumpAndSettle();

    // Find and tap on the submit button
    final submitButton = find.byType(ElevatedButton);
    await tester.press(submitButton);

    // find the workout history widget in the WorkoutRecorderPage
    final workoutHistory = find.byType(WorkoutHistory);

    // find the list view in the workout history widget
    final listView = find.descendant(of: workoutHistory, matching: find.byType(ListView));


    // verify
    // expect one widget in the list view
    expect(listView, findsOneWidget);
  });
}
