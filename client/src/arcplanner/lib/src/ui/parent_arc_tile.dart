/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Matthew Chastain
 *    Contributors: Kevin Kelly, Justin Grabowski
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file contains the visual definition of the Parent Arc tiles found in multiple 
 *  screens within ArcPlanner.
 */

import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import '../model/arc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'arc_view_screen.dart';
import 'package:intl/intl.dart';
import 'add_arc_screen.dart';


Widget parentArcTile(Arc arc, BuildContext context) {
  
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
            padding: EdgeInsets.only(
              //top: 10.0,
              bottom: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Arc',
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
                    (arc.dueDate == 'null') ? 'No Due Date' 
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
              bottom: 10.0,
            ),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AutoSizeText(description,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                  maxFontSize: 14.0,
                  minFontSize: 10.0,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                RaisedButton (
                  child: Text('Select'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    bloc.changeLocation(arc.aid);
                    bloc.changeParent(arc);
                    Navigator.pushNamedAndRemoveUntil(context, '/addarc', (Route<dynamic> route) => false);   
                    //TODO add call to new select_arc_screen
                    },
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        //If going to a screen that shows no children then set flag to true
        if (arc.childrenUUIDs?.isEmpty ?? true) {
          ArcViewScreen.atNoArcTaskScreen = true;
          bloc.arcViewInsert({ 'object' : null, 'flag': 'clear'});
        } else {
          bloc.arcViewInsert({ 'object' : arc.aid, 'flag': 'getChildren'});
        }
      } 
      //onLongPress: ,
    ),
  );
}
