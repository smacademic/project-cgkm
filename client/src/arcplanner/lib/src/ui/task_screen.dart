/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Justin Grabowski, Jonathan Middleton
 *    Contributors: Kevin Kelly
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file contains widgets that allow the user to view a task
 */

import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import 'parent_select_screen.dart';
import '../model/task.dart';

class TaskScreen extends StatelessWidget {
  
  Widget build(context) {

    return WillPopScope(
    onWillPop: () async => false,
      child :Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
             //TODO add call to go back
            },
          )
        ),
        
        body: Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: ListView(
            children:[
              Container(margin: EdgeInsets.only(top: 15)),
              titleField(),
              dueDate(),
              locationField(),
              descriptionField(),
              parentField(),
            ],
          ),
        ),

        bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
            ],
          ),
        ),
      )
    );
  }
}

 Widget titleField(){
  return StreamBuilder(
    stream: bloc.taskTitleFieldStream,
    builder: (context, snapshot) {
      return Text(
        snapshot.data,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      );
    }
  );
}

Widget dueDate(){
  return StreamBuilder(
    stream: bloc.taskEndDateFieldStream,
    builder: (context, snapshot) {

      return Text(
        snapshot.hasData ? snapshot.data: 'No due date',
        style: TextStyle(
        fontSize: 16,
        color: Colors.black,
        ),
      );
    }
  );
}

Widget descriptionField(){
  return StreamBuilder(
    stream: bloc.taskDescriptionFieldStream,
    builder: (context, snapshot) {
      return Text(
        snapshot.hasData ? snapshot.data: 'No due description',
        style: TextStyle(
        fontSize: 16,
        color: Colors.black,
        ),
      );
    }
  );
}

 Widget parentField(){
  return StreamBuilder(
    stream: bloc.arcParentFieldStream,
    builder: (context, snapshot) {
      return Text(
        snapshot.hasData? snapshot.data.title : "No Parent",
        style: TextStyle(
          fontSize: 16,
          color: Colors.black
        ),
      );
    }
  );
 }

 Widget locationField(){
  return StreamBuilder(
    stream: bloc.taskLocationFieldStream,
    builder: (context, snapshot) {
      return Text(
        snapshot.hasData ? snapshot.data: 'No location',
        style: TextStyle(
        fontSize: 16,
        color: Colors.black,
        ),
      );
    }
  );
}
