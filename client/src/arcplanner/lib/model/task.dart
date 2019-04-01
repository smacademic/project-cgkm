/** Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 Team CGKM 
 * 
 * Provided AS IS. No warranties expressed or implied. Use at your own risk.
 */

import 'package:uuid/uuid.dart';
import 'package:arcplanner/util/databaseHelper.dart';

class Task {
  // In flutter, underscrore denotes private members
  String _tid;
  String _aid;
  String _title;
  String _description;
  String _dueDate; // SQLite will store the dueDate as TEXT type
  String _location;
  bool _completed;

  // Constructor
  Task(this._aid, this._title,
      {description = null, dueDate = null, location = null}) {
    this._tid = new Uuid().v4();
    this._description = description;
    this._dueDate = dueDate;
    this._location = location;
    this._completed = false;
  }

  // Defines a user map.  Helps with moving info betwen the db
  //  and the app
  Task.map(dynamic obj) {
    _tid = obj["tid"]; // Represents the PK TID from SQLite db
    _aid = obj["aid"];
    _title = obj["title"];
    _description = obj["description"];
    _dueDate = obj["duedate"];
    _location = obj["location"];
    _completed = obj["completed"];
  }

  // Getters
  String get tid => _tid;
  String get aid => _aid;
  String get title => _title;
  String get description => _description;
  String get duedate => _dueDate;
  String get location => _location;
  bool get completed => _completed;

  // Puts object data onto a user map
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["aid"] = _aid;
    map["title"] = _title;
    map["description"] = _description;
    map["duedate"] = _dueDate;
    map["location"] = _location;
    map["completed"] = _completed;

    if (tid != null) {
      map["tid"] = _tid;
    }
    return map;
  }

  // Puts user map data into a user object
  Task.fromMap(Map<String, dynamic> map) {
    _tid = map["tid"];
    _aid = map["aid"];
    _title = map["title"];
    _description = map["description"];
    _dueDate = map["duedate"];
    _location = map["location"];
    _completed = map["completed"];
  }

  /*
  * Description: Updates the SQLite related task completed field to true. It then also changes its on instance variable to true.
  */
  void completeTask() {
    var db = new DatabaseHelper();

    _completed = true;
    
    // Update database with updated task
    db.updateTask(this);
  } 
}
