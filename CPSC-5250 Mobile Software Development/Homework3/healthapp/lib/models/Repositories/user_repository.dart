import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthapp/models/Collections/user_isar.dart';
import 'package:healthapp/models/Data_Model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

class UserRepository{
  final IsarCollection<UserIsar> _user;

  UserRepository(this._user);

  // get user
  Future<UserModel> getUser() async {
    var user = await _user.where().findFirst();
    if (user != null) {
      return UserModel(user.level, user.recordingPoints, user.lastRecorded, user.lastRecordedString, user.uuid, user.isregistered, user.displayName, user.email, user.photoURL);
    } else {
      return UserModel(0, 0, DateTime.now(), "No Record", const Uuid().v4(), false, "Anonymous", "", "");
    }
  }

  // delete and add user
  Future<void> adduser(UserModel userModel) async {
    await _user.isar.writeTxn(() async {
      _user.where().filter().uuidEqualTo(userModel.uuid).deleteAll();
    });
    await _user.isar.writeTxn(() async {
      await _user.put(UserIsar(userModel.level, userModel.recordingPoints, userModel.lastRecorded, userModel.lastRecordedString, userModel.uuid, userModel.isregistered, userModel.displayName, userModel.email, userModel.photoURL));
    });
  }

  void addUserToFirebase(UserModel newUserDetails) async {
    // Add user to firebase
    try {
      CollectionReference userCollections = FirebaseFirestore.instance.collection('Users');
      await userCollections.doc(newUserDetails.uuid).set({
        'level': newUserDetails.level,
        'recordingPoints': newUserDetails.recordingPoints,
        'lastRecorded': newUserDetails.lastRecorded,
        'lastRecordedString': newUserDetails.lastRecordedString,
        'uuid': newUserDetails.uuid,
        'isregistered': newUserDetails.isregistered,
        'displayName': newUserDetails.displayName,
        'email': newUserDetails.email,
        'photoURL': newUserDetails.photoURL,
      });
      print("User added to firebase");
    }
    catch (e) {
      print(e);
    }
  }

  Future<UserModel?> getUserFromFirebase(User user) {
    // Get user from firebase
    CollectionReference userCollections = FirebaseFirestore.instance.collection('Users');
    return userCollections.doc(user.uid).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return UserModel(
          documentSnapshot['level'],
          documentSnapshot['recordingPoints'],
          documentSnapshot['lastRecorded'], 
          documentSnapshot['lastRecordedString'], 
          documentSnapshot['uuid'], 
          documentSnapshot['isregistered'], 
          documentSnapshot['displayName'], 
          documentSnapshot['email'], 
          documentSnapshot['photoURL']);
      } else {
        return null;
      }
    });
  }
  
}
