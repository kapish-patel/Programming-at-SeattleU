import 'package:flutter/material.dart';
import 'package:healthapp/models/Repositories/emotion_repository.dart';
import 'package:healthapp/models/Data_Model/emotion_model.dart';

class EmotionProvider extends ChangeNotifier {

  final EmotionRepository _emotionRepository;

  EmotionProvider(this._emotionRepository);

  final List<EmotionModel> _emotions = [];

  List<EmotionModel> get emotions => _emotions;

  void addEmotion(EmotionModel emotion) {
    _emotionRepository.addEmotion(emotion);
    _emotions.add(emotion);
    notifyListeners();
  }

  // get all emotions from the list before the widget is built
  Future<void> getEmotions() async {
    _emotions.clear();
    _emotions.addAll(await _emotionRepository.getEmotions());
    notifyListeners();
  }

  void deleteEmotion(String uuid) {
    _emotions.removeWhere((element) => element.uuid == uuid);
    _emotionRepository.deleteEmotion(uuid);
    notifyListeners();
  }
}