import 'package:flutter/material.dart';

import 'spending_event.dart';

class SpendingEventForm extends StatefulWidget {
  final void Function(SpendingEvent event) addSpendingEvent;

  const SpendingEventForm(this.addSpendingEvent, {super.key});

  @override
  createState() => _SpendingEventFormState();
}

class _SpendingEventFormState extends State<SpendingEventForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _merchantController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  // a callback method that we'll use to handle user input
  void _onSavePressed() {
    print('User tried to save data');
    if(_formKey.currentState?.validate() ?? false) {
      SpendingEvent event = SpendingEvent(
          _merchantController.text,
          _categoryController.text,
          double.parse(_priceController.text),
          DateTime.parse(_dateController.text)
      );
      widget.addSpendingEvent(event);
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold does a variety of things, but for this sample the main
    // value is that it gives default styles to our background and text

      // A "safe area" is the area that won't overlap with the camera notch,
      // rounded edges of the screen, the OS's notifications, etc.
      // It comes baked in to some other widgets, but we're using it explicitly here.
      return Form(
        key: _formKey,
        child: SafeArea(
            child: Column(
              children: [
                const Text('Add Event', style: TextStyle(fontSize:  48)),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Merchant'
                  ),
                  controller: _merchantController,
                  validator: (newValue) {
                    if(newValue == null || newValue.isEmpty) {
                      return 'Merchant must not be blank.';
                    }
                    return null;
                  },
                ),
                const Text('Category'),
                DropdownMenu(
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: 'a', label: 'a'),
                    DropdownMenuEntry(value: 'b', label: 'b'),
                  ],
                  controller: _categoryController,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Amount'),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _priceController,
                      ),
                    )
                  ]
                ),
                const Text('Date'),
                TextFormField(
                  keyboardType: TextInputType.datetime,
                  controller: _dateController,
                ),
                ElevatedButton(
                  // Note: we are not calling _onSavePressed! We are passing it
                  // like an object to this other widget as a constructor arg.
                  onPressed: _onSavePressed,
                  child: const Text('Save')
                )
              ]
        ),
      )
    );
  }
}
