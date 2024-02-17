import 'package:isar/isar.dart';

part 'workout_isar.g.dart';

@collection
class WorkoutRecorderEventIsar {
  Id? id;

  String uuid;
  String emoji;
  String workoutName;
  int hours;
  int minuites;
  DateTime dateTime;

  WorkoutRecorderEventIsar(this.emoji, this.workoutName, this.hours, this.minuites, this.dateTime, this.uuid);
}

