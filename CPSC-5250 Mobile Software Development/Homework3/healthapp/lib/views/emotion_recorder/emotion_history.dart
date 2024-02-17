import 'package:flutter/material.dart';
import 'package:healthapp/view-models/emotion_provider.dart';
import 'package:healthapp/views/emotion_recorder/emotion_card_list.dart';
import 'package:provider/provider.dart';

class EmotionHistory extends StatelessWidget {

  final ScrollController _scrollController = ScrollController();
  
  EmotionHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final EmotionProvider emotionProvider = Provider.of<EmotionProvider>(context);
    return Container(
      height: 300.0,
      child: ListView.builder(
        controller: _scrollController,
        reverse: false,
        itemCount: emotionProvider.emotions.length,
        itemBuilder: (context, index) {
          return EmotionCardList(
            emoji: emotionProvider.emotions[index].emoji,
            emotionName: emotionProvider.emotions[index].emotionName,
            dateTime: emotionProvider.emotions[index].dateTime.toString(),
            ontapDelete: () {
              emotionProvider.deleteEmotion(emotionProvider.emotions[index].uuid);
            }
          );
        },
      )
    );
  }
}
