import 'package:flutter/material.dart';
import 'package:healthapp/data_classes/emotion_recorder_event.dart';

class EmotionProvider extends ChangeNotifier {
  final List<EmotionRecorderEvent> _emotions = [];

  List<EmotionRecorderEvent> get emotions => _emotions;

  void addEmotion(EmotionRecorderEvent emotion) {
    _emotions.add(emotion);
    notifyListeners();
  }
}