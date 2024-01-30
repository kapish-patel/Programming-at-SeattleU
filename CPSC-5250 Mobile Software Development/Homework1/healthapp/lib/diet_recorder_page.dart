import 'package:flutter/material.dart';
import 'package:healthapp/diet_recorder_form.dart';
import 'package:healthapp/diet_history.dart';

class DietRecorderPage extends StatefulWidget {
  const DietRecorderPage({Key? key}) : super(key: key);

  @override
  State<DietRecorderPage> createState() => _DietRecorderPageState();
}

class _DietRecorderPageState extends State<DietRecorderPage> {
  @override
  Widget build(BuildContext context){
    return Container(
      child: const Column(
        children: <Widget>[
          DietRecorderForm(),
          Expanded(
            child: DietHistory(),
          ),
        ],
      ),
    );
  }
}
