import 'package:flutter/material.dart';
import 'src/arcplanner.dart';

void main() {
  runApp(ArcPlanner());
}


// import 'src/model/arc.dart';
// import 'src/model/task.dart';
// import 'src/model/user.dart';
// import 'src/util/databaseHelper.dart';

// void main () async {

//   var db = new DatabaseHelper();

//   //add user, arc, task
//   User sally2 = new User("sally2", "seashell2s", "t2his@that.com");
//   Arc getOrganized = new Arc( sally2.uid,"Another Amazing Title",description: "WOW, That's Amazing");
//   await db.insertArc(getOrganized);
  
//   db.close();
// }
