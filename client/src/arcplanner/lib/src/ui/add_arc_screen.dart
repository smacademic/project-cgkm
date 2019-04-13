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
            descriptionField()
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
        maxLines: 10,
        onChanged: bloc.changeTitle,
        decoration: InputDecoration(
          hintText: 'Description'
          //errorText: snapshot.error,
        ),
      );
    }
  );
}


