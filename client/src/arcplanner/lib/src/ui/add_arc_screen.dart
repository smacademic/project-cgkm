import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import '../model/arc.dart';
import 'drawer_menu.dart';
import 'package:auto_size_text/auto_size_text.dart';


class AddArcScreen extends StatelessWidget {
  

  Widget build(context) {

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children:[
            Container(margin: EdgeInsets.only(top: 20)),
            titleField(), //name
            //endDate(),
            descriptionField(),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[ 
                  parentField(),
                  Flexible(
                    child: Container(
                      width:MediaQuery.of(context).size.width * 0.4 , 
                      child: arcList(),
                    ),
                  ),   
                ]
              ),
            ),
            //parentField(),
            //arcList(),
          ],
        ),
      ),

      drawer: drawerMenu(context),

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
    stream: bloc.arcEndDateFieldStream,
    builder: (context, snapshot) {
      //Location
      //Name
      //End date
      //Description
      return TextField(
        onChanged: bloc.changeEndDate,
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
    stream: bloc.arcDescriptionFieldStream,
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

 Widget parentField(){
  return StreamBuilder(
      stream: bloc.arcParentFieldStream,
      builder: (context, snapshot) {
        return Text(snapshot.hasData? snapshot.data.title : "Parent");
      }
    );
 }

Widget arcList() {
  
String _arcTitle;

  return StreamBuilder(
    stream: bloc.arcViewStream,
    builder: (context, snapshot) {
      return new FutureBuilder(
        future: snapshot.data,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
          dynamic snapshotData = snapshot.data;
          return DropdownButton<dynamic>(
            hint: Text("Select Parent Arc"),
            value: _arcTitle,
            onChanged: (value) {
              bloc.changeParent(value);
              print("$value");
            },
            isExpanded: true,
            items: List<DropdownMenuItem<dynamic>>.generate(
            snapshotData.length,
              (int index) => DropdownMenuItem<dynamic>(
                value: snapshotData[index],
                child: Text(snapshotData[index].title),
              ),
            ),
          );
           } else {
            return Text('There are no Arcs/Tasks');
          }   
        },
      );
    },
  );
}

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
    child: ListTile(
      title: Text(arc.title),
    ),
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
