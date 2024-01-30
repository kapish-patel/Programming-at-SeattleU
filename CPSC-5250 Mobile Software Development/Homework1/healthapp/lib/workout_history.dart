import 'package:flutter/material.dart';
import 'package:healthapp/data_classes/workout_recorder_event.dart';
import 'package:healthapp/card_list.dart';
import 'package:provider/provider.dart';
import 'package:healthapp/providers/workout_provider.dart';

class WorkoutHistory extends StatefulWidget{

  const WorkoutHistory({Key? key}) : super(key: key);

  @override
  State<WorkoutHistory> createState() => _WorkoutHistoryState();
}

class _WorkoutHistoryState extends State<WorkoutHistory> {
  final ScrollController _scrollController = ScrollController();
  List<WorkoutRecorderEvent> workoutRecorderEventsHistory = [];

  @override
  void initState() {
    super.initState();
    workoutRecorderEventsHistory = context.read<WorkoutProvider>().workouts;
  }

  @override
  Widget build(BuildContext context){
    return Consumer(builder: (context, WorkoutProvider workoutProvider, child) {
      return Container(
        height: 300.0,
        child: ListView.builder(
          controller: _scrollController,
          reverse: true,
          itemCount: workoutRecorderEventsHistory.length,
          itemBuilder: (context, index) {
            return CardList(
              type: 'workout',
              emoji: workoutRecorderEventsHistory[index].emoji,
              workoutname: workoutRecorderEventsHistory[index].workoutName,
              hours: workoutRecorderEventsHistory[index].hours.toString(),
              minuites: workoutRecorderEventsHistory[index].minuites.toString(),
              dateTime: workoutRecorderEventsHistory[index].dateTime.toString()
            );
          },
        ),
      );
    });
  }
  @override
  void didUpdateWidget(WorkoutHistory oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}