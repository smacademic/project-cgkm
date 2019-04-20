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
 *  This file contains ArcPlanner's main method which runs the application.
 */

import 'package:flutter_test/flutter_test.dart';
import './../lib/src/util/databaseHelper.dart';
import './../lib/src/model/user.dart';
import './../lib/src/model/arc.dart';

void main() async {
  
  final db = new DatabaseHelper();
  
  test('Add user test', () async {

    int users = await db.getUserCount();

    db.startTransaction();

    User user1 = new User("UFName1", "ULName1", "email1@web.com");

    expect(await db.insertUser(user1), users + 1);

    db.rollback();
  });

  test('Add arc test', () async {
    
    int arcs = await db.getArcCount();

    db.startTransaction();
    User user1 = new User("UFName1", "ULName1", "email1@web.com");
    db.insertUser(user1);

    Arc arc1 = new Arc(user1.uid, "task title", description: "task description", dueDate: "01/01/2020");

    expect(await db.insertArc(arc1), arcs + 1);

    db.rollback();
  });

}


