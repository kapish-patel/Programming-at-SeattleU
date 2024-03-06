import 'package:flutter/material.dart';
import 'package:healthapp/view-models/user_provider.dart';
import 'package:healthapp/views/leaderboard/leaderboard_list.dart';
import 'package:healthapp/views/leaderboard/login_overlay.dart';
import 'package:provider/provider.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: Center(
        child: userprovider.user?.isregistered == true
            ? const LeaderboardList()
            : const LoginOverlay(),
      ),
    );
  }
}