/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: 
 *    Contributors: 
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file contains...
 */

import 'package:flutter/material.dart';
import 'ui/login_screen.dart';
import 'ui/loading_screen.dart';
import 'ui/about_screen.dart';
import 'ui/home_screen.dart';
import 'ui/settings_screen.dart';
import 'ui/arc_view_screen.dart';
import 'ui/add_arc_screen.dart';

/// Observer for tracking page changes
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class ArcPlanner extends StatelessWidget {
  static LoginScreen loginScreen = LoginScreen();
  static LoadingScreen loadingScreen = LoadingScreen();
  static AboutScreen aboutScreen = AboutScreen();
  static HomeScreen homeScreen = HomeScreen();
  static SettingsScreen settingsScreen = SettingsScreen();
  static ArcViewScreen arcViewScreen = ArcViewScreen();
  static AddArcScreen addArcScreen = AddArcScreen();

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ArcPlanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: homeScreen,  //setting home as 'homeScreen' for app development
      // Sets up the routes the Navigator can go through
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) => loginScreen,
        '/loading': (BuildContext context) => loadingScreen,
        '/about': (BuildContext context) => aboutScreen,
        '/home': (BuildContext context) => homeScreen,
        '/settings': (BuildContext context) => settingsScreen,
        '/arcview': (BuildContext context) => arcViewScreen,
        '/addarc': (BuildContext context) => addArcScreen,
      },
      navigatorObservers: [routeObserver],
    );
  }
}