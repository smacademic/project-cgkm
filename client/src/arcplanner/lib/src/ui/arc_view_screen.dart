import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import 'drawer_menu.dart';
import '../model/arc.dart';
import '../model/task.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ArcViewScreen extends StatelessWidget {

  _toTaskView(Task task) {
  }

  Widget build(context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: bloc.arcViewStream,
              builder: (context, snapshot) {
                return new FutureBuilder(
                  future: snapshot.data,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                    dynamic snapshotData = snapshot.data;
                    return ListView.builder(
                      itemCount: snapshotData.length,
                      itemBuilder: (context, index) {
                        return tile(snapshotData[index], context);
                      },
                    );
                    } else {
                      return Text('There are no Arcs/Tasks');
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),

      drawer: drawerMenu(context),

      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('New Task'),
              color: Colors.white,
              textColor: Colors.blue,
              // Needs to open New Task dialog
              onPressed: () {},
            ),
            RaisedButton(
              child: Text('New Arc'),
              color: Colors.white,
              textColor: Colors.blue,
              // Needs to open New Arc dialog
              onPressed: () {
               // Navigator.popAndPushNamed(context, '/addarc'); 
              },
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
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
    height: MediaQuery.of(context).size.height * 0.20,
    child: ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            child: AutoSizeText(arc.title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              maxFontSize: 24.0,
              minFontSize: 18.0,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: 10.0,
            ),
            child: AutoSizeText(description,
              style: TextStyle(
                color: Colors.black,
              ),
              maxFontSize: 16.0,
              minFontSize: 12.0,
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

Widget taskTile(Task task, BuildContext context) {
  var description = task.description;
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
    height: MediaQuery.of(context).size.height * 0.15,
    child: ListTile(
      title: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                padding: EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                ),
                child: AutoSizeText(task.title,
                  maxFontSize: 20.0,
                  minFontSize: 16.0,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: AutoSizeText(task.duedate,
                  maxFontSize: 20.0,
                  minFontSize: 16.0,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                AutoSizeText(task.location,
                  maxFontSize: 16.0,
                  minFontSize: 8.0,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                AutoSizeText(task.description,
                  maxFontSize: 14.0,
                  minFontSize: 10.0,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      // onTap: () {
      //   _toTaskView(task),
      // }  
      // onLongPress: ,
    )
  );
}

Widget tile(dynamic obj, BuildContext context) {
  if (obj is Arc) {
    return arcTile(obj, context);
  } else if (obj is Task) {
    return taskTile(obj, context);
  } else {
    print(obj);
    return Text('tile tried to build not an Arc or Task');
  }
}