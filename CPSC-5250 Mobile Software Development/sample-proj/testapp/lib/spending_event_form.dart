import 'package:flutter/material.dart';

class SpendingEventForm extends StatelessWidget {
  
  const SpendingEventForm({Key? key}) : super(key: key);

  void _onclick() {
    print("Button clicked");
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
