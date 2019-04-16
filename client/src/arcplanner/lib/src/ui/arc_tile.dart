import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import '../model/arc.dart';
import 'package:auto_size_text/auto_size_text.dart';

Widget arcTile(Arc arc, BuildContext context) {
  var description = arc.description;
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
                Column(
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
                Container(
                  child: AutoSizeText(
                    'dueDate',
                    //arc.dueDate,
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
        ],
      ),
      onTap: () {
        bloc.arcViewInsert({ 'object' : arc, 'flag': 'getChildren'});
      } 
      //onLongPress: ,
    ),
  );
}
