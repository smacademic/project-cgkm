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
    height: MediaQuery.of(context).size.height * 0.15,
    child: ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                ),
                child: AutoSizeText(
                  task.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  maxFontSize: 24.0,
                  minFontSize: 18.0,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: AutoSizeText(
                  dueDate,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  maxFontSize: 16.0,
                  minFontSize: 12.0,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: 10.0,
            ),
            child: AutoSizeText(description,
              style: TextStyle(
                color: Colors.black,
              ),
              maxFontSize: 16.0,
              minFontSize: 12.0,
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
