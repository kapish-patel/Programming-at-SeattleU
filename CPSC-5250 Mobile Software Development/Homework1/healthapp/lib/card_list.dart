import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  final String type;
  final String? emoji;
  final String? mealname;
  final String? calories;
  final String? quantity;
  final String? workoutname;
  final String? hours;
  final String? minuites;
  final String? emotionName;
  final String? dateTime;

  CardList({
    required this.type,
    this.emoji,
    this.mealname,
    this.calories,
    this.quantity,
    this.workoutname,
    this.hours,
    this.minuites,
    this.emotionName,
    this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: emoji != null
            ? Text(
                emoji!,
                style: const TextStyle(fontSize: 24),
              )
            : null,
        title: Text(
          type == 'diet'
              ? mealname ?? ''
              : type == 'workout'
                  ? workoutname ?? ''
                  : emotionName ?? '',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          type == 'diet'
              ? 'Calories: $calories, Quantity: $quantity'
              : type == 'workout'
                  ? 'Duration: ${hours ?? ''}:${minuites ?? ''}'
                  : '',
          style: const TextStyle(fontSize: 16),
        ),
        trailing: Text(
          dateTime ?? '',
          style: const TextStyle(fontSize: 12),
        ),
        onTap: () {
          // Add your onTap logic here
          // This function will be called when the card is tapped
        },
      ),
    );
  }
}
