/* 
 * Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 * team-CGKM
 * CS 298 - Software DevOps; Spring 2019
 * 
 * File: screen_about.dart
 * Version 1
 * 
 * Purpose:
 *  This screen contains basic information about the application, as well as 
 *  listing the developers that assisted in its development.
 * 
*/

import 'package:flutter/material.dart';
import 'main.dart';


class AboutScreen extends StatefulWidget {
  AboutScreen({Key key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {

  void _toPreviousScreen() {
    //Navigator.pop(context);
    Navigator.pushNamed(context, '/loading');
  }

  void _toSettingScreen() {
    Navigator.pushNamed(context, '/settings');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget> [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Image.asset(
              'assets/images/ArcPlannerLogo.PNG',
            ),
          ),
          Container(
            child: Text(
              'ArcPlanner is an application that helps organize a busy life. It is a planner that will allow users to quickly add and track tasks. These tasks are organized into Arcs, which are long-term or over-reaching tasks such as large projects, classes, or life goals. Where this application differs from other planner apps is in its simplicity to add tasks. Other apps require the user to address multiple input fields such as time, date, location, other people, etc. ArcPlanner allows the user to input tasks all in the same field and then extracts the important information from the string, creates a task in the correct Arc, and adds it to the list of active tasks. In the input string, a user can have the desired Arc, event title, time, and location. The app will be able to extract these entities regardless of their orientation in the string, thus allowing the user to input tasks in the way that seems most natural to them.\n\nArcPlanner developed by team-CGKM\nMembers:\nMatthew Chastain\nJustin Grabowski\nKevin Kelly\nJonathan Middleton\n\nThis application developed as a part of CS 298; Software DevOps course at WCSU in Spring 2019.',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
        
     // floatingActionButton: FloatingActionButton(
       // foregroundColor: Colors.blue,
       // onPressed: _toPreviousScreen,
      //),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    
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
      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );

   
  }
}