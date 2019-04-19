/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Jonathan Middleton, Kevin Kelly
 *    Contributors: Matthew Chastain, Justin Grabowski
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file the DatabaseHelper class and associated functions, which are
 *  used by the app to interact with the database.
 */

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '../model/user.dart';
import '../model/task.dart';
import '../model/arc.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

// Constants for attribute lengths
  static final int _uuidSize = 36;
  static final int _nameSize = 60;
  static final int _locSize = 60;
  static final int _emailSize = 319;

// Constants for table and attribute names
  static final String _userTable = "ArcUser";
  static final String _userUID = "UID";
  static final String _userFirstName = "FirstName";
  static final String _userLastName = "LastName";
  static final String _userEmail = "Email";

  static final String _arcTable = "Arc_t";
  static final String _arcView = "Arc";
  static final String _arcUID = "UID";
  static final String _arcAID = "AID";
  static final String _arcTitle = "Title";
  static final String _arcDesc = "Description";
  static final String _arcDueDate = "DueDate";
  static final String _arcPArc = "ParentArc";
  static final String _arcCompleted = "Completed";

  static final String _taskTable = "Task";
  static final String _taskAID = "AID";
  static final String _taskTID = "TID";
  static final String _taskTitle = "Title";
  static final String _taskDesc = "Description";
  static final String _taskDueDate = "DueDate";
  static final String _taskLoc = "Location";
  static final String _taskCompleted = "Completed";


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

  startTransaction() async {
    _db.rawQuery("BEGIN TRANSACTION;");
  }

  rollback() async {
    _db.rawQuery("ROLLBACK;");
  }

  // Creates database tables
  void _onCreate(Database db, int version) async {
    await db.execute("""
        CREATE TABLE $_userTable(
          $_userUID TEXT PRIMARY KEY CHECK(LENGTH($_userUID) = $_uuidSize),
          $_userFirstName TEXT NOT NULL CHECK(LENGTH($_userFirstName) <= $_nameSize), 
          $_userLastName TEXT NOT NULL CHECK(LENGTH($_userLastName) <= $_nameSize), 
          $_userEmail TEXT CHECK(LENGTH($_userEmail) <= $_emailSize)
          )""");
    await db.execute("""
        CREATE TABLE $_arcTable(
          $_arcUID TEXT NOT NULL REFERENCES $_userTable ($_userUID), 
          $_arcAID TEXT PRIMARY KEY NOT NULL CHECK(LENGTH($_arcAID) = $_uuidSize), 
          $_arcTitle TEXT NOT NULL CHECK(LENGTH($_arcTitle) <= $_nameSize), 
          $_arcDesc TEXT, 
          $_arcDueDate TEXT,
          $_arcPArc TEXT CHECK(LENGTH($_arcPArc) = $_uuidSize),
          $_arcCompleted INTEGER CHECK($_arcCompleted == 0 OR $_arcCompleted == 1)
          )""");
    await db.execute("""
        CREATE TABLE $_taskTable(
          $_taskAID TEXT REFERENCES $_arcTable ($_arcAID), 
          $_taskTID TEXT PRIMARY KEY CHECK(LENGTH($_taskTID) = $_uuidSize), 
          $_taskTitle TEXT CHECK(LENGTH($_taskTitle) <= $_nameSize), 
          $_taskDesc TEXT, 
          $_taskDueDate TEXT, 
          $_taskLoc TEXT CHECK(LENGTH($_taskLoc) <= $_locSize),
          $_taskCompleted INTEGER CHECK($_taskCompleted == 0 OR $_taskCompleted == 1)
          )""");
    await db.execute("""
        CREATE VIEW $_arcView AS
        SELECT UID, AID, Title, Description, ParentArc, Completed, 
          ( SELECT group_concat(UUID)
            FROM (
              SELECT Arc2.AID AS UUID
              FROM Arc_t AS Arc2
              WHERE Arc2.ParentArc = Arc1.AID AND Arc2.ParentArc IS NOT NULL
              UNION
              SELECT TID As UUID
              FROM Task
              WHERE Task.AID = Arc1.UID
          )
        ) As ChildrenUUIDs
        FROM Arc_t AS Arc1
        """);
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

  // returns a list of Arcs with no parent. Highest level Arcs
  Future<List<Map>> getMasterArcs() async {
    var dbClient = await db;
    return await dbClient.rawQuery('SELECT * FROM Arc WHERE ParentArc IS NULL');
  }

  // pulls a single Arc from db given a UUID
  Future<List<Map>> getArc(String uuid) async {
    var dbClient = await db;
    return await dbClient.rawQuery('SELECT 1 FROM Arc WHERE AID = $uuid');
  } 

  // pulls a single Task from db given a UUID
  Future<List<Map>> getTask(String uuid) async {
    var dbClient = await db;
    return await dbClient.rawQuery('SELECT 1 FROM Task WHERE TID = $uuid');
  }

  // given a UUID, returns a list of mapped children
  Future<List<Map>> getChildren(String uuid) async {
    var dbClient = await db;
    List<Map> arcList = await dbClient.rawQuery('SELECT * FROM Arc WHERE ParentArc = "$uuid"');
    if (uuid != null) {
      List<Map> taskList = await dbClient.rawQuery('SELECT * FROM Task WHERE AID = "$uuid"');
      return new List.from(arcList)..addAll(taskList);
    } else
      return arcList;
      
  }

  // pulls all Arcs and Tasks out of the database and creates objects out of them
  Future<List<Map>> getArcList() async {
    var dbClient = await db;
    return await dbClient.rawQuery('SELECT * FROM Arc');
  } 

  
  Future<List<Map>> getTaskList() async {
    var dbClient = await db;
    return await dbClient.rawQuery('SELECT * FROM Task');
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
  
  // -----Insert, update and remove ops for arc-----

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