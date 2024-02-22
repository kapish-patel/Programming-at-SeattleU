import 'package:flutter/material.dart';
import 'package:healthapp/models/Data_Model/diet_model.dart';
import 'package:healthapp/view-models/diet_provider.dart';
import 'package:healthapp/view-models/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

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
    final dietProvider = context.watch<DietProvider>();
    final userProvider = context.watch<UserProvider>();
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
                    items: dietProvider.unique.map((String foodName) {
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

                    // calculate the points
                    userProvider.calculatePoints(time, "Diet");

                    DietRecorderModel dietRecorderEvent = DietRecorderModel(
                      _mealNameController.text,
                      int.parse(_quantityController.text),
                      int.parse(_caloriesController.text),
                      time,
                      const Uuid().v4(),
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
  }