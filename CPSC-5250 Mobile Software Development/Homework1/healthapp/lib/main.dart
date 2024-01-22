import 'package:flutter/material.dart';
import 'package:healthapp/diet_recorder_page.dart';
import 'package:healthapp/workout_recorder_page.dart';
import 'package:healthapp/emotion_recorder_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthfy',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
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
        preferredSize: const Size.fromHeight(25),
        child: AppBar(
          title: const Text("Healthfy", style: TextStyle(color: Colors.white,)),
          centerTitle: true, 
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
        body: <Widget>[
        const EmotionRecorderPage(),
        const DietRecorderPage(),
        const WorkoutRecorderPage()
      ].elementAt(_currentIndex),
    );
  }
}
