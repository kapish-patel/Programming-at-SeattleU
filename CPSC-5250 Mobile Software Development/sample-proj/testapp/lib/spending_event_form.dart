import 'package:flutter/material.dart';
import 'package:testapp/spending_event.dart';

// start working here bcz I have to make the stateful widget 
class SpendingEventForm extends StatelessWidget {
  SpendingEventForm({Key? key, required this.addSpendingEvent}) : super(key: key);

  final void Function(SpendingEvent event) addSpendingEvent;

  final TextEditingController merchanttextcontroller = TextEditingController();
  final TextEditingController categorytextcontroller = TextEditingController();
  final TextEditingController amounttextcontroller = TextEditingController();
  final TextEditingController datetextcontroller = TextEditingController();
  

  void _onclick() {
    addSpendingEvent(SpendingEvent(merchant: "test", amount: 1.0, date: DateTime.now(), category: "test"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budgetify', style: TextStyle(color: Colors.grey, fontSize: 24)),
        centerTitle: true,
      ),
      body:SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('Add Event Form',
                style: TextStyle(
                  fontSize: 24, 
                  color: Colors.redAccent
                )
              ),            
              const Text("Merchant"),
              const TextField(
                controller: merchanttextcontroller,
                decoration: InputDecoration(
                  labelText: 'Enter Merchant',
                ),
              ),
              const Text("Category"),
              const DropdownMenu(dropdownMenuEntries: []),
              const SizedBox(
                height: 200,
                width: 300,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("Amount: "),
                    SizedBox(
                      width: 200,
                      height: 100,
                      child: TextField(
                        controller: amounttextcontroller,
                        decoration: InputDecoration(
                          labelText: 'Enter Amount',
                        ),
                        keyboardType: TextInputType.number,
                      )
                    ),
                  ],
                ),
              ),
              const Text("Date"),
              const TextField(
                keyboardType: TextInputType.datetime,
                controller: datetextcontroller,
                decoration: InputDecoration(
                  labelText: 'Enter Date',
                ),
              ),
              ElevatedButton(onPressed: _onclick, child: const Text("Submit"))
            ],
          )
        ),
      ),
    );
  }
}
