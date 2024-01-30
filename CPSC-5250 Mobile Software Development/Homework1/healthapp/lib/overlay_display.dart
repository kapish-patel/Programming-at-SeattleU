import 'package:flutter/material.dart';
import 'package:healthapp/providers/dedication_provider.dart';
import 'package:provider/provider.dart';

class OverlayDisplay extends StatelessWidget {
  const OverlayDisplay({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, DedicationProvider dedicationProvider, child) {
      return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Dedication Level: ${dedicationProvider.getDecidationLevel}", style: const TextStyle(fontSize: 20.0)),
              Text("Recording Points: ${dedicationProvider.getRecordingPoints}", style: const TextStyle(fontSize: 20.0)),
              Text("Last Recorded: ${dedicationProvider.getLastRecorded}",style: const TextStyle(fontSize: 20.0)),
              Text("Need ${100 - dedicationProvider.getRecordingPoints} for next level", style: const TextStyle(fontSize: 20.0)),
            ],
          ),
        )
      );
    });
  }
}