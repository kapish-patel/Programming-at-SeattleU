import 'package:isar/isar.dart';

part 'user_isar.g.dart';

@collection
class UserIsar{
  Id? id;

  String uuid;
  int level;
  int recordingPoints; 
  DateTime lastRecorded;
  String lastRecordedString;
  bool isregistered;
  String displayName;
  String email;
  String photoURL;

  UserIsar(this.level, this.recordingPoints, this.lastRecorded, this.lastRecordedString, this.uuid, this.isregistered, this.displayName, this.email, this.photoURL);
}