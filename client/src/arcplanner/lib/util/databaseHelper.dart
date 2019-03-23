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

// constants for attribute lengths
  static final int uuidSize = 60;
  static final int nameSize = 60;
  static final int locSize = 60;
  static final int emailSize = 319;

// constants for table and attribute names
  static final String userTable = "ArcUser";
  static final String userUID = "UID";
  static final String userFirstName = "FirstName";
  static final String userLastName = "LastName";
  static final String userEmail = "Email";

  static final String arcTable = "Arc";
  static final String arcUID = "UID";
  static final String arcAID = "AID";
  static final String arcTitle = "Title";
  static final String arcDesc = "Description";
  static final String arcPArc = "ParentArc";

  static final String taskTable = "Task";
  static final String taskAID = "AID";
  static final String taskTID = "TID";
  static final String taskTitle = "Title";
  static final String taskDesc = "Description";
  static final String taskDueDate = "DueDate";
  static final String taskLoc = "Location";

// singleton database initialization
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

// initialization implementation
  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "arcplanner_db.db");
    var arcDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return arcDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("""
        CREATE TABLE $userTable(
          $userUID TEXT PRIMARY KEY CHECK(LENGTH($userUID) == $uuidSize),
          $userFirstName TEXT NOT NULL CHECK(LENGTH($userFirstName) <= $nameSize), 
          $userLastName TEXT NOT NULL CHECK(LENGTH($userLastName) <= $nameSize), 
          $userEmail TEXT CHECK(LENGTH($userEmail) <= $emailSize)
          )""");
    await db.execute("""
        CREATE TABLE $arcTable(
          $arcUID TEXT NOT NULL REFERENCES $userTable ($userUID), 
          $arcAID TEXT PRIMARY KEY NOT NULL CHECK(LENGTH($arcAID) == $uuidSize), 
          $arcTitle TEXT NOT NULL CHECK(LENGTH($arcTitle) <= $nameSize), 
          $arcDesc TEXT, 
          $arcPArc TEXT CHECK(LENGTH($arcPArc) = $uuidSize)
          )""");
    await db.execute("""
        CREATE TABLE $taskTable(
          $taskAID TEXT REFERENCES $arcTable ($arcAID), 
          $taskTID TEXT PRIMARY KEY CHECK(LENGTH($taskTID) == $uuidSize), 
          $taskTitle TEXT CHECK(LENGTH($taskTitle) <= $nameSize), 
          $taskDesc TEXT, 
          $taskDueDate TEXT, 
          $taskLoc TEXT CHECK(LENGTH($taskLoc) <= $locSize)
          )""");
    print("Tables created");
  }

  // Inserts a new user to the DB using a User object as an input
  Future<int> insertUser(User usr) async {
    var dbClient = await db;
    int result = await dbClient.insert("$userTable", usr.toMap());
    return result;
  }

  // Deletes a user with the given ID
  Future<int> deleteUser(int id) async {
    var dbClient = await db;
    int result = await dbClient
        .delete(userTable, where: "$userUID = ?", whereArgs: [id]);
    return result;
  }

  // Updates a user in the DB using a User object (with matching UID)
  Future<int> updateUser(User usr) async {
    var dbClient = await db;
    return await dbClient.update(userTable, usr.toMap(),
        where: "$userUID = ?", whereArgs: [usr.uid]);
  }
  
  //TODO add insert, update, remove ops for arc, and task

  // -----Insert, update and remove ops for task-----

  // Inserts a new task to the DB using a Task object as an input
  Future<int> insertTask(Task tsk) async {
    var dbClient = await db;
    int result = await dbClient.insert("$taskTable", tsk.toMap());
    return result;
  }

  // Deletes a task with the given ID
  Future<int> deleteTask(int id) async {
    var dbClient = await db;
    int result = await dbClient
        .delete(userTable, where: "$taskTID = ?", whereArgs: [id]);
    return result;
  }

  // Updates a task in the DB using a Task object (with matching TID)
  Future<int> updateTask(Task tsk) async {
    var dbClient = await db;
    return await dbClient.update(taskTable, tsk.toMap(),
        where: "$taskTID = ?", whereArgs: [tsk.tid]);
  }
  
  // -----Insert, update and remove ops for ark-----

  // Inserts a new arc to the DB using a Arc object as an input
  Future<int> insertArc(Arc ar) async {
    var dbClient = await db;
    int result = await dbClient.insert("$arcTable", ar.toMap());
    return result;
  }

  // Deletes a arc with the given ID
  Future<int> deleteArc(int id) async {
    var dbClient = await db;
    int result = await dbClient
        .delete(userTable, where: "$arcAID = ?", whereArgs: [id]);
    return result;
  }

  // Updates a arc in the DB using a User object (with matching AID)
  Future<int> updateArc(Arc ar) async {
    var dbClient = await db;
    return await dbClient.update(taskTable, ar.toMap(),
        where: "$arcAID = ?", whereArgs: [ar.aid]);
  }
  


  
}