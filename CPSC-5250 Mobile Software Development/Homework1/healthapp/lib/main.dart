import 'package:flutter/material.dart';
import 'package:healthapp/emotion_recorder.dart';
import 'package:healthapp/diet_recorder.dart';
import 'package:healthapp/workout_recorder.dart';

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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Healthfy", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(7, 59, 76, 1),
      ),
      body: const Pagination(),
    );
  }
}

class Pagination extends StatefulWidget {
  const Pagination({super.key});

  @override
  PaginationState createState() {
    return PaginationState();
  }
}

class PaginationState extends State<Pagination> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Column(
      children: <Widget>[
        Expanded(
          child: PageView(
            controller: controller,
            children: const <Widget>[
              EmotionRecorder(),
              DietRecorder(),
              WorkoutRecorder()
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                controller.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}