import 'package:flutter/material.dart';

class EmotionCardList extends StatelessWidget {

  final String emoji;
  final String emotionName;
  final String dateTime;
  final Function ontapDelete;

  const EmotionCardList({super.key, 
    required this.emoji,
    required this.emotionName,
    required this.dateTime,
    required this.ontapDelete
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Text(
          emoji,
          style: const TextStyle(fontSize: 24),
        ),
        title: Text(
          emotionName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          dateTime,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            ontapDelete();
          }
        ),
      ),
    );
  }
}
