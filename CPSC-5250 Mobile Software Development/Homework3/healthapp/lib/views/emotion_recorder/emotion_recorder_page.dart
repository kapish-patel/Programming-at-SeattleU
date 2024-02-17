import 'package:flutter/material.dart';
import 'package:healthapp/view-models/emotion_provider.dart';
import 'package:healthapp/views/custom_bottom_sheet.dart';
import 'package:healthapp/views/emotion_recorder/emotion_history.dart';
import 'package:healthapp/views/emotion_recorder/emotion_selector.dart';
import 'package:provider/provider.dart';

class EmotionRecorderPage extends StatelessWidget {
  const EmotionRecorderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emotion Recorder'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context, 
                builder: (context) => const CustomBottomSheet()
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Provider.of<EmotionProvider>(context, listen: false).getEmotions(), 
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return EmotionHistory();
                }
              },
            ),
          ),
          EmotionSelector(),
        ],
      ),
    );
  }
}
