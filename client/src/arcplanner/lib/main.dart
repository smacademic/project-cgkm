import 'package:flutter/material.dart';
import 'package:arcplanner/ui/login_screen.dart';
import 'package:arcplanner/ui/loading_screen.dart';
import 'package:arcplanner/ui/about_screen.dart';
import 'package:arcplanner/ui/home_screen.dart';
import 'package:arcplanner/ui/settings_screen.dart';


/// Observer for tracking page changes
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();


void main() {
  runApp(ArcPlanner());
}

class ArcPlanner extends StatelessWidget {
  static LoginScreen loginScreen = LoginScreen();
  static LoadingScreen loadingScreen = LoadingScreen();
  static AboutScreen aboutScreen = AboutScreen();
  static HomeScreen homeScreen = HomeScreen();
  static SettingsScreen settingsScreen = SettingsScreen();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ArcPlanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loginScreen,  //setting home as 'homeScreen' for app development
      // Sets up the routes the Navigator can go through
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) => loginScreen,
        '/loading': (BuildContext context) => loadingScreen,
        '/about': (BuildContext context) => aboutScreen,
        '/home': (BuildContext context) => homeScreen,
        '/settings': (BuildContext context) => settingsScreen,
      },
      navigatorObservers: [routeObserver],
    );
  }
}