import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthapp/firebase_options.dart';
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

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );  

  FirebaseAuth auth = FirebaseAuth.instance;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context) => DietProvider(DietRepository(isar.dietRecorderEventIsars))),
        ChangeNotifierProvider(create:(context) => EmotionProvider(EmotionRepository(isar.emotionRecorderEventIsars))),
        ChangeNotifierProvider(create:(context) => WorkoutProvider(WorkoutRepository(isar.workoutRecorderEventIsars))),
        ChangeNotifierProvider(create:(context) => UserProvider(UserRepository(isar.userIsars), auth)),
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


// bug fix for the app
//1. multiple users are being created in the database when the same user is logged in 
//2. update the leaderboard when user loggs in 
//3. update the user if he/she have signed in for leaderboard
//4. log out amd delete the users data if they opt out of the leaderboard
