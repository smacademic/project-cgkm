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
import 'parent_select_screen.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/cupertino.dart';

class AddArcScreen extends StatelessWidget {
  
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
              bloc.initializeAddArcStreams();
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
              submitArc(),
            ],
          ),
        ),
      )
    );
  }
}

 Widget titleField(){
  return StreamBuilder(
    stream: bloc.arcTitleFieldStream,
    builder: (context, snapshot) {
      return TextField(
        onChanged: bloc.changeArcTitle,
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
    stream: bloc.arcEndDateFieldStream,
    builder: (context, snapshot) {

      return new DateTimePickerFormField(
        inputType: InputType.date,
        format: DateFormat.yMEd(),
        editable: false,
        dateOnly: true,
        decoration: InputDecoration(
          hintText: 'Due Date',
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.black
          ),
        ),
        onChanged: (date) => bloc.changeArcEndDate(date.toString()),
      );
    }
  );
}

Widget timeDue(){
  return StreamBuilder(
    stream: bloc.arcTimeDueFieldStream,
    builder: (context, snapshot) {
      // return Container(
      //   width: MediaQuery.of(context).size.width,
      //   //width: double.infinity,
      //   child: SizedBox( 
      //     width: double.infinity,
      //     child: FlatButton(
      //       padding: EdgeInsets.all(0),
      //       onPressed: () {
      //         showCupertinoModalPopup(
      //           context: context,
      //           builder: (BuildContext builder) {
      //             return CupertinoActionSheet(
      //               cancelButton: CupertinoActionSheetAction(
      //                 child: Text('Cancel'),
      //                 isDefaultAction: true,
      //                 onPressed: () {
      //                   Navigator.pop(context, 'Cancel');
      //                 },
      //               ),
      //               actions: <Widget>[  
      //                 Container(
      //                   height:MediaQuery.of(context).copyWith().size.height /5,
      //                   child: time()
      //                 ),
      //               ],
      //             );
      //           });
              
      //         // DatePicker.showTimePicker(
      //         //   context,
      //         //   locale: LocaleType.en,
      //         //   showTitleActions: true,
      //         //   onConfirm: (time) {
      //         //     bloc.changeArcTimeDue( DateFormat.jm().format(time).toString());
      //         //   }, 
      //         // );
      //         //currentTime: DateTime.now(), locale: LocaleType.en);
      //       },
      //       child: TextField(
      //         decoration: InputDecoration(
      //           hintText: snapshot.hasData ? DateFormat.jm().format(DateTime.parse( snapshot.data )): 'Time Due',
      //           hintStyle: TextStyle(
      //             fontSize: 16,
      //             color: Colors.black
      //           ),
      //           enabled: false,
      //           disabledBorder: UnderlineInputBorder(
      //             borderSide: new BorderSide(
      //               color: Colors.grey[700],
      //             ),
      //           ),      
      //         ),
      //       ),
      //     ),
      //   ),
      // );

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
        onChanged: (time) => bloc.changeArcTimeDue(time.toString()),
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
        onChanged: bloc.changeArcDescription,
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
        snapshot.hasData? snapshot.data.title : "Parent",
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

Widget submitArc() {
  return StreamBuilder(
    stream: bloc.arcTitleFieldStream, 
    builder: (context, snapshot) {
      return FlatButton.icon(
        disabledTextColor: Colors.grey,
        icon: Icon(Icons.library_add, color: Colors.white,),
        label: Text ('Submit'),
        textColor: Colors.white,
        onPressed: snapshot.hasData ? () { 
          bloc.submitArc(); 
          Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
          }
        : null
      );
    },
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

Widget time() {
  return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.time,
      minuteInterval: 5,
      initialDateTime: DateTime.parse("1969-07-20 12:00:00"), 
    onDateTimeChanged: (time) {
      bloc.changeArcTimeDue(time.toString());
    }, 
  );
}