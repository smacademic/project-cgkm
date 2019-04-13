import 'package:flutter/material.dart';
import '../blocs/bloc.dart';


class AddArcScreen extends StatelessWidget {

  Widget build(context) {

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children:[
            locationField(),
            titleField(), //name
            endDate(),
            descriptionField(),
            Container(margin: EdgeInsets.only(top: 25)),
            submitArc(),
          ],
        ),
      ),
    );
  }
}

 Widget locationField(){
  return StreamBuilder(
      stream: bloc.arcTitleFieldStream,
      builder: (context, snapshot) {
        //Location
        //Name
        //End date
        //Description
        return TextField(
          onChanged: bloc.changeTitle,
          decoration: InputDecoration(
            hintText: 'Location'
            //errorText: snapshot.error,
          ),
        );
      }
    );
 }

 Widget titleField(){
  return StreamBuilder(
    stream: bloc.arcTitleFieldStream,
    builder: (context, snapshot) {
      //Location
      //Name
      //End date
      //Description
      return TextField(
        onChanged: bloc.changeTitle,
        decoration: InputDecoration(
          hintText: 'Title'
          //errorText: snapshot.error,
        ),
      );
    }
  );
}

Widget endDate(){
  return StreamBuilder(
    stream: bloc.arcTitleFieldStream,
    builder: (context, snapshot) {
      //Location
      //Name
      //End date
      //Description
      return TextField(
        onChanged: bloc.changeTitle,
        decoration: InputDecoration(
          hintText: 'EndDate'
          //errorText: snapshot.error,
        ),
      );
    }
  );
}

Widget descriptionField(){
  return StreamBuilder(
    stream: bloc.arcTitleFieldStream,
    builder: (context, snapshot) {
      //Location
      //Name
      //End date
      //Description
      return TextField(
        maxLines: 7,
        onChanged: bloc.changeTitle,
        decoration: InputDecoration(
          hintText: 'Description'
          //errorText: snapshot.error,
        ),
      );
    }
  );
}

Widget submitArc() {
  return StreamBuilder(
    stream: bloc.submitValidArc, 
    builder: (context, snapshot){
      return RaisedButton(
        child: Text('Submit'),
        color: Colors.blue,
        onPressed: () {
            snapshot.hasData ? bloc.submitArc() : null;
            Navigator.pop(context);
          }
        );
      },
  );
}
