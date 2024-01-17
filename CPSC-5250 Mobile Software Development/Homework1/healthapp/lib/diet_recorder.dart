import 'package:flutter/material.dart';

class DietRecorder extends StatefulWidget {
  const DietRecorder({super.key});

  @override
  DietRecorderState createState() {
    return DietRecorderState();
  }
}

class DietRecorderState extends State<DietRecorder> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController mealNameController = TextEditingController();
  final TextEditingController mealQuantityController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(6, 214, 160, 1),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              color: Colors.white,  // Card color is white
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: mealNameController,
                        decoration: const InputDecoration(labelText: 'Meal Name'),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter a Valid Meal Name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: mealQuantityController,
                        decoration: const InputDecoration(labelText: 'Meal Quantity'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter a Valid Meal Quantity';
                          }
                          // You can add more validation logic for quantity if needed
                          return null;
                        },
                        onEditingComplete: () {
                          // Hide the keyboard when the user hits enter
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {

                  // hide the keyboard when the user hits submit
                  FocusScope.of(context).unfocus();

                  // Process the inputs, for example, save to a database
                  String mealName = mealNameController.text;
                  String mealQuantity = mealQuantityController.text;
                  print('Meal name: $mealName');
                  print('MealQuantity: $mealQuantity');
                  print('Meal Time: ${DateTime.now()}');

                  // Clear the input field
                  mealNameController.clear();
                  mealQuantityController.clear();

                  // Notify the user using snackbar notification
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Successfully submitted Data!'),
                  ));
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}