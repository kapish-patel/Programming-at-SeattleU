import 'package:flutter/material.dart';
import 'package:healthapp/data_classes/emotion_recorder_event.dart';
import 'package:healthapp/old/card_list.dart';

class EmotionHistory extends StatefulWidget{
  final List<EmotionRecorderEvent> emotionRecorderEventsHistory;
  
  const EmotionHistory({Key? key, required this.emotionRecorderEventsHistory }) : super(key: key);

  @override
  State<EmotionHistory> createState() => _EmotionHistoryState();
}

class _EmotionHistoryState extends State<EmotionHistory> {

  final ScrollController _scrollController = ScrollController(); 

  List<EmotionRecorderEvent> emotionRecorderEventsHistory = [];

  @override
  void initState() {
    super.initState();
    emotionRecorderEventsHistory = widget.emotionRecorderEventsHistory;
  }

// start working here for auto scrolling and adding new items to the list
  @override
  Widget build(BuildContext context){
    return Container(
      height: 300.0,
      child: ListView.builder(
        controller: _scrollController,
        reverse: false,
        itemCount: emotionRecorderEventsHistory.length,
        itemBuilder: (context, index) {
          return CardList(
            emoji: emotionRecorderEventsHistory[index].emoji,
            value: [emotionRecorderEventsHistory[index].emotionName, emotionRecorderEventsHistory[index].dateTime.toString()]);
        },
      ),
    );
  }

  // This is the part that makes the list auto scroll to the bottom
  @override
  void didUpdateWidget(EmotionHistory oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}