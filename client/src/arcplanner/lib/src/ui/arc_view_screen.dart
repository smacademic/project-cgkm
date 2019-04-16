import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import 'drawer_menu.dart';
import '../model/arc.dart';
import '../model/task.dart';
import 'arc_tile.dart';
import 'task_tile.dart';

class ArcViewScreen extends StatelessWidget {
  static String currentParent = "Home";
  static bool atNoArcTaskScreen = false;

  _toTaskView(Task task) {
  }

  Widget build(context) {
    bool firstTimeLoading = true;


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
                    if (firstTimeLoading) {
                      bloc.arcViewInsert({ 'object' : null, 'flag': 'getChildren'});
                      firstTimeLoading = false;
                    }
                    
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
        color: Colors.blue[400],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('New Task'),
              color: Colors.white,
              textColor: Colors.blue[400],
              // Needs to open New Task dialog
              onPressed: () {},
            ),
            RaisedButton(
              child: Text('New Arc'),
              color: Colors.white,
              textColor: Colors.blue[400],
              // Needs to open New Arc dialog
              onPressed: () {},
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[400],
        child: Icon(Icons.arrow_back),
        onPressed: () {
          if (currentParent == null && !atNoArcTaskScreen) {
            Navigator.pop(context);
          } else {
            if (atNoArcTaskScreen) {
              bloc.arcViewInsert({ 'object' : currentParent, 'flag': 'getChildren'});
              atNoArcTaskScreen = false;
            } 
            else
              bloc.arcViewInsert({ 'object' : currentParent, 'flag': 'backButton'});
          }
        },
      ),
    );
  }
}

Widget tile(dynamic obj, BuildContext context) {
  if (obj is Arc) {
    return arcTile(obj, context);
  } else if (obj is Task) {
    return taskTile(obj, context);
  } else {
    return Text('tile tried to build not an Arc or Task');
  }
}