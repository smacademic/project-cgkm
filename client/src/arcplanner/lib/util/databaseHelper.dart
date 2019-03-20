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

    //TODO add constraints
    await db.execute("""
        CREATE TABLE $userTable(
          $userUID VARCHAR(60) PRIMARY KEY CHECK(LENGTH($userUID) <= 60),
          $userFirstName VARCHAR(60) NOT NULL CHECK(LENGTH($userFirstName) <= 60), 
          $userLastName VARCHAR(60) NOT NULL CHECK(LENGTH($userLastName) <= 60), 
          $userEmail VARCHAR(319) CHECK(LENGTH($userEmail) <= 319)
          )""");
    await db.execute("""
        CREATE TABLE $arcTable(
          $arcUID VARCHAR(60) NOT NULL CHECK(LENGTH($arcUID) <= 60), 
          $arcAID VARCHAR(60) NOT NULL CHECK(LENGTH($arcAID) <= 60), 
          $arcTitle VARCHAR(60) NOT NULL CHECK(LENGTH($arcTitle) <= 60), 
          $arcDesc TEXT, 
          $arcPArc VARCHAR(60) CHECK(LENGTH($arcPArc) <= 60),
          FOREIGN KEY ($arcUID) REFERENCES $userTable ($userUID),
          PRIMARY KEY ($arcUID, $arcAID)
          )""");
    await db.execute("""
        CREATE TABLE $taskTable(
          $taskAID VARCHAR(60) CHECK(LENGTH($taskAID) <= 60), 
          $taskTID VARCHAR(60) CHECK(LENGTH($taskTID) <= 60), 
          $taskTitle VARCHAR(60) CHECK(LENGTH($taskTitle) <= 60), 
          $taskDesc TEXT, 
          $taskDueDate TIMESTAMP, 
          $taskLoc VARCHAR(256) CHECK(LENGTH($taskLoc) <= 60),
          FOREIGN KEY ($taskAID) REFERENCES $arcTable ($arcAID),
          PRIMARY KEY ($taskAID, $taskTID)
          )""");
          print("Tables created");
  }

  //TODO add insert, update, remove ops
}
