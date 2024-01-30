import 'package:flutter/material.dart';
import 'package:healthapp/data_classes/workout_recorder_event.dart';
import 'package:healthapp/providers/dedication_provider.dart';
import 'package:provider/provider.dart';
import 'package:healthapp/providers/workout_provider.dart';

class WorkoutRecorderForm extends StatefulWidget {
  const WorkoutRecorderForm({Key? key,}) : super(key: key);

  @override
  State<WorkoutRecorderForm> createState() => _WorkoutRecorderFormState();
}

class _WorkoutRecorderFormState extends State<WorkoutRecorderForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController workoutDurationHours = TextEditingController();
  final TextEditingController workoutDurationMinutes = TextEditingController();
  final TextEditingController workoutNameController = TextEditingController();
  final TextEditingController workoutEmojiController = TextEditingController();

  final Map<String, String> exerciseList = {
    "🏋️‍♀️": "Workout",
    "🏃‍♀️": "Running",
    "🚴‍♀️": "Cycling",
    "🏊‍♀️": "Swimming",
    "🧘‍♀️": "Yoga",
    "🏸": "Badminton",
    "🏓": "Table Tennis",
    "🏀": "Basketball",
    "⚽": "Football",
    "🏐": "Volleyball",
    "🏈": "American Football",
    "🎾": "Lawn Tennis",
  };

  @override
  void initState() {
    super.initState();
    workoutEmojiController.text = "🏋️‍♀️";
    workoutNameController.text = exerciseList["🏋️‍♀️"]!;
  }
  String dropdownValue = "🏋️‍♀️";

  @override
  Widget build(BuildContext context) {
    return Consumer2(builder: (context, WorkoutProvider workoutProvider, DedicationProvider dedicationProvider, child) {
      return  Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Text("Select Workout:    ", 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    )
                  ),
                  DropdownButton(
                    value: dropdownValue,
                    items: exerciseList.entries.map((e) {
                      return DropdownMenuItem(
                        value: e.key,
                        child: Text("${e.key} - ${e.value}"),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        workoutEmojiController.text = newValue;
                        workoutNameController.text = exerciseList[newValue]!;
                      });
                    },
                  ),
                ],
              ),
              const Text("Workout Duration", 
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
                )
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: workoutDurationHours,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Hours",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter workout duration";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: workoutDurationMinutes,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Minutes",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter workout duration";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 191, 0),
                ),
                onPressed: () {
                  DateTime time = DateTime.now(); 

                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Successfully Submitted")),
                    );

                    FocusScope.of(context).unfocus();
                  

                    int recordingPoints = dedicationProvider.getRecordingPoints;
                    DateTime lastRecorded = dedicationProvider.getLastRecorded;
                    String lastRecordedString = dedicationProvider.getLastRecordedString;
                    int level = dedicationProvider.getDecidationLevel;

                    // calculate the points
                    int difference = time.difference(lastRecorded).inMinutes;
                    if (difference < 20 && lastRecordedString == "Workout") {
                      dedicationProvider.setRecordingPoints(recordingPoints + 1);
                    }
                    else {
                      dedicationProvider.setRecordingPoints(recordingPoints + 2);
                    }

                    // calculate the level
                    if (recordingPoints >= 100){
                      dedicationProvider.setDecidationLevel(level + 1);
                      dedicationProvider.setRecordingPoints(0);
                    }

                    // set the last recorded time
                    dedicationProvider.setLastRecorded(time);

                    // set the last recorded string
                    dedicationProvider.setLastRecordedString("Workout");


                    WorkoutRecorderEvent event = WorkoutRecorderEvent(
                      workoutEmojiController.text,
                      workoutNameController.text,
                      int.parse(workoutDurationHours.text),
                      int.parse(workoutDurationMinutes.text),
                      time,
                    );

                    workoutProvider.addWorkout(event);

                    workoutDurationHours.clear();
                    workoutDurationMinutes.clear();
                  }
                },
                child: const Text("Submit", 
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  )
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
