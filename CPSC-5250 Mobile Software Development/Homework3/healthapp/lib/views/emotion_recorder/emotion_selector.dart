import 'package:flutter/material.dart';
import 'package:healthapp/models/Data_Model/emotion_model.dart';
import 'package:healthapp/view-models/user_provider.dart';
import 'package:healthapp/views/emotion_recorder/custom_emotion_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:healthapp/view-models/emotion_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class EmotionSelector extends StatelessWidget {

  //constructor
  const EmotionSelector({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context){
    final emotionProvider = context.read<EmotionProvider>();
    final userProvider = context.read<UserProvider>();

    //map of emoji expressions
    final Map<String, String> emojiExpressions = {
      "😊": AppLocalizations.of(context)!.happy,
      "😢": AppLocalizations.of(context)!.sad,
      "😂": AppLocalizations.of(context)!.laughing,
      "😍": AppLocalizations.of(context)!.inLove,
      "😎": AppLocalizations.of(context)!.cool,
      "😐": AppLocalizations.of(context)!.neutral,
      "😡": AppLocalizations.of(context)!.angry,
      "😴": AppLocalizations.of(context)!.sleepy,
      "🥳": AppLocalizations.of(context)!.celebrating,
      "🤔": AppLocalizations.of(context)!.thinking,
      "😇": AppLocalizations.of(context)!.angel,
      "😈": AppLocalizations.of(context)!.devilish,
      "🤗": AppLocalizations.of(context)!.hugging,
      "🤢": AppLocalizations.of(context)!.nauseated,
      "🤐": AppLocalizations.of(context)!.zippedLips,
      "😪": AppLocalizations.of(context)!.sleepyFace,
      "😳": AppLocalizations.of(context)!.blushing,
      "🙄": AppLocalizations.of(context)!.faceWithRollingEyes,
      "😷": AppLocalizations.of(context)!.faceWithMedicalMask,
      "🥺": AppLocalizations.of(context)!.pleadingFace,
      "🤯": AppLocalizations.of(context)!.explodingHead,
      "😸": AppLocalizations.of(context)!.grinningCatFace,
      "😱": AppLocalizations.of(context)!.surprised,
      "🤩": AppLocalizations.of(context)!.starstruck,
    };


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