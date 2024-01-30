import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/bank_account.dart';

import 'package:testapp/spending_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => BankAccount(1000.0),
      child: MaterialApp(
        title: 'MyBudget',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 28, 148, 68)),
          useMaterial3: true,
        ),
        home: const SpendingPage(),
      ),
    );
  }
}
