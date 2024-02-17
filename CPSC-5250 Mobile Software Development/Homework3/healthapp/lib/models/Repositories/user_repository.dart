import 'package:healthapp/models/Collections/user_isar.dart';
import 'package:healthapp/models/Data_Model/user_model.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

class UserRepository{
  final IsarCollection<UserIsar> _user;

  UserRepository(this._user);

  // get user
  Future<UserModel> getUser() async {
    var user = await _user.where().findFirst();
    if (user != null) {
      return UserModel(user.decidationLevel, user.recordingPoints, user.lastRecorded, user.lastRecordedString, user.uuid);
    } else {
      return UserModel(0, 0, DateTime.now(), "No Record", const Uuid().v4());
    }
  }

  // delete and add user
  Future<void> adduser(UserModel userModel) async {
    _user.where().filter().uuidEqualTo(userModel.uuid).deleteAll();
    await _user.put(UserIsar(userModel.decidationLevel, userModel.recordingPoints, userModel.lastRecorded, userModel.lastRecordedString, userModel.uuid));
  }
  
}
