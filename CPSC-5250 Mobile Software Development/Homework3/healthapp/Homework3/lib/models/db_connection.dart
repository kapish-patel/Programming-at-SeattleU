import 'package:healthapp/models/Collections/diet_isar.dart';
import 'package:healthapp/models/Collections/emotion_isar.dart';
import 'package:healthapp/models/Collections/user_isar.dart';
import 'package:healthapp/models/Collections/workout_isar.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class Database {
  static late Isar _isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [WorkoutRecorderEventIsarSchema, DietRecorderEventIsarSchema, EmotionRecorderEventIsarSchema, UserIsarSchema],
      directory: dir.path,
    );
  }

  static Isar get isar {
    return _isar;
  }
}
