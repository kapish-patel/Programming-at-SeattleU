import 'package:healthapp/models/Data_Model/workout_model.dart';
import 'package:isar/isar.dart';
import 'package:healthapp/models/Collections/workout_isar.dart';


class WorkoutRepository {
  final IsarCollection<WorkoutRecorderEventIsar> _workoutRecorderEvents;

  WorkoutRepository(this._workoutRecorderEvents);

  // get all names from isar database before the widget is built
  Future<List<WorkoutModel>> getWorkouts() async {
    var workouts = await _workoutRecorderEvents.where().findAll();
    return workouts.map((e) => WorkoutModel(e.emoji, e.workoutName, e.hours, e.minuites, e.dateTime, e.uuid)).toList();
  }

  // use isar write transaction to add new event
  Future<void> addWorkout(WorkoutModel event) async {
    await _workoutRecorderEvents.isar.writeTxn(() async {
      await _workoutRecorderEvents.put(WorkoutRecorderEventIsar(event.emoji, event.workoutName, event.hours, event.minuites, event.dateTime, event.uuid));
    });
  }

  void deleteWorkout(uuid) async{
    await _workoutRecorderEvents.isar.writeTxn(() async {
      await _workoutRecorderEvents.where().filter().uuidEqualTo(uuid).deleteAll();
    });
  }
}
