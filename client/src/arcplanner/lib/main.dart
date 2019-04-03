import 'package:flutter/material.dart';
import 'screen_login.dart';
import 'screen_loading.dart';
import 'screen_about.dart';
import 'screen_settings.dart';

/// Observer for tracking page changes
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();


void main() {
  runApp(ArcPlanner());
}

class ArcPlanner extends StatelessWidget {
  static LoginScreen loginScreen  = LoginScreen();
  static LoadingScreen loadingScreen = LoadingScreen();
  static AboutScreen aboutScreen  = AboutScreen();
  static SettingsScreen settingsScreen = SettingsScreen();

  /// Resets the application to a default state. This allows log out and log back in without reset
  static void resetConnection() async {
    loginScreen = LoginScreen();
    loadingScreen = LoadingScreen();
    aboutScreen = AboutScreen();
    settingsScreen = SettingsScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ArcPlanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loginScreen,
      // Sets up the routes the Navigator can go through
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) => loginScreen,
        '/loading': (BuildContext context) => loadingScreen,
        '/about': (BuildContext context) => aboutScreen,
        '/settings': (BuildContext context) => settingsScreen,
      },
      navigatorObservers: [routeObserver],
    );
  }
}