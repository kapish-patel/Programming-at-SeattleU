import 'package:flutter/material.dart';
import 'package:healthapp/models/Data_Model/user_model.dart';
import 'package:healthapp/view-models/user_provider.dart';
import 'package:provider/provider.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FutureBuilder<UserModel>(
          future: Provider.of<UserProvider>(context).user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final userModel = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dedication Level: ${userModel.decidationLevel}", style: const TextStyle(fontSize: 20.0)),
                  Text("Recording Points: ${userModel.recordingPoints}", style: const TextStyle(fontSize: 20.0)),
                  Text("Last Recorded: ${userModel.lastRecorded}",style: const TextStyle(fontSize: 20.0)),
                  Text("Need for next level: ${100 - userModel.recordingPoints}", style: const TextStyle(fontSize: 20.0)),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
