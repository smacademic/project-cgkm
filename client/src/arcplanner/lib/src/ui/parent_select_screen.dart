/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Matthew Chastain, Kevin Kelly
 *    Contributors: Justin Grabowski
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file contains widgets to create the parent arc selection screen 
 */

import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import 'drawer_menu.dart';
import '../model/arc.dart';
import '../model/task.dart';
import 'parent_arc_tile.dart';
import 'task_tile.dart';

class ParentSelectScreen extends StatelessWidget {
  static String currentParent = "Home";
  static bool atNoArcTaskScreen = false;

  Widget build(context) {
    bool firstTimeLoading = true;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text(
          'Select Parent Arc',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),

      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: bloc.arcParentSelectViewStream,
              builder: (context, snapshot) {
                return new FutureBuilder(
                  future: snapshot.data,
                  builder: (context, snapshot) {
                    if (firstTimeLoading) {
                      bloc.parentSelectInsert({ 'object' : null, 'flag': 'getChildArcs'});
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
              },
            ),
          ),
        ],
      ),

      drawer: drawerMenu(context),

      bottomNavigationBar: BottomAppBar(
        color: Colors.blue[400],
        child: Row(
          children: <Widget>[
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
               if (currentParent == null && !atNoArcTaskScreen) {
                   Navigator.of(context).pop();
                } else {
                  if (atNoArcTaskScreen) {
                    bloc.parentSelectInsert({ 'object' : currentParent, 'flag': 'getChildArcs'});
                    atNoArcTaskScreen = false;
                  } 
                  else
                    bloc.parentSelectInsert({ 'object' : currentParent, 'flag': 'backButton'});
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget tile(dynamic obj, BuildContext context) {
  if (obj is Arc) {
    return parentArcTile(obj, context);
  } else if (obj is Task) {
    return taskTile(obj, context);
  } else {
    return Text('tile tried to build not an Arc or Task');
  }
}

