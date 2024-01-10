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
    return Container( 
      color: const Color.fromRGBO(17, 138, 178, 1),
      child: const Column(
        children: <Widget>[
          EmojiSection(),
          EmotionListSection()
        ],
      )
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

  //function to handle emoji tap
  void _onEmojiTap(String emoji) {
    print("User pressed $emoji and is feeling ${emojiExpressions[emoji]}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0, // h space
        runSpacing: 8.0, // v space
        children: List<Widget>.from(
          emojiExpressions.keys.map((emoji) => DisplayCustomEmoji(data: emoji, onTap: () => _onEmojiTap(emoji)))
        ),
      ),
    );
  }
}

class DisplayCustomEmoji extends StatelessWidget {
  final String data;
  final VoidCallback onTap;
  

  const DisplayCustomEmoji({
    required this.data,
    required this.onTap(),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Text(
          data, 
          style: const TextStyle(fontSize: 30.0)
        )
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
  final Map<String, String> emotionList = {
    'kapish': 'asdasd',
    'kapish2': 'asdasd2',
    'kapish3': 'asdasd3',
    'kapish4': 'asdasd4',
    'kapish5': 'asdasd5', 
  } ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: List<Widget>.from(
              emotionList.keys.map((emoji) => EmotionList(data: emoji))
            )
          ),
        ],
      )
    );
  }
}

class EmotionList extends StatelessWidget {
  final String data;
  const EmotionList({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.emoji_emotions_outlined),
          title: Text(data),
          subtitle: const Text('Subtitle'),
          trailing: const Icon(Icons.more_vert),
        ),
      ),
    );
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
    return Scaffold(
      backgroundColor: const Color.fromRGBO(6, 214, 160, 1),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              color: Colors.white,  // Card color is white
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
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
                    ],
                  ),
                ),
              ),
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
      ),
    );
  }
}
class WorkoutRecorder extends StatelessWidget {
  const WorkoutRecorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(239, 71, 111, 1),
      child: const Text("Workout Recorder"),
    ); 
  }
}
