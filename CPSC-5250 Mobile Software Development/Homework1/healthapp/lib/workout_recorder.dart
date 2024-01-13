import 'package:flutter/material.dart';
import 'package:healthapp/card_list.dart';

class WorkoutRecorder extends StatelessWidget {
  const WorkoutRecorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(239, 71, 111, 1),
      child: Column(
        children: <Widget>[
          const WorkoutRecorderSection(),
          WorkoutListSection()
        ],
      )
    ); 
  }
}

class WorkoutListSection extends StatelessWidget {
  WorkoutListSection({super.key});
  
  //mock data for now
  final Map<String, List<String>> exerciseList = {
    "🏋️‍♀️": ["Workout", "1-1-1"],
    "🏃‍♀️": ["Running", "1-1-1"],
    "🚴‍♀️": ["Cycling","1-1-1"],
    "🏊‍♀️": ["Swimming","1-1-1"],
    "🧘‍♀️": ["Yoga","1-1-1"],
    "🏸": ["Badminton","1-1-1"],
    "🏓": ["Table Tennis","1-1-1"],
    "🏀": ["Basketball","1-1-1"],
    "⚽": ["Football","1-1-1"],
    "🏐": ["Volleyball","1-1-1"],
    "🏈": ["American Football","1-1-1"],
    "🎾": ["Ten","1-1-1"],
  };

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: exerciseList.length,
        itemBuilder: (BuildContext context, int index) {
          String key = exerciseList.keys.elementAt(index);
          List<String> value = exerciseList[key]!;
          return CardList(emoji: key, value: value);
        },
      ),
    ); 
  }

}

class WorkoutRecorderSection extends StatefulWidget {
  const WorkoutRecorderSection({super.key});

  @override
  WorkoutRecorderSectionState createState() {
    return WorkoutRecorderSectionState();
  }
}

class WorkoutRecorderSectionState extends State<WorkoutRecorderSection>{
  final _formKey = GlobalKey<FormState>();

  final TextEditingController workoutNameController = TextEditingController();
  final TextEditingController workoutDurationController = TextEditingController();

  String dropdownValue = "🏋️‍♀️";

  final Map<String, List<String>> exerciseList = {
    "🏋️‍♀️": ["Workout", "1-1-1"],
    "🏃‍♀️": ["Running", "1-1-1"],
    "🚴‍♀️": ["Cycling","1-1-1"],
    "🏊‍♀️": ["Swimming","1-1-1"],
    "🧘‍♀️": ["Yoga","1-1-1"],
    "🏸": ["Badminton","1-1-1"],
    "🏓": ["Table Tennis","1-1-1"],
    "🏀": ["Basketball","1-1-1"],
    "⚽": ["Football","1-1-1"],
    "🏐": ["Volleyball","1-1-1"],
    "🏈": ["American Football","1-1-1"],
    "🎾": ["Ten,""1-1-1"],
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,  // Card color is white
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[


                // start working here 
                DropdownButton(
                  value: dropdownValue,
                  items: exerciseList.entries.map((e) {
                    return DropdownMenuItem(
                      value: e.key,
                      child: Text("${e.key} - ${e.value[0]}"),
                    );
                  }).toList(),
                  
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                ),
                TextFormField(
                  controller: workoutDurationController,
                  decoration: const InputDecoration(labelText: 'Workout Duration'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter a Valid Workout Duration';
                    }
                    // You can add more validation logic for duration if needed
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process the inputs, for example, save to a database
                      String workoutName = workoutNameController.text;
                      String workoutDuration = workoutDurationController.text;
                      print('Workout name: $workoutName');
                      print('Workout Duration: $workoutDuration');

                      // Clear the input field
                      workoutNameController.clear();
                      workoutDurationController.clear();

                      // Notify the user using snackbar notification
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Successfully submitted Data!'),
                      ));
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}