// Purpose: This file is used to test the functionality of the emotion selector widget.
import 'package:flutter_test/flutter_test.dart';
import 'package:healthapp/main.dart';
import 'package:healthapp/emotion_selector.dart';
import 'package:healthapp/emotion_history.dart';
import 'package:flutter/material.dart';


void main() {
  testWidgets('taping emoji should add new card in emotion history', (tester) async {
    // setup
    await tester.pumpWidget(const MyApp());

    // find the emotion selector widget
    final emotionSelector = find.byType(EmotionSelector); 
    print(emotionSelector);

    // find the list view
    final listView = find.descendant(of: emotionSelector, matching: find.byType(ListView));

    // find the first guesture detector
    final gestureDetector = find.descendant(of: listView, matching: find.byType(GestureDetector)).first;

    // find the emotion history widget
    final emotionHistory = find.byType(EmotionHistory);

    // fins a list view in the emotion history widget
    final emotionHistoryListView = find.descendant(of: emotionHistory, matching: find.byType(ListView));


    // execute

    // tap the gesture detector
    await tester.tap(gestureDetector);
    await tester.pumpAndSettle();

    // verify
    
    // the first child of emotion History list view should be created with specific details
    expect(emotionHistoryListView, findsOneWidget);

  });
}