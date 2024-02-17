import 'package:healthapp/models/Data_Model/emotion_model.dart';
import 'package:isar/isar.dart';
import 'package:healthapp/models/Collections/emotion_isar.dart';


class EmotionRepository {
  final IsarCollection<EmotionRecorderEventIsar> _emotionRecorderEvent;

  EmotionRepository(this._emotionRecorderEvent);

  // get all names from isar database before the widget is built
  Future<List<EmotionModel>> getEmotions() async {
    var emotions = await _emotionRecorderEvent.where().findAll();
    return emotions.map((e) => EmotionModel(e.emoji, e.emotionName, e.dateTime, e.uuid)).toList();
  }

  // use isar write transaction to add new event
  Future<void> addEmotion(EmotionModel event) async {
    await _emotionRecorderEvent.isar.writeTxn(() async {
      // generate new int uuid for the event
      await _emotionRecorderEvent.put(EmotionRecorderEventIsar(event.emoji, event.emotionName, event.dateTime, event.uuid));
    });
  }

  void deleteEmotion(String uuid) async {
    await _emotionRecorderEvent.isar.writeTxn(() async {
      await _emotionRecorderEvent.filter().uuidEqualTo(uuid).deleteAll();
  });
}


}
