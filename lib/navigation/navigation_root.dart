import 'package:flutter/material.dart';
import 'package:jp_reading/ui/main_screen/main_screen.dart';
import 'package:jp_reading/ui/test_screen/test_screen.dart';
import 'package:jp_reading/ui/results_screen/results_screen.dart';

class NavigationRoot extends StatefulWidget {
  const NavigationRoot({super.key});

  /// Public global key with a public type parameter.
  /// Do NOT expose the private `_NavigationRootState` type here.
  static final GlobalKey<State<StatefulWidget>> navKey =
  GlobalKey<State<StatefulWidget>>();

  /// Public method to navigate by logical route name.
  static void navTo(String routeName) {
    final context = navKey.currentContext;
    if (context == null) {
      debugPrint('NavigationRoot: no active context found.');
      return;
    }

    // Find the actual state object inside this context
    final rootState = context.findAncestorStateOfType<_NavigationRootState>();
    if (rootState == null) {
      debugPrint('NavigationRoot: no internal state found.');
      return;
    }

    rootState._navigateTo(routeName);
  }

  @override
  State<NavigationRoot> createState() => _NavigationRootState();
}

class _NavigationRootState extends State<NavigationRoot> {
  late Widget _currentScreen;

  @override
  void initState() {
    super.initState();
    _currentScreen = const MainScreen(); // MainScreen opens first
  }

  void _navigateTo(String routeName) {
    setState(() {
      switch (routeName) {
        case 'main':
          _currentScreen = const MainScreen();
          break;
        case 'test':
          _currentScreen = const TestScreen();
          break;
        case 'results':
          _currentScreen = const ResultsScreen();
          break;

        default:
          _currentScreen = const MainScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Attach the global key here
    return Scaffold(
      key: NavigationRoot.navKey,
      body: _currentScreen,
    );
  }
}
