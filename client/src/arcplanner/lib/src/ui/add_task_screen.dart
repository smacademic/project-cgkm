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
 *  This file contains widgets that allow the user to enter the information
 *  for a new arc, and then create the arc
 */

import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import 'parent_select_screen.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class AddTaskScreen extends StatelessWidget {
  
  Widget build(context) {

    return WillPopScope(
    onWillPop: () async => false,
      child :Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
              // Empty the stream
              bloc.initializeAddTaskStreams();
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
              timeDue(),
              locationField(),
              descriptionField(),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row( 
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[ 
                    parentField(),
                    Flexible(
                      child: Container(
                        width:MediaQuery.of(context).size.width * 0.25 , 
                        child: selectParent(context),
                      ),
                    ),   
                  ]
                ),
              ),
            ],
          ),
        ),

        bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              submitTask(),
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
      return TextField(
        onChanged: bloc.changeTaskTitle,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Title',
          errorText: snapshot.error,
           hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.black
          ),
        ),
      );
    }
  );
}

Widget dueDate(){
  return StreamBuilder(
    stream: bloc.taskEndDateFieldStream,
    builder: (context, snapshot) {

      return DateTimePickerFormField(
        inputType: InputType.date,
        format: DateFormat.yMEd(),
        editable: false,
        decoration: InputDecoration(
          hintText: 'Due Date',
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.black
          ),
        ),
        onChanged: (date) => bloc.changeTaskEndDate(date.toString()),
      );
    }
  );
}

Widget timeDue(){
  return StreamBuilder(
    stream: bloc.taskTimeDueFieldStream,
    builder: (context, snapshot) {
  
      return new DateTimePickerFormField(
        inputType: InputType.time,
        format: DateFormat.jm(),
        editable: false,
        decoration: InputDecoration(
          hintText: 'Time Due',
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.black
          ),
        ),
        onChanged: (time) => bloc.changeTaskTimeDue(time.toString()),
      );
    }
  );
}

Widget descriptionField(){
  return StreamBuilder(
    stream: bloc.taskDescriptionFieldStream,
    builder: (context, snapshot) {
      return TextField(
        maxLines: 7,
        onChanged: bloc.changeTaskDescription,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: 'Description',
          errorText: snapshot.error,
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.black
          ),
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
        snapshot.hasData? snapshot.data.title : "Parent (required)",
        style: TextStyle(
          fontSize: 16,
          color: Colors.black
        ),
      );
    }
  );
 }

Widget selectParent(BuildContext context){
  return RaisedButton(
    child: Text('Select'),
    color: Colors.blue,
    textColor: Colors.white,
    onPressed: () {
      _openParentSelectDialog(context);
    }
  );
}

Widget submitTask() {
  return StreamBuilder(
    stream: bloc.submitValidTask, 
    builder: (context, snapshot) {
      return FlatButton.icon(
        disabledTextColor: Colors.grey,
        icon: Icon(Icons.library_add, color: Colors.white,),
        label: Text ('Submit'),
        textColor: Colors.white,
        onPressed: snapshot.hasData ? () { 
          bloc.submitTask(); 
          Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
          }
        : null
      );
    },
  );
}

 Widget locationField(){
  return StreamBuilder(
    stream: bloc.taskLocationFieldStream,
    builder: (context, snapshot) {
      return TextField(
        onChanged: bloc.changeTaskLocation,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Location',
          errorText: snapshot.error,
           hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.black
          ),
        ),
      );
    }
  );
}

void _openParentSelectDialog(BuildContext context) {
  Navigator.of(context).push(
    new MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return new ParentSelectScreen();
      },
      fullscreenDialog: true
    )
  );
}
