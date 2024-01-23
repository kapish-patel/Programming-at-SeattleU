import 'package:flutter/material.dart';
import 'package:testapp/spending_event.dart';
import './spending_event_form.dart';
import './spending_history.dart';

class SpendingPage extends StatefulWidget {
  
  const SpendingPage({Key? key}) : super(key: key);

  @override
  State<SpendingPage> createState() => _SpendingPageState();
}

class _SpendingPageState extends State<SpendingPage> {

  final List<SpendingEvent> _spendingEvents = [];

  _addSpendingEvent(SpendingEvent spendingEvent) {
    setState(() {
      _spendingEvents.add(spendingEvent);
      print(spendingEvent.merchant);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 64, 7, 7),
        title: const Text('Budgetify', style: TextStyle(color: Color.fromARGB(255, 207, 204, 204), fontSize: 24)),
        centerTitle: true,
      ),
      body:ListView(
      children: [
        SizedBox(
          height: 600, child: SpendingEventForm(_addSpendingEvent),
        ),
        SizedBox(
          height: 600, child: SpendingHistory(_spendingEvents)
        ),
      ],
    )
    );
  }
}

