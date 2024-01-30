import 'package:flutter/material.dart';
import 'package:healthapp/diet_recorder_page.dart';
import 'package:healthapp/workout_recorder_page.dart';
import 'package:healthapp/emotion_recorder_page.dart';
import 'package:healthapp/providers/diet_provider.dart';
import 'package:healthapp/providers/emotion_provider.dart';
import 'package:healthapp/providers/workout_provider.dart';
import 'package:provider/provider.dart';
import 'package:healthapp/providers/dedication_provider.dart';
import 'package:healthapp/overlay_display.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DedicationProvider()),
        ChangeNotifierProvider(create: (context) => DietProvider()),
        ChangeNotifierProvider(create: (context) => EmotionProvider()),
        ChangeNotifierProvider(create: (context) => WorkoutProvider()),
      ],
      child: MaterialApp(
        title: 'Healthfy',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}
class MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          title: const Text("Healthfy", style: TextStyle(color: Colors.white,)),
          centerTitle: true, 
          actions: [
            IconButton(
              icon: const Icon(Icons.more, color: Colors.white, size: 30,),
              onPressed: () {
                //call the modal bottom sheet
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const OverlayDisplay();
                  },
                );
              },
            )
          ],
          backgroundColor: const Color.fromRGBO(7, 59, 76, 1),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index){
          setState(() {
            _currentIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: _currentIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.emoji_emotions),
            label: 'Emotion',
            selectedIcon: Icon(Icons.emoji_emotions),
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant),
            label: 'Diet',
            selectedIcon: Icon(Icons.restaurant),
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center),
            label: 'Workout',
            selectedIcon: Icon(Icons.fitness_center),
          ),
        ],
      ),
        body: const <Widget>[
        EmotionRecorderPage(),
        DietRecorderPage(),
        WorkoutRecorderPage()
      ].elementAt(_currentIndex),
    );
  }
}
