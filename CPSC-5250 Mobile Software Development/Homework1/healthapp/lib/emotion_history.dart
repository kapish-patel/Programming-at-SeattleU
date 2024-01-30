import 'package:flutter/material.dart';
import 'package:healthapp/data_classes/emotion_recorder_event.dart';
import 'package:healthapp/card_list.dart';
import 'package:provider/provider.dart';
import 'package:healthapp/providers/emotion_provider.dart';

class EmotionHistory extends StatefulWidget{
  
  const EmotionHistory({Key? key}) : super(key: key);

  @override
  State<EmotionHistory> createState() => _EmotionHistoryState();
}

class _EmotionHistoryState extends State<EmotionHistory> {

  final ScrollController _scrollController = ScrollController(); 

  List<EmotionRecorderEvent> _emotionHistory = [];

  @override
  void initState() {
    super.initState();
    _emotionHistory = Provider.of<EmotionProvider>(context, listen: false).emotions;
  }

// start working here for auto scrolling and adding new items to the list
  @override
  Widget build(BuildContext context){
    return Consumer(builder: (context, EmotionProvider emotionProvider, child) {
      return Container(
        height: 300.0,
        child: ListView.builder(
          controller: _scrollController,
          reverse: false,
          itemCount: _emotionHistory.length,
          itemBuilder: (context, index) {
            return CardList(
              type: 'emotion',
              emoji: _emotionHistory[index].emoji,
              emotionName: _emotionHistory[index].emotionName,
              dateTime: _emotionHistory[index].dateTime.toString(),
            );
          },
        )
      );
    });
  }
}