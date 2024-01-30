import 'package:budget_manager/bank_account.dart';
import 'package:budget_manager/bank_balance_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'spending_event.dart';
import 'spending_event_form.dart';
import 'spending_history.dart';

class SpendingPage extends StatefulWidget {
  const SpendingPage({super.key});

  @override
  State<SpendingPage> createState() => _SpendingPageState();
}

class _SpendingPageState extends State<SpendingPage> {
  final List<SpendingEvent> _spendingEvents = [];

  _addSpendingEvent(SpendingEvent spendingEvent) {
    setState(() {
      _spendingEvents.add(spendingEvent);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('re-building SpendingPage');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Center(
            child: Text(
              'You have \$${context.watch<BankAccount>().getBalance()}',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const BankBalanceForm();
                  },
                );
              },
              icon: const Icon(Icons.attach_money),
            )
          ],
        ),
        body: ListView(
          children: [
            SpendingEventForm(_addSpendingEvent),
            SpendingHistory(_spendingEvents)
          ],
        )
    );
  }
}
