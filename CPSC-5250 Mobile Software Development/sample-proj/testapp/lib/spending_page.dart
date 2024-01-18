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
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        SpendingEventForm(addSpendingEvent: _addSpendingEvent),
        SpendingHistory(_spendingEvents),
      ],
    );
  }
}

