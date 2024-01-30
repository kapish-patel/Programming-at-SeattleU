import 'package:budget_manager/bank_account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'spending_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BankAccount(2024.00),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // instead of the generated sample widget, we'll use our own custom widget
        // as the default widget we'll show on opening the app
        home: const SpendingPage(),
      )
    );
  }
}

