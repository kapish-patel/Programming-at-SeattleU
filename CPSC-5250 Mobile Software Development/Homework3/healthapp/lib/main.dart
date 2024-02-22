import 'package:flutter/material.dart';
import 'package:healthapp/models/Collections/diet_isar.dart';
import 'package:healthapp/models/Collections/emotion_isar.dart';
import 'package:healthapp/models/Collections/user_isar.dart';
import 'package:healthapp/models/Collections/workout_isar.dart';
import 'package:healthapp/models/Repositories/diet_repository.dart';
import 'package:healthapp/models/Repositories/emotion_repository.dart';
import 'package:healthapp/models/Repositories/user_repository.dart';
import 'package:healthapp/models/Repositories/workout_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:healthapp/models/db_connection.dart';
import 'package:healthapp/view-models/diet_provider.dart';
import 'package:healthapp/view-models/emotion_provider.dart';
import 'package:healthapp/view-models/switcher_provider.dart';
import 'package:healthapp/view-models/user_provider.dart';
import 'package:healthapp/view-models/workout_provider.dart';
import 'package:provider/provider.dart';
import 'package:isar/isar.dart';
import 'router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Database.init();
  final isar = Database.isar; 
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context) => DietProvider(DietRepository(isar.dietRecorderEventIsars))),
        ChangeNotifierProvider(create:(context) => EmotionProvider(EmotionRepository(isar.emotionRecorderEventIsars))),
        ChangeNotifierProvider(create:(context) => WorkoutProvider(WorkoutRepository(isar.workoutRecorderEventIsars))),
        ChangeNotifierProvider(create:(context) => UserProvider(UserRepository(isar.userIsars))),
        ChangeNotifierProvider(create: (context) => SwitcherProvider()),
      ],
      child: MyApp(isar: isar),
    )
  );
}

class MyApp extends StatelessWidget {
  final Isar isar;
  const MyApp({Key? key, required this.isar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: goRouter, 
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
    );
  }
}
