import 'package:isar/isar.dart';

part 'user_isar.g.dart';

@collection
class UserIsar{
  Id? id;

  String uuid;
  int decidationLevel;
  int recordingPoints; 
  DateTime lastRecorded;
  String lastRecordedString;

  UserIsar(this.decidationLevel, this.recordingPoints, this.lastRecorded, this.lastRecordedString, this.uuid);
}