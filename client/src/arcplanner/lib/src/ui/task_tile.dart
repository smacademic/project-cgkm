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

Widget taskTile(Task task, BuildContext context) {
  var description = task.description;
  if (description == null) {
    description = 'No Description';
  }

  var dueDate = task.duedate;
  if (dueDate == null) {
    dueDate = '';
  }

  var location = task.location;
  if (location == null) {
    location = '';
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
                    Text('Task',
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
                  'dueDate',
                  //dueDate,
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
              top: 10.0,
              bottom: 10.0,
            ),
            child: AutoSizeText(description,
              style: TextStyle(
                color: Colors.grey[600],
              ),
              maxFontSize: 14.0,
              minFontSize: 10.0,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // onTap: () {
          //   _toTaskView(task),
          // }
          // onLongPress: ,
        ],
      ),
    ),
  );
}
