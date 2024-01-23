import 'package:flutter/material.dart';
import 'package:testapp/spending_event.dart';

// start working here bcz I have to make the stateful widget 

class SpendingEventForm extends StatefulWidget {
  const SpendingEventForm(this.addSpendingEvent, {super.key});

  final void Function(SpendingEvent event) addSpendingEvent;

  @override
  createState() => _SpendingEventFormState();
}
class _SpendingEventFormState extends State<SpendingEventForm> {

  void _onclick() {
    SpendingEvent event = SpendingEvent(
      merchant: _merchantController.text,
      category: _categoryController.text,
      amount: double.parse(_amountController.text),
      date: DateTime.parse(_dateController.text));
    widget.addSpendingEvent(event);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _merchantController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child:SafeArea(
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
              TextField(
                controller: _merchantController,
                decoration: const InputDecoration(
                  labelText: 'Enter Merchant',
                ),
              ),
              const Text("Category"),
              DropdownMenu(
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: "Education", label: "Education"),
                  DropdownMenuEntry(value: "Food", label: "Food"),
                  DropdownMenuEntry(value: "Entertainment", label: "Entertainment"),
                  DropdownMenuEntry(value: "Transportation", label: "Transportation"),
                  DropdownMenuEntry(value: "Other", label: "Other"),
                ],
                controller: _categoryController, ),
              SizedBox(
                height: 200,
                width: 300,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text("Amount: "),
                    SizedBox(
                      width: 200,
                      height: 100,
                      child: TextField(
                        controller: _amountController,
                        decoration: const InputDecoration(
                          labelText: 'Enter Amount',
                        ),
                        keyboardType: TextInputType.number,
                      )
                    ),
                  ],
                ),
              ),
              const Text("Date"),
              TextField(
                controller: _dateController,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
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
