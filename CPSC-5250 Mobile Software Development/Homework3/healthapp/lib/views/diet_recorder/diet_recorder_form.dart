import 'package:flutter/material.dart';
import 'package:healthapp/models/Data_Model/diet_model.dart';
import 'package:healthapp/view-models/diet_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:healthapp/view-models/switcher_provider.dart';
import 'package:healthapp/view-models/user_provider.dart';
import 'package:healthapp/views/diet_recorder/diet_recorder_form_ios.dart';
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
    final isSwitched = context.watch<SwitcherProvider>().isSwitched;
    return isSwitched ? DietRecorderFormIos() :
    Container(
      child: Form(
        key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(" ${AppLocalizations.of(context)!.selectFoodName}: ", style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),

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
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.foodItemName,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.foodItemName}'; // to be localized
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
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.calories,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.calories}';// to be localized
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
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.quantity,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.quantity}';// to be localized
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
                      SnackBar(content: Text(AppLocalizations.of(context)!.successfullySubmitted)),// to be localized
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
                child: Text(AppLocalizations.of(context)!.submit,
                  style: const TextStyle(
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