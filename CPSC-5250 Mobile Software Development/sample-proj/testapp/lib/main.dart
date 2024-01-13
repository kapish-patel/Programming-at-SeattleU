import 'package:flutter/material.dart';
import './spending_event_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyBudget',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 28, 148, 68)),
        useMaterial3: true,
      ),
      home: const SpendingEventForm(),
    );
  }
}
