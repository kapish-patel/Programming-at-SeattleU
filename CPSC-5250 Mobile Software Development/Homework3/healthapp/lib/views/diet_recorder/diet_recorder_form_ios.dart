import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:healthapp/models/Data_Model/diet_model.dart';
import 'package:healthapp/view-models/diet_provider.dart';
import 'package:healthapp/view-models/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class DietRecorderFormIos extends StatelessWidget {
  DietRecorderFormIos({super.key});

  final _formKey = GlobalKey<FormState>();
  // controllers for the text fields
  final TextEditingController _mealNameController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final _scrollController = FixedExtentScrollController(initialItem: 0); // Initialize the scroll controller


  @override
  Widget build(BuildContext context) {
    
    final dietProvider = context.watch<DietProvider>();
    final userProvider = context.watch<UserProvider>();
    if (dietProvider.unique.isNotEmpty) {
      _mealNameController.text = dietProvider.unique[0];
    }
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  " ${AppLocalizations.of(context)!.selectFoodName}: ",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CupertinoButton(
                  onPressed: () {
                    showCupertinoModalPopup<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 200,
                          child: CupertinoPicker(
                            itemExtent: 32,
                            // select the first item by default
                            scrollController: _scrollController,
                            onSelectedItemChanged: (int index) {
                              _mealNameController.text = dietProvider.unique[index];
                            },
                            children: dietProvider.unique.map((String foodName) {
                              return Text(foodName);
                            }).toList(),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('Open Picker'),
                ),
              ],
            ),
            CupertinoTextField(
              key: const Key("mealNameTextField"),
              controller: _mealNameController,
              keyboardType: TextInputType.text,
              placeholder: AppLocalizations.of(context)!.foodItemName,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: CupertinoColors.systemGrey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              style: const TextStyle(fontSize: 16),
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.foodItemName}'; // to be localized
              //   }
              //   return null;
              // },
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: CupertinoTextField(
                    key: const Key("caloriesTextField"),
                    controller: _caloriesController,
                    keyboardType: TextInputType.number,
                    placeholder: AppLocalizations.of(context)!.calories,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CupertinoColors.systemGrey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    style: const TextStyle(fontSize: 16),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.calories}';// to be localized
                    //   }
                    //   return null;
                    // },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CupertinoTextField(
                    key: const Key("quantityTextField"),
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    placeholder: AppLocalizations.of(context)!.quantity,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CupertinoColors.systemGrey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    style: const TextStyle(fontSize: 16),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.quantity}';// to be localized
                    //   }
                    //   return null;
                    // },
                  ),
                )
              ],
            ),
            CupertinoButton(
              onPressed: () {
                DateTime time = DateTime.now();

                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(context)!.successfullySubmitted),
                    ),
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
              color: const Color.fromARGB(255, 255, 191, 0),
              child: Text(
                AppLocalizations.of(context)!.submit,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
