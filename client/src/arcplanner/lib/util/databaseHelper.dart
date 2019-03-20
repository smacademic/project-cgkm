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

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

// constants for attribute lengths
  static final int uuidSize = 60;
  static final int nameSize = 60;
  static final int locSize = 60;

// constants for table and attribute names
  static final String userTable = "User";
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
          $userUID TEXT PRIMARY KEY CHECK(LENGTH($userUID) < $uuidSize),
          $userFirstName TEXT NOT NULL CHECK(LENGTH($userFirstName) < $nameSize), 
          $userLastName TEXT NOT NULL CHECK(LENGTH($userLastName) < $nameSize), 
          $userEmail TEXT CHECK(LENGTH($userEmail) < 319)
          )""");
    await db.execute("""
        CREATE TABLE $arcTable(
          $arcUID TEXT NOT NULL CHECK(LENGTH($arcUID) < $uuidSize), 
          $arcAID TEXT NOT NULL CHECK(LENGTH($arcAID) < $uuidSize), 
          $arcTitle TEXT NOT NULL CHECK(LENGTH($arcTitle) < $nameSize), 
          $arcDesc TEXT, 
          $arcPArc TEXT CHECK(LENGTH($arcPArc) < $uuidSize),
          FOREIGN KEY ($arcUID) REFERENCES $userTable ($userUID),
          PRIMARY KEY ($arcUID, $arcAID)
          )""");
    await db.execute("""
        CREATE TABLE $taskTable(
          $taskAID TEXT CHECK(LENGTH($taskAID) < $uuidSize), 
          $taskTID TEXT CHECK(LENGTH($taskTID) < $uuidSize), 
          $taskTitle TEXT CHECK(LENGTH($taskTitle) < $nameSize), 
          $taskDesc TEXT, 
          $taskDueDate TEXT, 
          $taskLoc TEXT CHECK(LENGTH($taskLoc) < $locSize),
          FOREIGN KEY ($taskAID) REFERENCES $arcTable ($arcAID),
          PRIMARY KEY ($taskAID, $taskTID)
          )""");
    print("Tables created");
  }

  //TODO add insert, update, remove ops

}
