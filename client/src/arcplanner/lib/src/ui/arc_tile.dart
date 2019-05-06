/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Matthew Chastain
 *    Contributors: Kevin Kelly, Jonathan Middleton
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
        return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  editArc(arc),
                  completeArc(arc),
                  deleteArc(arc),
                ],
              ),
            );
          },
        );
      },
    ),
  );
}

Widget editArc(Arc arc) {
  return StreamBuilder(
    stream: bloc.arcTitleFieldStream,
    builder: (context, snapshot) {
      return FlatButton(
        textColor: Colors.blue,
        child: Text('Edit', style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () {
          bloc.editArc(arc);
          // edit screen?
          Navigator.of(context).pop();
        },
      );
    },
  );
}

Widget completeArc(Arc arc) {
  return StreamBuilder(
    stream: bloc.arcTitleFieldStream,
    builder: (context, snapshot) {
      return FlatButton(
        textColor: Colors.blue,
        child:
            Text('Complete Arc', style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () {
          bloc.completeArc(arc);
          //mark complete
          Navigator.of(context).pop();
        },
      );
    },
  );
}

Widget deleteArc(Arc arc) {
  return StreamBuilder(
    stream: bloc.arcTitleFieldStream,
    builder: (context, snapshot) {
      return FlatButton(
        textColor: Colors.blue,
        child: Text('Delete', style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () {
          if (arc.childrenUUIDs == null) {
            bloc.deleteArc(arc);
            // TODO update current screen (arcview or home)
          } else {
            return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      content: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                        Text("Cannot delete Arc with existing tasks or arcs."),
                        FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            })
                      ]));
                });
          }
          Navigator.of(context).pop();
        },
      );
    },
  );
}
