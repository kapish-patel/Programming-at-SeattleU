import 'package:flutter/material.dart';
import 'package:healthapp/view-models/user_provider.dart';
import 'package:provider/provider.dart';

class LeaderboardList extends StatelessWidget {
  const LeaderboardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    userProvider.getLeaderboard();
    return Container(
      child: ListView.builder(
        itemCount: userProvider.leaderboard!.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(userProvider.leaderboard![index].photoURL),
              ),
              title: Text(
                userProvider.leaderboard![index].displayName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    "Level: ${userProvider.leaderboard![index].level}",
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Recording Points: ${userProvider.leaderboard![index].recordingPoints}",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  (index + 1).toString(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        }
      )
    );
  }
}