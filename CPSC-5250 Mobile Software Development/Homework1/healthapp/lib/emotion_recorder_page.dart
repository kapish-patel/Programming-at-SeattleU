import 'package:flutter/material.dart';

class EmotionRecorderPage extends StatefulWidget {
  const EmotionRecorderPage({Key? key}) : super(key: key);

  @override
  State<EmotionRecorderPage> createState() => _EmotionRecorderPageState();

}

class _EmotionRecorderPageState extends State<EmotionRecorderPage> {

  @override
  Widget build(BuildContext context){
    return Container(
      child: const Text('Emotion Recorder Page'),
    );
  }
}