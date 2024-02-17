import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
              //routes: [],
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
      ],
    ),
  ],
);
