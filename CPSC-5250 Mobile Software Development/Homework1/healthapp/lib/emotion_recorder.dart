import 'package:flutter/material.dart';
import 'package:healthapp/card_list.dart';


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
  final Map<String, List<String>> emotionList = {
    "😊": ["Happy", "1-1-1"],
    "😢": ["Sad", "1-1-1"],
    "😂": ["Laughing","1-1-1"],
    "😍": ["In Love","1-1-1"],
    "😎": ["Cool","1-1-1"],
    "😐": ["Neutral","1-1-1"],
    "😡": ["Angry","1-1-1"],
    "😴": ["Sleepy","1-1-1"],
    "🥳": ["Celebrating","1-1-1"],
    "🤔": ["Thinking","1-1-1"],
    "😇": ["Angel","1-1-1"],
    "😈": ["Devilish","1-1-1"],
  } ;

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
