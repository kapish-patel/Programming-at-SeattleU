import 'package:flutter/material.dart';
import 'package:healthapp/data_classes/diet_recorder_event.dart';
import 'package:healthapp/providers/dedication_provider.dart';
import 'package:healthapp/providers/diet_provider.dart';
import 'package:provider/provider.dart';

class DietRecorderForm extends StatefulWidget {
  const DietRecorderForm({Key? key}) : super(key: key);
  @override
  State<DietRecorderForm> createState() => _DietRecorderFormState();
}

class _DietRecorderFormState extends State<DietRecorderForm> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _mealNameController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Consumer2(builder: (context, DietProvider dietProvider, DedicationProvider dedicationProvider, child) {
      return Container(
        child: Form(
          key: _formKey,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Text("Select Food Item: ", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
                    DropdownButton(
                      key: const Key("foodItemDropdown"),
                      items: dietProvider.getUniqueFoodNames.map((String foodName) {
                        return DropdownMenuItem(
                          value: foodName,
                          child: Text(foodName),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        _mealNameController.text = value!;
                      },
                    ),
                  ]
                ),
                TextFormField(
                  key: const Key("mealNameTextField"),
                  controller: _mealNameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Food Item Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Food Item Name';
                    }
                    return null;
                  },
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child:TextFormField(
                        key: const Key("caloriesTextField"),
                        controller: _caloriesController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Calories',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Calories';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child:TextFormField(
                        key: const Key("quantityTextField"),
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Quantity',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Quantity';
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 191, 0),
                  ),
                  onPressed: () {
                    DateTime time = DateTime.now();

                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Successfully Submitted')),
                      );

                      FocusScope.of(context).unfocus();
                    

                      // add unique food name to the list if it doesn't exist
                      if (!dietProvider.getUniqueFoodNames.contains(_mealNameController.text.toLowerCase())) {
                        dietProvider.addUniqueFoodName(_mealNameController.text.toLowerCase());
                      }

                      DateTime lastRecordedTime = dedicationProvider.getLastRecorded;
                      int level = dedicationProvider.getDecidationLevel;
                      int recordingPoints = dedicationProvider.getRecordingPoints;
                      String lastRecordedString = dedicationProvider.getLastRecordedString;

                      // calculate points 
                      DateTime now = DateTime.now();
                      int difference = now.difference(lastRecordedTime).inMinutes;
                      if (difference < 20 && lastRecordedString == "Diet") {
                        context.read<DedicationProvider>().setRecordingPoints(recordingPoints + 1);
                      } else {
                        context.read<DedicationProvider>().setRecordingPoints(recordingPoints + 2);
                      }

                      // set dedication level
                      if (recordingPoints >= 10) {
                        context.read<DedicationProvider>().setDecidationLevel(level + 1);
                        context.read<DedicationProvider>().setRecordingPoints(0);
                      }

                      // set last recorded string
                      context.read<DedicationProvider>().setLastRecordedString("Diet");

                      // set last recorded
                      context.read<DedicationProvider>().setLastRecorded(time);
                      

                      DietRecorderEvent dietRecorderEvent = DietRecorderEvent(
                        _mealNameController.text,
                        int.parse(_caloriesController.text),
                        int.parse(_quantityController.text),
                        time,
                      );

                      dietProvider.addDiet(dietRecorderEvent);

                      // clear the form 
                      _mealNameController.clear();
                      _caloriesController.clear();
                      _quantityController.clear();
                    }
                  },
                  child: const Text('Submit',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  )
                )
              ],
            ),
          ),
        );
      }
    );
  }
}