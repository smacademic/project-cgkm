/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Matthew Chastain
 *    Contributors: 
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file contains ArcPlanner's home screen which will be displayed on 
 *  launch. The screen shows users a list of upcoming tasks along with a Task 
 *  quick-add button.
 */

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'drawer_menu.dart';

class HomeScreen extends StatelessWidget {
  // For visual demonstration purposes only. Will be removed before release
  //=======================================================================
  //String userName = 'UserName';
  //var upcomingTasks = 5;
  //=======================================================================
  void _newTask() {}

  Widget build(context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              color: Colors.blue[400],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8),
                    width: width * 0.60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [
                        AutoSizeText(
                          'Hello userName',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                        ),
                        AutoSizeText(
                          'You have X upcoming tasks due in the next week',
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                          ),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      right: 10.0,
                    ),
                    child: ButtonTheme(
                      height: 55.0,
                      buttonColor: Colors.white,
                      child: RaisedButton.icon(
                        textColor: Colors.blue[400],
                        icon: Icon(
                          Icons.add,
                          size: 45.0,
                        ),
                        label: Text(
                          'New\nTask',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        onPressed: _newTask,
                      ),
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