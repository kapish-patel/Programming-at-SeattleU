import 'package:flutter/material.dart';
import 'package:healthapp/data_classes/emotion_recorder_event.dart';

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

    if(_scrollController.hasClients){
      final position = _scrollController.position.minScrollExtent;
      _scrollController.jumpTo(position);
    }
  }

// start working here for auto scrolling and adding new items to the list
  @override
  Widget build(BuildContext context){
    return Container(
      height: 300.0,
      child: ListView.builder(
        controller: _scrollController,
        reverse: true,
        itemCount: emotionRecorderEventsHistory.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(emotionRecorderEventsHistory[index].emoji),
            title: Text(emotionRecorderEventsHistory[index].emotionName),
            subtitle: Text(emotionRecorderEventsHistory[index].dateTime.toString()),
          );
        },
      )
    );
  }
}