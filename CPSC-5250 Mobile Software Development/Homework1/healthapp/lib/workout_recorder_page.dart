import 'package:flutter/material.dart';
import 'package:healthapp/workout_recorder_form.dart';
import 'package:healthapp/workout_history.dart';

class WorkoutRecorderPage extends StatefulWidget {
  const WorkoutRecorderPage({Key? key,}) : super(key: key);

  @override
  State<WorkoutRecorderPage> createState() => _WorkoutRecorderPageState();
}

class _WorkoutRecorderPageState extends State<WorkoutRecorderPage> {
  
  @override
  Widget build(BuildContext context){
    return Container(
      child: const Column(
        children: <Widget>[
          WorkoutRecorderForm(),
          Expanded(child: WorkoutHistory()),
        ],
      )
    );
  }
}