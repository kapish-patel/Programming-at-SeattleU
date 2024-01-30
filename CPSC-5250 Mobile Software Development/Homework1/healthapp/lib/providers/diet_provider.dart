import 'package:flutter/material.dart';
import 'package:healthapp/data_classes/diet_recorder_event.dart';

class DietProvider extends ChangeNotifier {
  final List<DietRecorderEvent> _diets = [];
  final List<String> uniqueFoodNames = [];

  List<DietRecorderEvent> get diets => _diets;
  List<String> get getUniqueFoodNames => uniqueFoodNames;

  void addDiet(DietRecorderEvent diet) {
    _diets.add(diet);
    notifyListeners();
  }

  void addUniqueFoodName(String foodName) {
    uniqueFoodNames.add(foodName);
    notifyListeners();
  }
  
}
