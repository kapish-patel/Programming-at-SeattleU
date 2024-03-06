import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthapp/views/diet_recorder/diet_edit_page.dart';
import 'package:healthapp/views/leaderboard/leaderboard_page.dart';
import 'package:healthapp/views/login/login_page.dart';
import 'package:healthapp/views/screens.dart';
import 'package:healthapp/views/emotion_recorder/emotion_recorder_page.dart';
import 'package:healthapp/views/diet_recorder/diet_recorder_page.dart';
import 'package:healthapp/views/workout_recorder/workout_recorder_page.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();


final goRouter = GoRouter(
  initialLocation: '/emotion',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: LoginPage()
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/emotion',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: EmotionRecorderPage(),
              ),
              //routes:[]
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/diet',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: DietRecorderPage(),
              ),
              routes: [
                GoRoute(
                  path: 'edit/:uuid',
                  pageBuilder: (context, state) {
                    final String uuid = state.pathParameters['uuid'].toString();
                    return NoTransitionPage(
                      child: EditDietPage(uuid: uuid),
                    );
                  } 
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/workout',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: WorkoutRecorderPage(),
              ),
              //routes: [],
            ),
          ],
        ),
         StatefulShellBranch(
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/leaderboard',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: LeaderboardPage(),
              ),
              //routes: [],
            ),
          ],
        ),
      ],
    ),
  ],
);
