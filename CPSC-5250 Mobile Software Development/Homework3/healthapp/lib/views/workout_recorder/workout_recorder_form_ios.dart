import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthapp/models/Data_Model/workout_model.dart';
import 'package:healthapp/view-models/user_provider.dart';
import 'package:healthapp/view-models/workout_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class WorkoutRecorderFormIos extends StatefulWidget {
  const WorkoutRecorderFormIos({Key? key}) : super(key: key);

  @override
  State<WorkoutRecorderFormIos> createState() => _WorkoutRecorderFormIosState();
}

class _WorkoutRecorderFormIosState extends State<WorkoutRecorderFormIos> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController workoutDurationHours = TextEditingController();
  final TextEditingController workoutDurationMinutes = TextEditingController();
  final TextEditingController workoutNameController = TextEditingController();
  final TextEditingController workoutEmojiController = TextEditingController();

  late Map<String, String> exerciseList;

  bool _isExerciseListInitialized = false;

  @override
  void initState() {
    super.initState();
    workoutEmojiController.text = "🏋️‍♀️";
  }

  String dropdownValue = "🏋️‍♀️";

  @override
  Widget build(BuildContext context) {
    if (!_isExerciseListInitialized) {
      // Initialize exerciseList only once when the widget builds for the first time
      exerciseList = {
        "🏋️‍♀️": AppLocalizations.of(context)!.workout,
        "🏃‍♀️": AppLocalizations.of(context)!.running,
        "🚴‍♀️": AppLocalizations.of(context)!.cycling,
        "🏊‍♀️": AppLocalizations.of(context)!.swimming,
        "🧘‍♀️": AppLocalizations.of(context)!.yoga,
        "🏸": AppLocalizations.of(context)!.badminton,
        "🏓": AppLocalizations.of(context)!.tableTennis,
        "🏀": AppLocalizations.of(context)!.basketball,
        "⚽": AppLocalizations.of(context)!.football,
        "🏐": AppLocalizations.of(context)!.volleyball,
        "🏈": AppLocalizations.of(context)!.americanFootball,
        "🎾": AppLocalizations.of(context)!.lawnTennis,
      };
      _isExerciseListInitialized = true;
      workoutNameController.text = exerciseList[dropdownValue]!;
    }

    final workoutProvider = context.read<WorkoutProvider>();
    final userProvider = context.read<UserProvider>();

    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  " ${AppLocalizations.of(context)!.selectWorkout}:",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Expanded(
                  child: CupertinoButton(
                    onPressed: () {
                      // Show the picker
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 200, // Adjust the height according to your needs
                            child: CupertinoPicker(
                              itemExtent: 32.0,
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  dropdownValue = exerciseList.keys.toList()[index];
                                  workoutEmojiController.text = dropdownValue;
                                  workoutNameController.text = exerciseList[dropdownValue]!;
                                });
                              },
                              children: exerciseList.entries.map((e) {
                                return Text("${e.key} - ${e.value}");
                              }).toList(),
                            ),
                          );
                        },
                      );
                    },
                    child: Text(workoutNameController.text),
                  ),
                ),
              ],
            ),
            Text(
              AppLocalizations.of(context)!.workoutDuration,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CupertinoTextField(
                    key: const Key("hoursTextField"),
                    controller: workoutDurationHours,
                    keyboardType: TextInputType.number,
                    placeholder: AppLocalizations.of(context)!.hours,
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide()),
                    ),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return '${AppLocalizations.of(context)!.pleaseEnterWorkoutDuration} ${AppLocalizations.of(context)!.hours}';
                    //   }
                    //   return null;
                    // },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CupertinoTextField(
                    key: const Key("minutesTextField"),
                    controller: workoutDurationMinutes,
                    keyboardType: TextInputType.number,
                    placeholder: AppLocalizations.of(context)!.minutes,
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide()),
                    ),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return '${AppLocalizations.of(context)!.pleaseEnterWorkoutDuration} ${AppLocalizations.of(context)!.minutes}';
                    //   }
                    //   return null;
                    // },
                  ),
                ),
              ],
            ),
            CupertinoButton(
              color: const Color.fromARGB(255, 255, 191, 0),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppLocalizations.of(context)!.successfullySubmitted)));
                  FocusScope.of(context).unfocus();
                  var date = DateTime.now();

                  // call the calculate points function from the provider
                  userProvider.calculatePoints(date, "Workout");

                  WorkoutModel event = WorkoutModel(
                    workoutEmojiController.text,
                    workoutNameController.text,
                    int.parse(workoutDurationHours.text),
                    int.parse(workoutDurationMinutes.text),
                    date,
                    const Uuid().v4(),
                  );

                  workoutProvider.addWorkout(event);

                  workoutDurationHours.clear();
                  workoutDurationMinutes.clear();
                }
              },
              child: Text(
                AppLocalizations.of(context)!.submit,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
