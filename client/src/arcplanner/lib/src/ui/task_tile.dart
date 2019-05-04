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
 *  This file contains the visual definition of the Task tiles found in
 *  multiple screens within ArcPlanner.
 */

import 'package:flutter/material.dart';
import '../model/task.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

Widget taskTile(Task task, BuildContext context) {
  var description = task.description;
  if (description == null) {
    description = 'No Description';
  }

  var location = task.location;
  if (location == null) {
    location = '';
  }

  Widget getLocation() {
    if (location != '') {
      return Container(
        padding: EdgeInsets.only(
          top: 5.0,
        ),
        child: AutoSizeText(
          'Location: $location',
          style: TextStyle(
            color: Colors.grey[800],
          ),
          maxFontSize: 14.0,
          minFontSize: 10.0,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      return null;
    }
  }

  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.grey[350],
        ),
        top: BorderSide(
          color: Colors.grey[350],
        ),
      ),
    ),
    height: MediaQuery.of(context).size.height * 0.18,
    child: ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Task',
                      style: TextStyle(
                        fontSize: 8.0,
                      ),
                    ),
                    AutoSizeText(
                      task.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      maxFontSize: 24.0,
                      minFontSize: 16.0,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                child: AutoSizeText(
                  (task.dueDate == 'null' || task.dueDate == null) ? '' 
                     : DateFormat.yMEd().format(DateTime.parse(task.dueDate)),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    maxFontSize: 14.0,
                    minFontSize: 14.0,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(
              top: 0.0,
              bottom: 0.0,
            ),
            child: getLocation(),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 5.0,
              bottom: 10.0,
            ),
            child: AutoSizeText(
              description,
              style: TextStyle(
                color: Colors.grey[600],
              ),
              maxFontSize: 14.0,
              minFontSize: 10.0,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      onTap:(){},
      onLongPress:(){
                return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              // title: Text("Make changes to this Arc?"),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FlatButton(  // leaving this commented until edit is implemented
                    
                    textColor: Colors.blue,
              
                    child: Text('Edit', style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    textColor: Colors.blue,
                    child: Text('Mark Complete', style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    textColor: Colors.blue,
                    child: Text('Delete', style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    ),
  );
}

