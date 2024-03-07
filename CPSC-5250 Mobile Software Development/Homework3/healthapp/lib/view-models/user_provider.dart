import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:healthapp/models/Data_Model/user_model.dart';
import 'package:healthapp/models/Repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository;
  UserModel? _user;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late FirebaseAuth _auth;
  late StreamSubscription<User?> _authStateChangesSubscription;
  late StreamController<UserModel?> _userStreamController;
  List<UserModel>? _leaderBoard;



  UserProvider(this._userRepository, FirebaseAuth auth) {
    _getUser();
    _auth = auth;
    _userStreamController = StreamController<UserModel?>();
    _authStateChangesSubscription = _auth.authStateChanges().listen((User? user) async {
      // if user variable have value then get user from firebase
      if (user != null){
        // if user is signed is then get user from firebase
        _user = await _userRepository.getUserFromFirebase(user);
      } else {
        // else get user from local db
        _user = await _userRepository.getUser();
      }
      _userStreamController.add(_user);
    });
    getLeaderboard();
  }

  // Get user
  UserModel? get user => _user;

  // Get user stream
  Stream<UserModel?> get userStream => _userStreamController.stream;

  // Get leaderboard
  List<UserModel>? get leaderboard => _leaderBoard;


  // Add or update user
  Future<void> addUser(UserModel user) async {
    await _userRepository.adduser(user);
    _getUser();
  }

  // Get user
  Future<void> _getUser() async {
    _user = await _userRepository.getUser();
    notifyListeners();
  }

  // Calculate points
  Future<void> calculatePoints(DateTime newTime, String newLastRecordedString) async {
    final userModel = user;
    int recordingPoints = userModel!.recordingPoints;
    DateTime lastRecorded = userModel.lastRecorded;
    String lastRecordedString = userModel.lastRecordedString;
    int level = userModel.level;

    // Calculate the points
    int difference = newTime.difference(lastRecorded).inMinutes;
    if (difference < 20 && lastRecordedString == newLastRecordedString) {
      userModel.recordingPoints = recordingPoints + 1;
    } else {
      userModel.recordingPoints += 2;
    }

    // Calculate the level
    if (userModel.recordingPoints >= 100) {
      userModel.level = level + 1;
      userModel.recordingPoints = 0;
    }

    // Set the last recorded time
    userModel.lastRecorded = newTime;

    // Set the last recorded string
    userModel.lastRecordedString = newLastRecordedString;

    // Update the user
    addUser(userModel);

    // Update the user in firebase
    _userRepository.addUserToFirebase(userModel);

    // update the leaderboard
    getLeaderboard();
    // Notify listeners
    notifyListeners();
  }


  // Sign in with google 
  Future<void> signinWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential = await _auth.signInWithCredential(authCredential);
        final User? user = userCredential.user;
        
        if (user != null) {
          // perform merge of local and firebase user data
          // check if the user exists in the firebase db check with email
          // get user data from firebase db

          UserModel? firebaseUser = await _userRepository.getUserWithEmailFromFirebase(user);
          if (firebaseUser != null) {
            // if user exists in firebase db then update the user in local db
            UserModel newUserDetails = UserModel(
              firebaseUser.level,
              firebaseUser.recordingPoints,
              firebaseUser.lastRecorded,
              firebaseUser.lastRecordedString,
              firebaseUser.uuid,
              true,
              user.displayName!,
              user.email!,
              user.photoURL!);
            // add user in isar db
            addUser(newUserDetails);
            notifyListeners();
          }
          else {
            // if user does not exists in firebase db then add user in firebase db
            UserModel newUserDetails = UserModel(
              _user!.level,
              _user!.recordingPoints,
              _user!.lastRecorded,
              _user!.lastRecordedString,
              _user!.uuid,
              true,
              user.displayName!,
              user.email!,
              user.photoURL!);
            // add user in isar db
            addUser(newUserDetails);
            // add user in firebase db
            _userRepository.addUserToFirebase(newUserDetails);
            notifyListeners();
          }
        }
        else {
          print("Google Sign In Failed");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  // get leaderboard
  Future<void> getLeaderboard() async {
   _leaderBoard = await _userRepository.getLeaderboard();
   notifyListeners();
  }
  
}
