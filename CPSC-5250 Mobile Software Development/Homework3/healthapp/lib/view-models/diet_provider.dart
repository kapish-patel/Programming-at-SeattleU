import 'package:flutter/material.dart';
import 'package:healthapp/models/Data_Model/diet_model.dart';
import 'package:healthapp/models/Repositories/diet_repository.dart';

class DietProvider extends ChangeNotifier {

  final DietRepository _dietRepository;

  DietProvider(this._dietRepository);

  final List<DietRecorderModel> _diets = [];
  List<String> _uniqueDietNames = [];
  
  List<String> get unique => _uniqueDietNames;
  List<DietRecorderModel> get diets => _diets;

  void addDiet(DietRecorderModel diet) {
    _dietRepository.addDiet(diet);
    _diets.add(diet);
    addUniqueDietName(diet.mealname);
    notifyListeners();
  }
  
  // get all diets from the list before the widget is built
  Future<void> getDiets() async {
    _diets.clear();
    _diets.addAll(await _dietRepository.getDiets());
    
    _uniqueDietNames.clear();
    _uniqueDietNames = _diets.map((e) => e.mealname).toSet().toList();
    notifyListeners();
  }
  
  void addUniqueDietName(String mealname) {
    if (!_uniqueDietNames.contains(mealname)) {
      _uniqueDietNames.add(mealname);
    }
    notifyListeners();
  }

  void deleteDiet(String uuid) {
    _diets.removeWhere((element) => element.uuid == uuid);
    _dietRepository.deleteDiet(uuid);
    notifyListeners();
  }

  // get diet by uuid
  Future<DietRecorderModel> getDietByUuid(String uuid) async {
    return await _dietRepository.getDietByUuid(uuid);
  }

  void updateDiet(DietRecorderModel diet) {
    _dietRepository.updateDiet(diet);
    _diets.removeWhere((element) => element.uuid == diet.uuid);
    _diets.add(diet);
    notifyListeners();
  }
}
