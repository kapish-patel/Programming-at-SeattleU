import 'package:flutter/material.dart';
import 'package:healthapp/view-models/workout_provider.dart';
import 'package:healthapp/views/workout_recorder/workout_card_list.dart';
import 'package:provider/provider.dart';

class WorkoutHistory extends StatelessWidget {
  WorkoutHistory({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
Widget build(BuildContext context){
  final workoutProvider = Provider.of<WorkoutProvider>(context);
    return Container(
      height: 300.0,
      child: ListView.builder(
        controller: _scrollController,
        reverse: true,
        itemCount: workoutProvider.workouts.length,
        itemBuilder: (context, index) {
          return WorkoutCardList(
            emoji: workoutProvider.workouts[index].emoji,
            workoutName: workoutProvider.workouts[index].workoutName,
            hours: workoutProvider.workouts[index].hours,
            minutes: workoutProvider.workouts[index].minuites,
            dateTime: workoutProvider.workouts[index].dateTime.toString(),
            ontapDelete: () {
              workoutProvider.deleteWorkout(workoutProvider.workouts[index].uuid);
            }
          );
        },
      ),
    );
  }
}
