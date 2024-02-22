import 'package:flutter/material.dart';
import 'package:healthapp/models/Data_Model/workout_model.dart';
import 'package:healthapp/view-models/user_provider.dart';
import 'package:healthapp/view-models/workout_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

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
    final workoutProvider = context.read<WorkoutProvider>();
    final userProvider = context.read<UserProvider>();

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
                  key: const Key("workoutDropdown"),
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
                    key: const Key("hoursTextField"),
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
                    key: const Key("minutesTextField"),
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
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Successfully Submitted")),
                  );
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
  }
}
