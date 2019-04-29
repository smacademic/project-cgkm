/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Matthew Chastain
 *    Contributors: Justin Grabowski, Jonathan Middleton
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file contains the ArcPlanner class, defining the screens present in 
 *  the application as well as setting up the Navigator that allows for screen 
 *  navigation within ArcPlanner.
 */

import 'package:flutter/material.dart';
import 'ui/login_screen.dart';
import 'ui/loading_screen.dart';
import 'ui/about_screen.dart';
import 'ui/home_screen.dart';
import 'ui/settings_screen.dart';
import 'ui/arc_view_screen.dart';
import 'ui/task_view_screen.dart';
import 'ui/add_arc_screen.dart';
import 'ui/add_task_screen.dart';
import 'ui/parent_select_screen.dart';
import 'ui/calendar_screen.dart';

/// Observer for tracking page changes
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class ArcPlanner extends StatelessWidget {
  static LoginScreen loginScreen = LoginScreen();
  static LoadingScreen loadingScreen = LoadingScreen();
  static AboutScreen aboutScreen = AboutScreen();
  static HomeScreen homeScreen = HomeScreen();
  static SettingsScreen settingsScreen = SettingsScreen();
  static ArcViewScreen arcViewScreen = ArcViewScreen();
  static TaskViewScreen taskViewScreen = TaskViewScreen();
  static AddArcScreen addArcScreen = AddArcScreen();
  static AddTaskScreen addTaskScreen = AddTaskScreen();
  static ParentSelectScreen parentSelectScreen = ParentSelectScreen();
  static CalendarScreen calendarScreen = CalendarScreen();



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
        '/taskview': (BuildContext context) => taskViewScreen,
        '/addarc': (BuildContext context) => addArcScreen,
        '/addtask': (BuildContext context) => addTaskScreen,
        '/parent': (BuildContext context) => parentSelectScreen,
        '/calendar': (BuildContext context) => calendarScreen,
      },
      navigatorObservers: [routeObserver],
    );
  }
}