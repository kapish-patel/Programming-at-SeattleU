import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthapp/view-models/emotion_provider.dart';
import 'package:healthapp/view-models/switcher_provider.dart';
import 'package:healthapp/views/custom_bottom_sheet.dart';
import 'package:healthapp/views/custom_bottom_sheet_ios.dart';
import 'package:healthapp/views/emotion_recorder/emotion_history.dart';
import 'package:healthapp/views/emotion_recorder/emotion_selector.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:healthapp/views/switcher.dart';
import 'package:provider/provider.dart';

class EmotionRecorderPage extends StatelessWidget {
  const EmotionRecorderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSwitched = context.watch<SwitcherProvider>().isSwitched;
    return Scaffold(
      appBar: AppBar(
        title: Text('${AppLocalizations.of(context)!.emotion} ${AppLocalizations.of(context)!.recorder}',),
        actions: [
          const Switcher(),
          IconButton(
            onPressed: () {
              isSwitched ? showCupertinoModalPopup(
                context: context, 
                builder: (context) {
                  return const CustomBottomSheetIos();
                }
              )
              :
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
          const EmotionSelector(),
        ],
      ),
    );
  }
}
