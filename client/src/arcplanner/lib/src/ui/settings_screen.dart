/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Justin Grabowski
 *    Contributors: 
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file contains the visual definition of the Settings screen.
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