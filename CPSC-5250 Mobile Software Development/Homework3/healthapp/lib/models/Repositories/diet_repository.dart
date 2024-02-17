import 'package:isar/isar.dart';
import 'package:healthapp/models/Collections/diet_isar.dart';
import 'package:healthapp/models/Data_Model/diet_model.dart';

class DietRepository {
  final IsarCollection<DietRecorderEventIsar> _dietRecorderEvents;

  DietRepository(this._dietRecorderEvents);

  // get all names from isar database before the widget is built
  Future<List<DietRecorderModel>> getDiets() async {
    var diets = await _dietRecorderEvents.where().findAll();
    return diets.map((e) => DietRecorderModel(e.mealname, e.quantity, e.calories, e.dateTime, e.uuid)).toList();
  }

  // use isar write transaction to add new name
  Future<void> addDiet(DietRecorderModel event) async {
    await _dietRecorderEvents.isar.writeTxn(() async {
      await _dietRecorderEvents.put(DietRecorderEventIsar(event.mealname, event.quantity, event.calories, event.dateTime, event.uuid));
    });
  }

  void deleteDiet(String uuid) async {
    await _dietRecorderEvents.isar.writeTxn(() async {
      await _dietRecorderEvents.where().filter().uuidEqualTo(uuid).deleteAll();
    });
  }


}
