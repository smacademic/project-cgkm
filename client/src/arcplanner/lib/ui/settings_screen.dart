/* 
 * Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 * team-CGKM
 * CS 298 - Software Devops; Spring 2019
 * 
 * File: settings_screen.dart
*/

import 'package:flutter/material.dart';
//import 'package:arcplanner/main.dart';

class SettingsScreen extends StatefulWidget {
  final String title;

  SettingsScreen({Key key, this.title}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  void _toPreviousScreen() {
    //Navigator.pop(context);
    Navigator.pushNamed(context, '/about');
  }

   @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              title: Text("Setting 1"),
                    onTap:() {
                      _toPreviousScreen();
                    }
            ),
             ListTile(
              title: Text("Setting 2"),
                    onTap:() {
                      _toPreviousScreen();
                    }
            ),
             ListTile(
              title: Text("Setting 3"),
                    onTap:() {
                      _toPreviousScreen();
                    }
            ),
          ],
        ).toList(),
       ),
    );
  }
}
