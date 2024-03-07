import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ScaffoldWithNavigationBar(
        body: navigationShell,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
      );
    });
  }
}

class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.amber,
        selectedIndex: selectedIndex,
        destinations: const [
          NavigationDestination(label: 'Emotion', icon: Icon(Icons.emoji_emotions,)),
          NavigationDestination(label: 'Diet', icon: Icon(Icons.fastfood)),
          NavigationDestination(label: 'Workout', icon: Icon(Icons.fitness_center)),
          NavigationDestination(label: 'leaderboard', icon: Icon(Icons.leaderboard)),
        ],
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}