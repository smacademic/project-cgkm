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
import 'drawer_menu.dart';
import '../blocs/bloc.dart';
import 'package:intl/intl.dart';
import '../helpers/tile.dart';

class HomeScreen extends StatelessWidget {
  void _newTask() {}

  Widget build(context) {
    bool firstTimeLoading = true;
    
    return Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
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
                      fontSize: 12.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/addtask');
                  },
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

                          print(snapshotData);

                          if (snapshotData.toString() != '[]') {
                            return ListView.builder(
                              itemCount: snapshotData.length,
                              itemBuilder: (context, index) {
                                return tile(snapshotData[index], context);
                              },
                            );
                          } else {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'There are no Upcoming Items',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              )
                            );
                          }
                        } else {
                          return Text('');
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
