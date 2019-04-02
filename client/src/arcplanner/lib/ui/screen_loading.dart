/* 
 * Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 * team-CGKM
 * CS 298 - Software Devops; Spring 2019
 * 
 * File: screen_loading.dart
 * Version 1
*/

import 'package:flutter/material.dart';
import 'main.dart';

class LoadingScreen extends StatefulWidget {
  final String title;

  LoadingScreen({Key key, this.title}) : super(key: key) {}

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  _LoadingScreenState() {}

  /*
   * FUNCTION IS TEMPORARY AND FOR APP NAVIGATION ONLY
  */
  void _() async {
    try {
      Navigator.pushReplacementNamed(context, '/about');
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/ArcPlannerLogo.PNG',
            width: (MediaQuery.of(context).size.width),
            fit: BoxFit.cover,
          ),
        ]
      ),
    );
  }
}
