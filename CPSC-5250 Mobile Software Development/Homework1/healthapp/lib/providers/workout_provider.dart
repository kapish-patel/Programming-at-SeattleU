import 'package:flutter/material.dart';
import 'package:healthapp/data_classes/workout_recorder_event.dart';

class WorkoutProvider extends ChangeNotifier {
  final List<WorkoutRecorderEvent> _workouts = [];

  List<WorkoutRecorderEvent> get workouts => _workouts;

  void addWorkout(WorkoutRecorderEvent workout) {
    _workouts.add(workout);
    notifyListeners();
  }
  
}