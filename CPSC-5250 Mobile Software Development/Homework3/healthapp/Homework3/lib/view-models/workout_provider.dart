import 'package:flutter/material.dart';
import 'package:healthapp/models/Data_Model/workout_model.dart';
import 'package:healthapp/models/Repositories/workout_repository.dart';

class WorkoutProvider extends ChangeNotifier {

  final WorkoutRepository _workoutRepository;

  WorkoutProvider(this._workoutRepository);

  final List<WorkoutModel> _workouts = [];

  List<WorkoutModel> get workouts => _workouts;

  // add workout to the list
  void addWorkout(WorkoutModel workout) {
    _workoutRepository.addWorkout(workout);
    _workouts.add(workout);
    notifyListeners();
  }

  // get all workouts from the list before the widget is built
  Future<void> getWorkouts() async {
    _workouts.clear();
    _workouts.addAll(await _workoutRepository.getWorkouts());
    notifyListeners();
  }

  void deleteWorkout(uuid) {
    _workouts.removeWhere((element) => element.uuid == uuid);
    _workoutRepository.deleteWorkout(uuid);
    notifyListeners();
  }
}