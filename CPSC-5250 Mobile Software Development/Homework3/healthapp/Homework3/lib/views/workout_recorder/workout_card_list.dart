import 'package:flutter/material.dart';

class WorkoutCardList extends StatelessWidget {
  final String emoji;
  final String workoutName;
  final String dateTime;
  final int hours;
  final int minutes;
  final Function ontapDelete;

  const WorkoutCardList({
    Key? key,
    required this.emoji,
    required this.workoutName,
    required this.dateTime,
    required this.hours,
    required this.minutes,
    required this.ontapDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Text(
          emoji,
          style: const TextStyle(fontSize: 15),
          overflow: TextOverflow.ellipsis,
          softWrap: true,
        ),
        title: Text(
          workoutName,
          style: const TextStyle(fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Duration: ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              dateTime,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            ontapDelete();
          },
        ),
      ),
    );
  }
}
