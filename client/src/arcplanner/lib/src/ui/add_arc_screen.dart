/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Justin Grabowski
 *    Contributors:
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file contains widgets that allow the user to enter the information
 *  for a new arc, and then create the arc
 */

import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import 'drawer_menu.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class AddArcScreen extends StatelessWidget {
  
  Widget build(context) {

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {Navigator.pop(context);},
          )
        ],
      ),
      
      body: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: ListView(
          children:[
            Container(margin: EdgeInsets.only(top: 15)),
            titleField(),
            dueDate(),
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

      drawer: drawerMenu(context),

      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            submitArc(),
          ],
        ),
      ),
    );
  }
}

 Widget titleField(){
  return StreamBuilder(
    stream: bloc.arcTitleFieldStream,
    builder: (context, snapshot) {
      return TextField(
        onChanged: bloc.changeTitle,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: snapshot.hasData? snapshot.data: 'Title',
          errorText: snapshot.error,
        ),
      );
    }
  );
}

Widget dueDate(){
  return StreamBuilder(
    stream: bloc.arcEndDateFieldStream,
    builder: (context, snapshot) {
      return DateTimePickerFormField(
        inputType: InputType.date,
        format: DateFormat.yMEd(),
        editable: false,
        decoration: InputDecoration(
          labelText: 'Due Date',
        ),
        onChanged: (date) => bloc.changeEndDate(date.toString()),
      );
    }
  );
}

Widget descriptionField(){
  return StreamBuilder(
    stream: bloc.arcDescriptionFieldStream,
    builder: (context, snapshot) {
      return TextField(
        maxLines: 7,
        onChanged: bloc.changeDescription,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: snapshot.hasData? snapshot.data:'Description',
          errorText: snapshot.error,
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
          snapshot.hasData? snapshot.data.title : "Parent",
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
      Navigator.popAndPushNamed(context, '/parent');   },
  );
}

Widget submitArc() {
  return StreamBuilder(
    stream: bloc.arcTitleFieldStream, 
    builder: (context, snapshot) {
      return RaisedButton(
        child: Text('Submit'),
        color: Colors.white,
        textColor: Colors.blue,
        onPressed: snapshot.hasData ? () { 
          bloc.submitArc(); //Currently just returns to previous screen
          Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
          //bloc.changeTitle(null);
          }
        : null
      );
    },
  );
}
