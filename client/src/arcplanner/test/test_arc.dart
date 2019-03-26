/** Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 Team CGKM 
 * 
 * Provided AS IS. No warranties expressed or implied. Use at your own risk.
 */

import '../lib//model/arc.dart';
import '../lib//model/user.dart';
import '../lib//model/task.dart';
import '../lib//util/databaseHelper.dart';
import 'package:test_api/test_api.dart';

void main() {
  var db = new DatabaseHelper();

  //Create test User and Arc for testing
  User testUser = new User("test", "user", "testEmail@email.com");
  db.insertUser(testUser);
  Arc testArc = new Arc(testUser.uid, "test arc");

  test('Task should be added', () {
    testArc.addTask("testTitle1");

    expect(testArc.tasks[0].title, "test arc");
  });
}