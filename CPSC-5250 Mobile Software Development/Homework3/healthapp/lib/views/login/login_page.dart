import 'package:flutter/material.dart';
import 'package:healthapp/router.dart';
import 'package:healthapp/view-models/user_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            goRouter.go('/leaderboard');
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Center(
          child : Column(
            children: <Widget>[
              // add logo   start here by making a simple healph app logo
              Image.asset('assets/images/healthify.png'),
              // add spacing
              const SizedBox(height: 50),
              // add Sign in with Google button
              InkWell(
                onTap: () async {
                  // sign in with google
                  await userProvider.signinWithGoogle();
                  if (userProvider.user?.isregistered != false) {
                    goRouter.go('/leaderboard');
                  } 
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/images/google.png'),
                        height: 35,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Sign in with Google',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
          )
        )
      )
    );
  }
}