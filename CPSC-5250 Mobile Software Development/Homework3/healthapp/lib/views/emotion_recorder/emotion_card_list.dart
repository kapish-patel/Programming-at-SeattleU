import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthapp/view-models/switcher_provider.dart';
import 'package:provider/provider.dart';

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
    final isSwitched = context.watch<SwitcherProvider>().isSwitched;
    return isSwitched ?
    //IOS style:
    //cupertino card
    Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: CupertinoListTile(
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
        trailing: CupertinoButton(
          child: const Icon(Icons.delete),
          onPressed: () {
            ontapDelete();
          }
        ),
      ),
    )
    :
    Card(
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
