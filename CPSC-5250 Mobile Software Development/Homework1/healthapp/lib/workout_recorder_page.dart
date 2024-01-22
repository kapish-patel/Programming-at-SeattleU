import 'package:flutter/material.dart';

class WorkoutRecorderPage extends StatefulWidget {
  const WorkoutRecorderPage({Key? key}) : super(key: key);

  @override
  State<WorkoutRecorderPage> createState() => _WorkoutRecorderPageState();
}

class _WorkoutRecorderPageState extends State<WorkoutRecorderPage> {

  @override
  Widget build(BuildContext context){
    return Container(
      child: const Text('Workout Recorder Page'),
    );
  }
}