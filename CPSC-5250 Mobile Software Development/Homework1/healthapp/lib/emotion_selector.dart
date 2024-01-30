import 'package:flutter/material.dart';
import 'package:healthapp/custom_emotion_card.dart';
import 'package:healthapp/data_classes/emotion_recorder_event.dart';
import 'package:provider/provider.dart';
import 'package:healthapp/providers/emotion_provider.dart';
import 'package:healthapp/providers/dedication_provider.dart';

class EmotionSelector extends StatelessWidget {

  //constructor
  EmotionSelector({Key? key}) : super(key: key);

  final Map<String, String> emojiExpressions = {
    "😊": "Happy",
    "😢": "Sad",
    "😂": "Laughing",
    "😍": "In Love",
    "😎": "Cool",
    "😐": "Neutral",
    "😡": "Angry",
    "😴": "Sleepy",
    "🥳": "Celebrating",
    "🤔": "Thinking",
    "😇": "Angel",
    "😈": "Devilish",
    "🤗": "Hugging",
    "🤢": "Nauseated",
    "🤐": "Zipped Lips",
    "😪": "Sleepy Face",
    "😳": "Blushing",
    "🙄": "Face with Rolling Eyes",
    "😷": "Face with Medical Mask",
    "🥺": "Pleading Face",
    "🤯": "Exploding Head",
    "😸": "Grinning Cat Face",
    "😱": "Surprised",
    "🤩": "Starstruck",
  };


  @override
  Widget build(BuildContext context){
    return Consumer2(builder: (context, EmotionProvider emotionProvider, DedicationProvider dedicationProvider, child) {
      return Container(
        height: 45.0,
        child:ListView(
          scrollDirection: Axis.horizontal,
          children: emojiExpressions.keys.map((String key) {
            return GestureDetector(
              onTap: () {
                String emoji = key;
                String emotion = emojiExpressions[key]!;
                DateTime time = DateTime.now();

                String lastRecorded = dedicationProvider.getLastRecordedString;
                DateTime lastRecordedTime = dedicationProvider.getLastRecorded;
                int level = dedicationProvider.getDecidationLevel;
                int recordingPoints = dedicationProvider.getRecordingPoints;

                DateTime now = DateTime.now();
                int minDifference = now.difference(lastRecordedTime).inMinutes;

                // set recording points
                if (lastRecorded == "Emotion" && minDifference < 20) {
                  recordingPoints += 1;
                } 
                else {
                  recordingPoints += 2;
                }
                context.read<DedicationProvider>().setRecordingPoints(recordingPoints);

                // set dedication level
                if (recordingPoints >= 100) {
                  context.read<DedicationProvider>().setDecidationLevel(level + 1);
                  context.read<DedicationProvider>().setRecordingPoints(0);
                }

                // set last recorded string
                context.read<DedicationProvider>().setLastRecordedString("Emotion");
                // set last recorded 
                context.read<DedicationProvider>().setLastRecorded(time);

                final event = EmotionRecorderEvent(emoji, emotion, time);
                context.read<EmotionProvider>().addEmotion(event);
              },
              child:CustomEmotionCard(emoji: key, data: emojiExpressions[key]!),
            ); 
          }).toList(),
        ),
      );
    });
  }
}