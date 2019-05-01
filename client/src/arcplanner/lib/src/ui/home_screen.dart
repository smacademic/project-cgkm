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
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  void _newTask() {}

  Widget build(context) {
    bool firstTimeLoading = true;
    

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Upcoming Tasks'
              ),
              Tab(
                text: 'Past Due Tasks'
              ),
            ],
          ),
          title: Text("Today is " 
            + DateFormat.MEd().format(DateTime.now()),
          ),
          centerTitle: true,
          actions: <Widget> [
            Container(
              child: ButtonTheme(
                child: FlatButton.icon(
                  textColor: Colors.white,
                  icon: Icon(
                    Icons.add,
                  ),
                  label: Text(
                    'New\nTask',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  onPressed: _newTask,
                ),
              ),
            ),
          ],
        ),

        body: SafeArea(
          child: Column(
            children: <Widget>[
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
      ),
    );
  }
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