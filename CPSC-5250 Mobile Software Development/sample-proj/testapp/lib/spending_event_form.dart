import 'package:flutter/material.dart';

class SpendingEventForm extends StatelessWidget {
  
  const SpendingEventForm({Key? key}) : super(key: key);

  void _onclick() {
    print("Button clicked");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text('Add Event Form', style: TextStyle(fontSize: 24)),
            
            const Text("Merchant"),
            const TextField(),
            
            const Text("Category"),
            const DropdownMenu(dropdownMenuEntries: []),

            const Text("Amount"),
            const TextField(
              keyboardType: TextInputType.number,
            ),

            const Text("Date"),
            const TextField(
              keyboardType: TextInputType.datetime,
            ),

            ElevatedButton(onPressed: _onclick, child: const Text("Submit"))

          ],
        )
      ),
    );
  }
}
