import 'package:flutter/material.dart';

class DedicationProvider extends ChangeNotifier{

  int _decidationLevel;
  int _recordingPoints; 
  DateTime _lastRecorded;
  String _lastRecordedString;

  DedicationProvider()
      : _decidationLevel = 0,
        _recordingPoints = 0,
        _lastRecorded = DateTime.now(),
        _lastRecordedString = "";

  int get getDecidationLevel => _decidationLevel;
  int get getRecordingPoints => _recordingPoints;
  DateTime get getLastRecorded => _lastRecorded;
  String get getLastRecordedString => _lastRecordedString;

  setDecidationLevel(int level){
    _decidationLevel = level;
    notifyListeners();
  }

  setRecordingPoints(int points){
    _recordingPoints = points;
    notifyListeners();
  }

  setLastRecorded(DateTime time){
    _lastRecorded = time;
    notifyListeners();
  }

  setLastRecordedString(String str){
    _lastRecordedString = str;
    notifyListeners();
  }

}