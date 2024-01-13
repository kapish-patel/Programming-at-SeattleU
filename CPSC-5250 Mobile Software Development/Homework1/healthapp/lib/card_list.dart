import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  final String emoji;
  final List<String> value;
  const CardList({
    required this.emoji,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      child: Card(
        child: ListTile(
          leading: Text(emoji, style: const TextStyle(fontSize: 30.0)),
          title: Text(value[0]),
          subtitle: Text(value[1]),
          trailing: const Icon(Icons.more_vert),
        ),
      ),
    );
  }
}