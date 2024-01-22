import 'package:flutter/material.dart';
import 'package:healthapp/data_classes/emotion_recorder_event.dart';
import 'package:healthapp/emotion_selector.dart';
import 'package:healthapp/emotion_history.dart';

class EmotionRecorderPage extends StatefulWidget {
  const EmotionRecorderPage({Key? key}) : super(key: key);

  @override
  State<EmotionRecorderPage> createState() => _EmotionRecorderPageState();

}

class _EmotionRecorderPageState extends State<EmotionRecorderPage> {

  final List<EmotionRecorderEvent> emotionRecorderEvents = [];

  _addEmotion({required String emoji, required String data}) {
    setState(() {
      emotionRecorderEvents.add(EmotionRecorderEvent(emoji, data, DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context){
    return Container(
      child: Column(
        children: [
          Expanded(child: EmotionHistory(emotionRecorderEventsHistory: emotionRecorderEvents,)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50.0,
              color: Colors.white,
              child: Center(
                child: EmotionSelector(addEmotion: _addEmotion),
              ),
            ),
          ),
        ],
      )
    );
  }
}