/* 
 * Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 * team-CGKM
 * CS 298 - Software Devops; Spring 2019
 * 
 * File: loading_screen.dart
*/

import 'package:flutter/material.dart';
//import 'package:arcplanner/main.dart';

class LoadingScreen extends StatefulWidget {
  final String title;

  LoadingScreen({Key key, this.title}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  _LoadingScreenState();

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
