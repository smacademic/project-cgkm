/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Jonathan Middleton
 *    Contributors: 
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This is a test for the DatabaseHelper class. Due to existing limitations of
 *  the SQFlite plugin, running this test normally, as with other Dart tests,
 *  will throw a MissingPluginException. As a workaround, this script must be
 *  run by calling it in the terminal using the following command;
 *      flutter run .\test\database_test.dart
 *  A drawback to this is that the test runs on the emulator or device, and must
 *  be halted manually when the test is complete.
 */

import 'package:flutter_test/flutter_test.dart';
import './../lib/src/util/databaseHelper.dart';
import './../lib/src/model/user.dart';
import './../lib/src/model/arc.dart';

void main() async {
  final db = new DatabaseHelper();

  test('Add user test', () async {
    int users = await db.getUserCount();

    await db.startTransaction();

    User user1 = new User("UFName1", "ULName1", "email1@web.com");

    expect(await db.insertUser(user1), users + 1);

    await db.rollback();
  });

  test('Delete user test', () async {
    await db.startTransaction();

    User user1 = new User("UFName1", "ULName1", "email1@web.com");
    await db.insertUser(user1);

    expect(await db.deleteUser(user1.uid), 1);

    await db.rollback();
  });

  test('Add arc test', () async {
    int arcs = await db.getArcCount();
    await db.startTransaction();
    User user1 = new User("UFName1", "ULName1", "email1@web.com");
    await db.insertUser(user1);

    Arc arc1 = new Arc(user1.uid, "arc title",
        description: "arc description", dueDate: "01/01/2020");

    expect(await db.insertArc(arc1), arcs + 1);

    await db.rollback();
  });

  test('Delete arc test', () async {

    await db.startTransaction();
    User user1 = new User("UFName1", "ULName1", "email1@web.com");
    await db.insertUser(user1);

    Arc arc1 = new Arc(user1.uid, "arc title",
        description: "arc description", dueDate: "01/01/2020");

    await db.insertArc(arc1);

    expect(await db.deleteArc(arc1.aid), 1);

    await db.rollback();
  });
}
