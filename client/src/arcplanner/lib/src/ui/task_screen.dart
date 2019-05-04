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
import '../model/task.dart';
import 'package:intl/intl.dart';

class TaskScreen extends StatelessWidget {
  
  Widget build(context) {

    return Scaffold(
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
        child: StreamBuilder(
          stream: bloc.taskStream,
          builder: (context, snapshot) {
            return  ListView(
              children:[
                Container(margin: EdgeInsets.only(top: 15)),
                titleField(snapshot.data, context),
                Divider(color: Colors.grey,),
                dueDate(snapshot.data, context),
                Divider(color: Colors.grey,),
                locationField(snapshot.data, context),
                Divider(color: Colors.grey,),
                descriptionField(snapshot.data, context),
                Divider(color: Colors.grey,),
              ],
            );
          }
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
    );
  }
}

 Widget titleField(Task task, BuildContext context){
     return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[ 
          Text('Title'),
          Padding(padding: EdgeInsets.only(bottom: 5)),
          Text(
            task.title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
          ),
        ),
      ],
    ),  
  ); 
}

Widget dueDate(Task task, BuildContext context){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Due Date'),
          Padding(padding: EdgeInsets.only(bottom: 5)),
          Text(
            task.title != null ? DateFormat.yMEd().format(DateTime.parse(task.dueDate)): 'No due date',
            style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    ),  
  ); 
}

Widget descriptionField(Task task, BuildContext context){
  return Container(
    height: MediaQuery.of(context).size.height * 0.30,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Description'),
        Padding(padding: EdgeInsets.only(bottom: 5)),
        Text(
          task.description != null ? task.description: 'No description',
          style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          ),
        ),
      ],
    ),  
  );
}

 Widget parentField(Task task){
  return Text(
    task.aid != null ? task.aid: 'No parent',
    style: TextStyle(
      fontSize: 16,
      color: Colors.black
    ),
  );
 }

 Widget locationField(Task task, BuildContext context){
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Location'),
        Padding(padding: EdgeInsets.only(bottom: 5)),
        Text(
          task.location != null ? task.location: 'No location',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    ),  
  );
}

