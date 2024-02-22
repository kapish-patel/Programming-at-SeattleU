import 'package:isar/isar.dart';

part 'diet_isar.g.dart';

@collection
class DietRecorderEventIsar{
  Id? id;

  String uuid;
  String mealname;
  int quantity;
  int calories;
  DateTime dateTime;

  DietRecorderEventIsar(this.mealname, this.quantity, this.calories, this.dateTime, this.uuid);
}