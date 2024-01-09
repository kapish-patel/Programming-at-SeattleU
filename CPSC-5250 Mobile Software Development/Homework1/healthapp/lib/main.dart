import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
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
        title: const Text("Healthfy"),
        backgroundColor: Colors.cyanAccent,
      ),
      body: const Pagination(),
    );
  }
}

class Pagination extends StatelessWidget {
  const Pagination({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return PageView(
      controller: controller,
      children: const <Widget>[
        EmotionRecorder(),
        DietRecorder(),
        WorkoutRecorder()
      ],
    );
  }
}

class EmotionRecorder extends StatelessWidget {
  const EmotionRecorder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        EmojiSection(),
        EmotionListSection()
      ],
    );
  }
}

class EmojiSection extends StatefulWidget {
  const EmojiSection({super.key});


  @override
  EmojiGridSectionState createState() {
    return EmojiGridSectionState();
  }
}

class EmojiGridSectionState extends State<EmojiSection>{
  final Map<String, String> emojiExpressions = {
    "😊": "Happy",
    "😢": "Sad",
    "😂": "Laughing",
    "😍": "In Love",
    "😎": "Cool",
    "😐": "Neutral",
    "😡": "Angry",
    "😴": "Sleepy",
    "🥳": "Celebrating",
    "🤔": "Thinking",
    "😇": "Angel",
    "😈": "Devilish",
    "🤗": "Hugging",
    "🤢": "Nauseated",
    "🤐": "Zipped Lips",
    "😪": "Sleepy Face",
    "😳": "Blushing",
    "🙄": "Face with Rolling Eyes",
    "😷": "Face with Medical Mask",
    "🥺": "Pleading Face",
    "🤯": "Exploding Head",
    "😸": "Grinning Cat Face",
    "😱": "Surprised",
    "🤩": "Starstruck",
  };


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0, // h space
        runSpacing: 8.0, // v space
        children: List<Widget>.from(
          emojiExpressions.keys.map((emoji) => DisplayCustomEmoji(data: emoji))
        ),
      ),
    );
  }
}

class EmotionListSection extends StatefulWidget{
  const EmotionListSection({super.key});

  @override
  EmotionListSectionState createState() {
    return EmotionListSectionState();
  }
}

class EmotionListSectionState extends State<EmotionListSection> {
  final String data = "this is Emotion list section";

  @override
  Widget build(BuildContext context) {
    return Text(data);
  }
}


class DisplayCustomEmoji extends StatelessWidget {
  final String data;

  const DisplayCustomEmoji({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(child: Text(data, style: const TextStyle(fontSize: 30.0)));
  }
}

class DietRecorder extends StatefulWidget {
  const DietRecorder({super.key});

  @override
  DietRecorderState createState() {
    return DietRecorderState();
  }
}

class DietRecorderState extends State<DietRecorder> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController mealNameController = TextEditingController();
  final TextEditingController mealQuantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: mealNameController,
            decoration: const InputDecoration(labelText: 'Meal Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter a Valid Meal Name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: mealQuantityController,
            decoration: const InputDecoration(labelText: 'Meal Quantity'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter a Valid Meal Quantity';
              }
              // You can add more validation logic for quantity if needed
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Process the inputs, for example, save to a database
                String mealName = mealNameController.text;
                String mealQuantity = mealQuantityController.text;
                print('Meal name: $mealName');
                print('MealQuantity: $mealQuantity');

                // Clear the input field
                mealNameController.clear();
                mealQuantityController.clear();

                // Notify the user using snackbar notification
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Successfully submitted Data!'),
                ));
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class WorkoutRecorder extends StatelessWidget {
  const WorkoutRecorder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Workout Recorder");
  }
}
