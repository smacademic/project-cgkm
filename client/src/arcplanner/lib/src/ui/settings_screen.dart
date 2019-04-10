/* 
 * Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 * team-CGKM
 * CS 298 - Software Devops; Spring 2019
 * 
 * File: settings_screen.dart
*/

import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
       body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            settingOne(),
            settingTwo(),
            settingThree(),
          ],
        ).toList(),
       ),
    );
  }
}

Widget settingOne() {
  return ListTile(
    title: Text("Setting 1"),
    onTap:() {}
  );
}

Widget settingTwo() {
  return ListTile(
    title: Text("Setting 2"),
    onTap:() {}
  );
}

Widget settingThree() {
  return ListTile(
    title: Text("Setting 3"),
    onTap:() {}
  );
}