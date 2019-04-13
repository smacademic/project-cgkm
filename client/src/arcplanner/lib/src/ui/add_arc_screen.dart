import 'package:flutter/material.dart';
import '../blocs/bloc.dart';


class AddArcScreen extends StatelessWidget {

  Widget build(context) {

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children:[
            Container(margin: EdgeInsets.only(top: 20)),
            locationField(),
            titleField(), //name
            //endDate(),
            descriptionField(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('Cancel'),
              color: Colors.white,
              textColor: Colors.blue,
              // Needs to open New Task dialog
              onPressed: () {Navigator.pop(context);},
            ),
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
          keyboardType: TextInputType.datetime,
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
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Title',
          errorText: snapshot.error,
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
        onChanged: bloc.changeDescription,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: 'Description',
          errorText: snapshot.error,
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
        color: Colors.white,
        textColor: Colors.blue,
        onPressed: snapshot.hasData ? (){ 
          bloc.submitArc;
          Navigator.pop(context);
          }
        :  null //(){print(snapshot.data);
        //}
        /*(){
          if(snapshot.hasData) {
             bloc.submitArc();
            Navigator.pop(context);
          } else {null;}
          
        },
        */
      );
    },
  );
}
