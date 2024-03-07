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

  Future<UserModel?> getUserWithEmailFromFirebase(User user) {
    // Get user from firebase
    CollectionReference userCollections = FirebaseFirestore.instance.collection('Users');
    return userCollections.where('email', isEqualTo: user.email).get().then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        print("Successfully got user from firebase");
        return UserModel(
          querySnapshot.docs[0]['level'],
          querySnapshot.docs[0]['recordingPoints'],
          (querySnapshot.docs[0]['lastRecorded'] as Timestamp).toDate(), 
          querySnapshot.docs[0]['lastRecordedString'], 
          querySnapshot.docs[0]['uuid'], 
          querySnapshot.docs[0]['isregistered'], 
          querySnapshot.docs[0]['displayName'], 
          querySnapshot.docs[0]['email'], 
          querySnapshot.docs[0]['photoURL']);
      } else {
        return null;
      }
    });
  }

  Future<List<UserModel>> getLeaderboard() async {
  try {
    CollectionReference userCollections = FirebaseFirestore.instance.collection('Users');
    QuerySnapshot querySnapshot = await userCollections.orderBy('level', descending: true).orderBy('recordingPoints', descending: true).get();
    List<UserModel> leaderboard = [];

    querySnapshot.docs.forEach((doc) {
      leaderboard.add(UserModel(
        doc['level'],
        doc['recordingPoints'],
        (doc['lastRecorded'] as Timestamp).toDate(), 
        doc['lastRecordedString'], 
        doc['uuid'], 
        doc['isregistered'], 
        doc['displayName'], 
        doc['email'], 
        doc['photoURL']
      ));
    });

    return leaderboard;
  } catch (e) {
    print('Error fetching leaderboard: $e');
    return []; // Return an empty list in case of an error
  }
}

  
}
