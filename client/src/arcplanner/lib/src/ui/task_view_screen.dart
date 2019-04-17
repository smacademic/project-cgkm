/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Jonathan Middleton
 *    Contributors: 
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file has the UI and associated functionality for the Task View
 */

import 'package:flutter/material.dart';
import 'drawer_menu.dart';

class TaskViewScreen extends StatelessWidget {
  static String currentParent = "Home";

  Widget build(context) {
    return Scaffold(
        body: ListView(
          children: ListTile.divideTiles(context: context, tiles: [
            arcPath(),
            taskName(),
            dateCreated(),
            endDate(),
            location(),
            taskDescription(),
          ]).toList(),
        ),
        drawer: drawerMenu(context),
        bottomNavigationBar: BottomAppBar(
            color: Colors.blue[400],
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Mark'),
                    color: Colors.white,
                    textColor: Colors.blue[400],
                    onPressed: () {
                      // implement here
                      print('Mark tapped');
                    },
                  ),
                  RaisedButton(
                    child: Text('Edit'),
                    color: Colors.white,
                    textColor: Colors.blue[400],
                    onPressed: () {
                      // implement here
                      print('Edit tapped');
                    },
                  ),
                  RaisedButton(
                    child: Text('Delete'),
                    color: Colors.white,
                    textColor: Colors.blue[400],
                    onPressed: () {
                      // implement here
                      print('Delete tapped');
                    },
                  ),
                ])),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue[400],
            child: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }));
  }
}

Widget arcPath() {
  return ListTile(
      title: Text("Arc Path",
          style: TextStyle(
            fontSize: 16,
          )),
      onTap: () {});
}

Widget taskName() {
  return ListTile(
      title: Text("Task Name",
          style: TextStyle(
            fontSize: 20,
          )),
      onTap: () {});
}

Widget dateCreated() {
  return ListTile(
      title: Text("Date Created",
          style: TextStyle(
            fontSize: 20,
          )),
      onTap: () {});
}

Widget endDate() {
  return ListTile(
      title: Text("End Date",
          style: TextStyle(
            fontSize: 20,
          )),
      onTap: () {});
}

Widget location() {
  return ListTile(
      title: Text("Location",
          style: TextStyle(
            fontSize: 20,
          )),
      onTap: () {});
}

Widget taskDescription() {
  return ListTile(
      title: Text("Task Description",
          style: TextStyle(
            fontSize: 16,
          )),
      onTap: () {});
}
