import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/bank_account.dart';
import 'package:testapp/spending_event.dart';
import './spending_event_form.dart';
import './spending_history.dart';

class SpendingPage extends StatefulWidget {
  
  const SpendingPage({Key? key}) : super(key: key);

  @override
  State<SpendingPage> createState() => _SpendingPageState();
}

class _SpendingPageState extends State<SpendingPage> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bankBalanceController = TextEditingController();

  final List<SpendingEvent> _spendingEvents = [];

  _addSpendingEvent(SpendingEvent spendingEvent) {
    setState(() {
      _spendingEvents.add(spendingEvent);
    });
  }

  @override
  void initState() {
    super.initState();
    _bankBalanceController.text = context.read<BankAccount>().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 64, 7, 7),
        title: const Text('Budgetify', style: TextStyle(
          color: Color.fromARGB(255, 207, 204, 204),
          fontSize: 24,
          fontWeight: FontWeight.bold,
          ),
        ),
        // title: const Text('Budgetify', style: TextStyle(color: Color.fromARGB(255, 207, 204, 204), fontSize: 24)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(context: context, builder: (context){
                return Container(
                  height: 200,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text("Bank Balance"),
                        TextFormField(
                          controller: _bankBalanceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Enter Bank Balance",
                          ),
                        ),
                      ],
                    ),
                  )
                );
              });
            },
            icon: const Icon(Icons.attach_money),
            color: const Color.fromARGB(255, 207, 204, 204),
          ),
        ],
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

