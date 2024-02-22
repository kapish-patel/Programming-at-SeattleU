import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthapp/view-models/switcher_provider.dart';
import 'package:healthapp/view-models/workout_provider.dart';
import 'package:healthapp/views/custom_bottom_sheet.dart';
import 'package:healthapp/views/custom_bottom_sheet_ios.dart';
import 'package:healthapp/views/switcher.dart';
import 'package:healthapp/views/workout_recorder/workout_history.dart';
import 'package:healthapp/views/workout_recorder/workout_recorder_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:healthapp/views/workout_recorder/workout_recorder_form_ios.dart';
import 'package:provider/provider.dart';


class WorkoutRecorderPage extends StatelessWidget {
  const WorkoutRecorderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
    final isSwitched = context.watch<SwitcherProvider>().isSwitched;
    return Scaffold(
      appBar: AppBar(
        title: Text('${AppLocalizations.of(context)!.workout} ${AppLocalizations.of(context)!.recorder}'),
        actions: [
          const Switcher(),
          IconButton(
            onPressed: () {
              isSwitched ?
              showCupertinoModalPopup(
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
      body: Container(
      child: Column(
        children: <Widget>[
          isSwitched ? 
          const WorkoutRecorderFormIos()
          :
          const WorkoutRecorderForm(),
          Expanded(
            child: FutureBuilder(
              future: workoutProvider.getWorkouts(), 
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return WorkoutHistory();
                }
              }
            ),
          ),
        ],
      )
    ) ,
    );
  }
}
