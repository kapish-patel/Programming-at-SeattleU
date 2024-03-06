import 'package:flutter/material.dart';
import 'package:healthapp/router.dart';

class LoginOverlay extends StatelessWidget {
  const LoginOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // sample leaderboard to show the overlay
        Container(
          color: Colors.black.withOpacity(0.2),
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('User $index'),
                subtitle: Text('Points: $index'),
              );
            },
          ),
        ),  

        // overlay
        Container(
          color: Colors.black.withOpacity(0.3),
        ),

        // request for login form
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Please login to view the leaderboard',
                style: TextStyle(color: Colors.white),
              ),
              ElevatedButton(
                onPressed: () {
                  goRouter.go('/login');
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}