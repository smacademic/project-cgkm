/* 
 * Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 * team-CGKM
 * CS 298 - Software Devops; Spring 2019
 * 
 * File: home_screen.dart
*/

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:arcplanner/ui/drawer_menu.dart';
//import 'package:arcplanner/main.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({Key key, this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _HomeScreenState();

  // For visual demonstration purposes only. Will be removed before release
  //=======================================================================
  String userName = 'UserName';
  var upcomingTasks = 5;
  //=======================================================================

  void _newTask() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              color: Colors.blue,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [
                        AutoSizeText(
                          'Hello $userName',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                        ),
                        AutoSizeText(
                          'You have $upcomingTasks upcoming tasks due in the next week',
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                          ),
                          maxLines: 6,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FloatingActionButton.extended(
                          label: Text(
                            'New\nTask',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: Icon(
                            Icons.add,
                            size: 50,
                          ),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,
                          onPressed: _newTask,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          //This will be where the tasks are displayed
          /*
          ListView.builder(

          ),
          */
        ]
      ),

      drawer: drawerMenu(context),
    );
  }
}
