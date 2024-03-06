class UserModel{

  int level;
  int recordingPoints; 
  DateTime lastRecorded;
  String lastRecordedString;
  String uuid;
  bool isregistered;
  String displayName;
  String email;
  String photoURL;

  UserModel(this.level, this.recordingPoints, this.lastRecorded, this.lastRecordedString, this.uuid, this.isregistered, this.displayName, this.email, this.photoURL);
}