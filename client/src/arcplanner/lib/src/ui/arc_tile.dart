/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Matthew Chastain
 *    Contributors: Kevin Kelly
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file contains the visual definition of the Arc tiles found in multiple 
 *  screens within ArcPlanner.
 */

import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import '../model/arc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'arc_view_screen.dart';
import 'package:intl/intl.dart';

Widget arcTile(Arc arc, BuildContext context) {
  var description = arc.description;

  ArcViewScreen.currentParent = arc.parentArc;

  if (description == null) {
    description = '';
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
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Arc',
                        style: TextStyle(
                          fontSize: 8.0,
                        ),
                      ),
                      AutoSizeText(
                        arc.title,
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
                    (arc.dueDate == 'null' || arc.dueDate == null)
                        ? ''
                        : DateFormat.yMEd().format(DateTime.parse(arc.dueDate)),
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
      onTap: () {
        //If going to a screen that shows no children then set flag to true
        if (arc.childrenUUIDs?.isEmpty ?? true) {
          ArcViewScreen.atNoArcTaskScreen = true;
          bloc.arcViewInsert({'object': null, 'flag': 'clear'});
        } else {
          bloc.arcViewInsert({'object': arc.aid, 'flag': 'getChildren'});
        }
      },
      onLongPress: () {
        // Show option to mark complete/delete
            // if delete
                // if has children
                    // "no delete" message
                // else
                    // delete

            // if complete
              // if has incomplete children
                  // "not complete" message
              // if else, and all children complete
                  // complete
            // update for arcView

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
