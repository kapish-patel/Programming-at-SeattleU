import 'package:flutter/material.dart';
import 'package:healthapp/models/Data_Model/user_model.dart';
import 'package:healthapp/models/Repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository;
  late Future<UserModel> _user;

  UserProvider(this._userRepository) {
    _getUser();
  }

  // Get user
  Future<UserModel> get user => _user;

  // Add or update user
  Future<void> addUser(UserModel user) async {
    await _userRepository.adduser(user);
    _getUser();
  }

  // Get user
  Future<void> _getUser() async {
    _user = _userRepository.getUser();
    notifyListeners();
  }

  // Calculate points
  Future<void> calculatePoints(DateTime newTime, String newLastRecordedString) async {
    final userModel = await user;
    int recordingPoints = userModel.recordingPoints;
    DateTime lastRecorded = userModel.lastRecorded;
    String lastRecordedString = userModel.lastRecordedString;
    int level = userModel.decidationLevel;

    // Calculate the points
    int difference = newTime.difference(lastRecorded).inMinutes;
    if (difference < 20 && lastRecordedString == newLastRecordedString) {
      userModel.recordingPoints = recordingPoints + 1;
    } else {
      userModel.recordingPoints += 2;
    }

    // Calculate the level
    if (userModel.recordingPoints >= 100) {
      userModel.decidationLevel = level + 1;
      userModel.recordingPoints = 0;
    }

    // Set the last recorded time
    userModel.lastRecorded = newTime;

    // Set the last recorded string
    userModel.lastRecordedString = newLastRecordedString;

    // Update the user
    addUser(userModel);

    // Notify listeners
    notifyListeners();
  }
}
