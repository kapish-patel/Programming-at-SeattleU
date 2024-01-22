import 'package:flutter/material.dart';
import 'package:healthapp/data_classes/diet_recorder_event.dart';

class DietRecorderPage extends StatefulWidget {
  const DietRecorderPage({Key? key}) : super(key: key);

  @override
  State<DietRecorderPage> createState() => _DietRecorderPageState();
}

class _DietRecorderPageState extends State<DietRecorderPage> {
  
  final List<DietRecorderEvent> _dietRecorderEvents = <DietRecorderEvent>[];

  _addDietRecorderEvent(DietRecorderEvent dietRecorderEvent) {
    setState(() {
      _dietRecorderEvents.add(dietRecorderEvent);
    });
  }

  @override
  Widget build(BuildContext context){
    return Container(
      child: Text('Diet Recorder Page'),
    );
  }
}
