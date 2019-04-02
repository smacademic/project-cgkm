/* 
 * Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 * team-CGKM
 * CS 298 - Software Devops; Spring 2019
 * 
 * File: screen_Settings.dart
 * Version 1
*/

import 'package:flutter/material.dart';
import 'main.dart';

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

  void _toSettingScreen() {
    Navigator.pushNamed(context, '/settings');
  }

// Create a temporary list to store 'dummy' settings
List<String> settingsList = ["Setting 1", "Setting 2", "Setting 3"];

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemBuilder: (context, position) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              ButtonTheme(
                height: 60,
                buttonColor: Colors.white70,
                child: FlatButton(
                  onPressed: _toPreviousScreen,
                  padding:EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 8,
                      right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                    Container(
                      padding: EdgeInsets.only(left:8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(settingsList[position],
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                              ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15)
                      ),
                    ]
                  ),
                ),
              ),
              Divider(
                    height: 2.0,
                    color: Colors.grey,)
            ],
          );
        },
        itemCount: settingsList.length,
      ),

      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,

        children: <Widget>[
          FloatingActionButton(
            heroTag: 0,
            foregroundColor: Colors.blue,
            onPressed: _toPreviousScreen,
          ),
          FloatingActionButton(
            heroTag: 1,
            child: Icon(Icons.settings, color: Colors.white,),
            foregroundColor: Colors.blue,
            onPressed: _toSettingScreen,
          ),
        ]
      ),
    );
  }
}
