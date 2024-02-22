import 'package:flutter/material.dart';

class CustomEmotionCard extends StatelessWidget{
  final String emoji;
  final String data;
  const CustomEmotionCard({Key? key, required this.emoji, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 1.0)
      ),
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0),
      margin: const EdgeInsets.fromLTRB(4.0, 8.0, 5.0, 7.0),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 15.0)),
          Text(data, style: const TextStyle(fontSize: 15.0)),
        ],
      ),
    );
  }
}