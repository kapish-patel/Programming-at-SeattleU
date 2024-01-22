import 'package:flutter/material.dart';
import 'package:healthapp/custom_emotion_card.dart';

class EmotionSelector extends StatelessWidget {
  final void Function({required String emoji, required String data}) addEmotion;

  //constructor
  EmotionSelector({Key? key, required this.addEmotion}) : super(key: key);

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
    return Container(
      height: 45.0,
      child:ListView(
        scrollDirection: Axis.horizontal,
        children: emojiExpressions.keys.map((String key) {
          return GestureDetector(
            onTap: () {
              addEmotion(emoji: key, data: emojiExpressions[key]!);
            },
            child:CustomEmotionCard(emoji: key, data: emojiExpressions[key]!),
          ); 
        }).toList(),
      ),
    );
  }
}