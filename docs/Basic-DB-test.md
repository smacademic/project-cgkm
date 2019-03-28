The following can be used to perform simple testing of the DB client:

```
import 'package:arcplanner/model/arc.dart';
import 'package:arcplanner/model/task.dart';
import 'package:arcplanner/model/user.dart';
import 'package:arcplanner/util/databaseHelper.dart';
import 'package:flutter/material.dart';

void main () async {

  var db = new DatabaseHelper();

  //add user, arc, task
  User sally = new User("sally", "seashells", "this@that.com");
  Arc getOrganized = new Arc("1", "1","clean house","",null);
  Task cleanOffice = new Task("1", "1","clean office","papers and stuff","tomorrow","home");
  await db.insertUser(sally);
  await db.insertArc(getOrganized);
  await db.insertTask(cleanOffice);
  //can also do this:
  //await db.insertUser(new User("sally", "seashells", "this@that.com"));

  int count1 = await db.getUserCount();
  int count2 = await db.getArcCount();
  int count3 = await db.getTaskCount();

  print("Users: $count1");
  print("Arcs: $count2");
  print("Tasks: $count3");

  // await db.deleteTask(1);
  // await db.deleteArc(1);
  db.close();

  runApp(MyApp());
}
// default main commented out for test
//void main() => runApp(MyApp());
```

