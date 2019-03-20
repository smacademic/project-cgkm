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

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "arcplanner_db.db");
    var arcDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return arcDb;
  }

  void _onCreate(Database db, int version) async {

    await db.execute("""
        CREATE TABLE $userTable(
          $userUID TEXT PRIMARY KEY CHECK(LENGTH($userUID) <= 60),
          $userFirstName TEXT NOT NULL CHECK(LENGTH($userFirstName) <= 60), 
          $userLastName TEXT NOT NULL CHECK(LENGTH($userLastName) <= 60), 
          $userEmail TEXT CHECK(LENGTH($userEmail) <= 319)
          )""");
    await db.execute("""
        CREATE TABLE $arcTable(
          $arcUID TEXT NOT NULL CHECK(LENGTH($arcUID) <= 60), 
          $arcAID TEXT NOT NULL CHECK(LENGTH($arcAID) <= 60), 
          $arcTitle TEXT NOT NULL CHECK(LENGTH($arcTitle) <= 60), 
          $arcDesc TEXT, 
          $arcPArc TEXT CHECK(LENGTH($arcPArc) <= 60),
          FOREIGN KEY ($arcUID) REFERENCES $userTable ($userUID),
          PRIMARY KEY ($arcUID, $arcAID)
          )""");
    await db.execute("""
        CREATE TABLE $taskTable(
          $taskAID TEXT CHECK(LENGTH($taskAID) <= 60), 
          $taskTID TEXT CHECK(LENGTH($taskTID) <= 60), 
          $taskTitle TEXT CHECK(LENGTH($taskTitle) <= 60), 
          $taskDesc TEXT, 
          $taskDueDate TEXT, 
          $taskLoc TEXT CHECK(LENGTH($taskLoc) <= 60),
          FOREIGN KEY ($taskAID) REFERENCES $arcTable ($arcAID),
          PRIMARY KEY ($taskAID, $taskTID)
          )""");
          print("Tables created");
  }

  //TODO add insert, update, remove ops

}
