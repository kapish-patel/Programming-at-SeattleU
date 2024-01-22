import 'package:flutter/material.dart';
import 'package:healthapp/old/card_list.dart';


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

  void _ontapEmoji(String emoji) {
    print("Emoji: $emoji");
    print("Time: ${DateTime.now()}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0, // h space
        runSpacing: 8.0, // v space
        children: List<Widget>.from(
          emojiExpressions.keys.map((emoji) => GestureDetector(
            onTap: () => _ontapEmoji(emoji),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Text(emoji, 
                style: const TextStyle(fontSize: 30.0)
              )
            )
          ), 
        ),
      ),
    )
    );
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
    return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Text(data, 
          style: const TextStyle(fontSize: 30.0)
        )
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
  
  //mock data
  final Map<String, List<String>> emotionList = {
    "😊": ["Happy", "1-1-1, 12:00:PM"],
    "😢": ["Sad", "1-1-1, 12:00:PM"],
    "😂": ["Laughing","1-1-1, 12:00:PM"],
    "😍": ["In Love","1-1-1, 12:00:PM"],
    "😎": ["Cool","1-1-1, 12:00:PM"],
    "😐": ["Neutral","1-1-1, 12:00:PM"],
    "😡": ["Angry","1-1-1, 12:00:PM"],
    "😴": ["Sleepy","1-1-1, 12:00:PM"],
    "😈": ["Devilish","1-1-1, 12:00:PM"],
    
  } ;

  void addnewEmotion(String emoji, String emotion, String date) {
    setState(() {
      emotionList[emoji] = [emotion, date];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: emotionList.length,
        itemBuilder: (BuildContext context, int index) {
          String key = emotionList.keys.elementAt(index);
          List<String> value = emotionList[key]!;
          return CardList(emoji: key, value: value );
        },
      ),
    ); 
  }
}
