import 'package:isar/isar.dart';

part 'emotion_isar.g.dart';

@collection
class EmotionRecorderEventIsar{
  Id? id;
  String uuid;
  String emoji;
  String emotionName;
  DateTime dateTime;

  EmotionRecorderEventIsar(this.emoji, this.emotionName, this.dateTime, this.uuid);
}