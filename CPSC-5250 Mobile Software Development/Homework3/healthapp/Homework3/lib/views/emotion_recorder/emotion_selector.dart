import 'package:flutter/material.dart';
import 'package:healthapp/models/Data_Model/emotion_model.dart';
import 'package:healthapp/view-models/user_provider.dart';
import 'package:healthapp/views/emotion_recorder/custom_emotion_card.dart';
import 'package:healthapp/view-models/emotion_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class EmotionSelector extends StatelessWidget {

  //constructor
  EmotionSelector({Key? key}) : super(key: key);

  //map of emoji expressions
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
    final emotionProvider = context.read<EmotionProvider>();
    final userProvider = context.read<UserProvider>();

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
              String uuid = const Uuid().v4();

              // call the calculate function from the provider
              userProvider.calculatePoints(time, "Emotion");

              final event = EmotionModel(emoji, emotion, time, uuid);
              emotionProvider.addEmotion(event);
            },
            child:CustomEmotionCard(emoji: key, data: emojiExpressions[key]!),
          ); 
        }).toList(),
      ),
    );
  }
}