import 'package:flutter/cupertino.dart';
import 'package:healthapp/models/Data_Model/user_model.dart';
import 'package:healthapp/view-models/user_provider.dart';
import 'package:provider/provider.dart';

class CustomBottomSheetIos extends StatelessWidget {
  const CustomBottomSheetIos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text('User Points and Level'),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: FutureBuilder<UserModel>(
            future: Future.value(Provider.of<UserProvider>(context).user),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading..."); // Placeholder while waiting for data
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final userModel = snapshot.data!;
                return Text(
                  "Recording Points: ${userModel.recordingPoints}",
                  style: const TextStyle(fontSize: 16.0),
                );
              }
            },
          ),
          onPressed: () {},
        ),
        CupertinoActionSheetAction(
          child: FutureBuilder<UserModel>(
            future: Future.value(Provider.of<UserProvider>(context).user),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading..."); // Placeholder while waiting for data
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final userModel = snapshot.data!;
                return Text(
                  "Level: ${userModel.level}",
                  style: const TextStyle(fontSize: 16.0),
                );
              }
            },
          ),
          onPressed: () {},
        ),
        CupertinoActionSheetAction(
          child: FutureBuilder<UserModel>(
            future: Future.value(Provider.of<UserProvider>(context).user),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading..."); // Placeholder while waiting for data
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final userModel = snapshot.data!;
                return Text(
                  "Last Recorded: ${userModel.lastRecorded}",
                  style: const TextStyle(fontSize: 16.0),
                );
              }
            },
          ),
          onPressed: () {},
        ),
        CupertinoActionSheetAction(
          child: FutureBuilder<UserModel>(
            future: Future.value(Provider.of<UserProvider>(context).user),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading..."); // Placeholder while waiting for data
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final userModel = snapshot.data!;
                return Text(
                  "Remaining Points: ${100 - userModel.recordingPoints}",
                  style: const TextStyle(fontSize: 16.0),
                );
              }
            },
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}