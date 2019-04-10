/* 
 * Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 * team-CGKM
 * CS 298 - Software Devops; Spring 2019
 * 
 * File: loading_screen.dart
*/

import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  Widget build(context) {
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