The following can be used to perform simple testing of the DB client:

```
import 'package:arcplanner/model/arc.dart';
import 'package:arcplanner/model/task.dart';
import 'package:arcplanner/model/user.dart';
import 'package:arcplanner/util/databaseHelper.dart';

void main () async {

  var db = new DatabaseHelper();

  //add user, arc, task
  User sally = new User("sally", "seashells", "this@that.com");
  Arc getOrganized = new Arc( sally.uid,"clean house");
  Task cleanOffice = new Task(getOrganized.aid, "clean office");
  await db.insertUser(sally);
  await db.insertArc(getOrganized);
  await db.insertTask(cleanOffice);
  //can also do this:
  //await db.insertUser(new User("sally", "seashells", "this@that.com"));

  int count1 = await db.getUserCount();
  int count2 = await db.getArcCount();
  int count3 = await db.getTaskCount();

  print("Database insert/read test");
  if(count1 == 1) print("User: Pass");
  else print("User: Fail");
  if(count2 == 1) print("Arc:  Pass");
  else print("Arc:  Fail");
  if(count3 == 1) print("Task: Pass");
  else print("Task: Fail");

  await db.deleteTask(cleanOffice.tid);
  await db.deleteArc(getOrganized.aid);
  await db.deleteUser(sally.uid);

  count1 = await db.getUserCount();
  count2 = await db.getArcCount();
  count3 = await db.getTaskCount();

  print("Database delete test");

  if(count1 == 0) print("User: Pass");
  else print("User: Fail");
  if(count2 == 0) print("Arc:  Pass");
  else print("Arc:  Fail");
  if(count3 == 0) print("Task: Pass");
  else print("Task: Fail");

  db.close();
}
```

