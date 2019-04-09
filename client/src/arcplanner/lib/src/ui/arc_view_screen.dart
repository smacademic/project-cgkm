import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import 'drawer_menu.dart';

class ArcViewScreen extends StatelessWidget {
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: StreamBuilder(
        stream: bloc.arcViewStream,
        builder: (context, snapshot) {
          ListView.builder(
            itemBuilder: ,
          );
        },
        
      ),

      drawer: drawerMenu(context),
    );
  }
}

Widget tile() {
  return Container(
    
  );
}

Widget displayArc() {
  return StreamBuilder(
    stream: bloc.arc,
    builder: (context, context) {
      return Text(
        //Print some things and stuff
        bloc.getArcTitle
       ),
      ),
    },
  );
}

Widget arcList() {
  return StreamBuilder(
    stream: bloc.arcMap,
    builder: (context, context) {
      return ListView.builder(
        itemCount: arcMap.length,
        itemBuilder: (BuildContext context, int index) {
          return Text (
            arcMap[index].title
          );
        },
      );
    },
  );
}