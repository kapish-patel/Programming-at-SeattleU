class DietRecorderModel {

  String uuid;
  String mealname;
  int quantity;
  int calories;
  DateTime dateTime; 

  DietRecorderModel(this.mealname, this.quantity, this.calories, this.dateTime, this.uuid);
}