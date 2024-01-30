import 'package:flutter/material.dart';
import 'package:healthapp/emotion_selector.dart';
import 'package:healthapp/emotion_history.dart';

class EmotionRecorderPage extends StatefulWidget {
  const EmotionRecorderPage({Key? key}) : super(key: key);

  @override
  State<EmotionRecorderPage> createState() => _EmotionRecorderPageState();
}
class _EmotionRecorderPageState extends State<EmotionRecorderPage> {
  @override
  Widget build(BuildContext context){
    return Container(
      child: Column(
        children: [
          const Expanded(
            child: EmotionHistory()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50.0,
              color: Colors.white,
              child: Center(
                child: EmotionSelector(),
              ),
            ),
          ),
        ],
      )
    );
  }
}