import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import 'drawer_menu.dart';
import '../model/arc.dart';
import '../model/task.dart';
import 'package:auto_size_text/auto_size_text.dart';

Widget taskTile(Task task, BuildContext context) {
  var description = task.description;
  if (description == null) {
    description = '';
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
    height: MediaQuery.of(context).size.height * 0.15,
    child: ListTile(
      title: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                padding: EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                ),
                child: AutoSizeText(task.title,
                  maxFontSize: 20.0,
                  minFontSize: 16.0,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: AutoSizeText(dueDate,
                  maxFontSize: 20.0,
                  minFontSize: 16.0,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                AutoSizeText(location,
                  maxFontSize: 16.0,
                  minFontSize: 8.0,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                AutoSizeText(description,
                  maxFontSize: 14.0,
                  minFontSize: 10.0,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      // onTap: () {
      //   _toTaskView(task),
      // }  
      // onLongPress: ,
    )
  );
}
