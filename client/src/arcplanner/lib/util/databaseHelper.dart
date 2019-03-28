/** Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 Team CGKM 
 * 
 * Provided AS IS. No warranties expressed or implied. Use at your own risk.
 */

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import './../model/user.dart';
import './../model/task.dart';
import './../model/arc.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

// Constants for attribute lengths
  static final int _uuidSize = 60;
  static final int _nameSize = 60;
  static final int _locSize = 60;
  static final int _emailSize = 319;

// Constants for table and attribute names
  static final String _userTable = "ArcUser";
  static final String _userUID = "UID";
  static final String _userFirstName = "FirstName";
  static final String _userLastName = "LastName";
  static final String _userEmail = "Email";

  static final String _arcTable = "Arc";
  static final String _arcUID = "UID";
  static final String _arcAID = "AID";
  static final String _arcTitle = "Title";
  static final String _arcDesc = "Description";
  static final String _arcPArc = "ParentArc";

  static final String _taskTable = "Task";
  static final String _taskAID = "AID";
  static final String _taskTID = "TID";
  static final String _taskTitle = "Title";
  static final String _taskDesc = "Description";
  static final String _taskDueDate = "DueDate";
  static final String _taskLoc = "Location";

// Singleton database initialization
  Future<Database> get db async{
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

// Initialization implementation
  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "arcplanner_db.db");
    var arcDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return arcDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("""
        CREATE TABLE $_userTable(
          $_userUID TEXT PRIMARY KEY CHECK(LENGTH($_userUID) <= $_uuidSize),
          $_userFirstName TEXT NOT NULL CHECK(LENGTH($_userFirstName) <= $_nameSize), 
          $_userLastName TEXT NOT NULL CHECK(LENGTH($_userLastName) <= $_nameSize), 
          $_userEmail TEXT CHECK(LENGTH($_userEmail) <= $_emailSize)
          )""");
    await db.execute("""
        CREATE TABLE $_arcTable(
          $_arcUID TEXT NOT NULL REFERENCES $_userTable ($_userUID), 
          $_arcAID TEXT PRIMARY KEY NOT NULL CHECK(LENGTH($_arcAID) <= $_uuidSize), 
          $_arcTitle TEXT NOT NULL CHECK(LENGTH($_arcTitle) <= $_nameSize), 
          $_arcDesc TEXT, 
          $_arcPArc TEXT CHECK(LENGTH($_arcPArc) = $_uuidSize)
          )""");
    await db.execute("""
        CREATE TABLE $_taskTable(
          $_taskAID TEXT REFERENCES $_arcTable ($_arcAID), 
          $_taskTID TEXT PRIMARY KEY CHECK(LENGTH($_taskTID) <= $_uuidSize), 
          $_taskTitle TEXT CHECK(LENGTH($_taskTitle) <= $_nameSize), 
          $_taskDesc TEXT, 
          $_taskDueDate TEXT, 
          $_taskLoc TEXT CHECK(LENGTH($_taskLoc) <= $_locSize)
          )""");
    print("Tables created");
  }

  // Inserts a new user to the DB using a User object as an input
  Future<int> insertUser(User usr) async {
    var dbClient = await db;
    int result = await dbClient.insert("$_userTable", usr.toMap());
    return result;
  }

  // Deletes a user with the given ID
  Future<int> deleteUser(String id) async {
    var dbClient = await db;
    int result = await dbClient
        .delete(_userTable, where: "$_userUID = ?", whereArgs: [id]);
    return result;
  }

  // Updates a user in the DB using a User object (with matching UID)
  Future<int> updateUser(User usr) async {
    var dbClient = await db;
    return await dbClient.update(_userTable, usr.toMap(),
        where: "$_userUID = ?", whereArgs: [usr.uid]);
  }

  // Get count of users
  Future<int> getUserCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $_userTable"));
  }

  // -----Insert, update and remove ops for task-----

  // Inserts a new task to the DB using a Task object as an input
  Future<int> insertTask(Task tsk) async {
    var dbClient = await db;
    int result = await dbClient.insert("$_taskTable", tsk.toMap());
    return result;
  }

  // Deletes a task with the given ID
  Future<int> deleteTask(String id) async {
    var dbClient = await db;
    int result = await dbClient
        .delete(_taskTable, where: "$_taskTID = ?", whereArgs: [id]);
    return result;
  }

  // Updates a task in the DB using a Task object (with matching TID)
  Future<int> updateTask(Task tsk) async {
    var dbClient = await db;
    return await dbClient.update(_taskTable, tsk.toMap(),
        where: "$_taskTID = ?", whereArgs: [tsk.tid]);
  }

  // Get count of tasks
  Future<int> getTaskCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $_taskTable"));
  }
  
  // -----Insert, update and remove ops for ark-----

  // Inserts a new arc to the DB using a Arc object as an input
  Future<int> insertArc(Arc ar) async {
    var dbClient = await db;
    int result = await dbClient.insert("$_arcTable", ar.toMap());
    return result;
  }

  // Deletes a arc with the given ID
  Future<int> deleteArc(String id) async {
    var dbClient = await db;
    int result = await dbClient
        .delete(_arcTable, where: "$_arcAID = ?", whereArgs: [id]);
    return result;
  }

  // Updates a arc in the DB using a User object (with matching AID)
  Future<int> updateArc(Arc ar) async {
    var dbClient = await db;
    return await dbClient.update(_arcTable, ar.toMap(),
        where: "$_arcAID = ?", whereArgs: [ar.aid]);
  }
  
  // Get count of tasks
  Future<int> getArcCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $_arcTable"));
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
  
}