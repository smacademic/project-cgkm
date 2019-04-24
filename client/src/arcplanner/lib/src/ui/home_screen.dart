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
import '../blocs/bloc.dart';
import 'arc_tile.dart';
import 'task_tile.dart';
import '../model/arc.dart';
import '../model/task.dart';

class HomeScreen extends StatelessWidget {
  void _newTask() {}

  Widget build(context) {
    bool firstTimeLoading = true;
    

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: <Widget>[
            topBar(context),
            Expanded(
              child: StreamBuilder(
                stream: bloc.homeStream,
                builder: (context, snapshot) {
                  return new FutureBuilder(
                    future: snapshot.data,
                    builder: (context, snapshot) {
                      if (firstTimeLoading) {
                        bloc.homeInsert({ 'object' : null, 'flag': 'getUpcomingItems'});
                        firstTimeLoading = false;
                      }
                      
                      if (snapshot.hasData) {
                        dynamic snapshotData = snapshot.data;
                        return ListView.builder(
                          itemCount: snapshotData.length,
                          itemBuilder: (context, index) {
                            return tile(snapshotData[index], context);
                          },
                        );
                      } else {
                        return Text('There are no Arcs/Tasks');
                      }
                    },
                  );
                }
              ),
            ),
          ],
        ),
      ),

      drawer: drawerMenu(context),
    );
  }
}

Widget topBar(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  return Column(
    children: <Widget>[
    Container(
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
                  // TODO: Replace _newTask with a Bloc method
                  //onPressed: _newTask,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget tile(dynamic obj, BuildContext context) {
  if (obj is Arc) {
    return arcTile(obj, context);
  } else if (obj is Task) {
    return taskTile(obj, context);
  } else {
    return Text('tile tried to build not an Arc or Task');
  }
}