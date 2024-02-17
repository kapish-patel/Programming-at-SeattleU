import 'package:flutter/material.dart';
import 'package:healthapp/view-models/workout_provider.dart';
import 'package:healthapp/views/custom_bottom_sheet.dart';
import 'package:healthapp/views/workout_recorder/workout_history.dart';
import 'package:healthapp/views/workout_recorder/workout_recorder_form.dart';
import 'package:provider/provider.dart';


class WorkoutRecorderPage extends StatelessWidget {
  const WorkoutRecorderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Recorder'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context, 
                builder: (context) => const CustomBottomSheet()
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
      child: Column(
        children: <Widget>[
          const WorkoutRecorderForm(),
          Expanded(
            child: FutureBuilder(
              future: workoutProvider.getWorkouts(), 
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return WorkoutHistory();
                }
              }
            ),
          ),
        ],
      )
    ) ,
    );
  }
}
