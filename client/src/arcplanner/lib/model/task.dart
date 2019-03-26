/** Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 Team CGKM 
 * 
 * Provided AS IS. No warranties expressed or implied. Use at your own risk.
 */

import 'package:uuid/uuid.dart';

class Task {
  //in flutter, underscrore denotes private members
  String _tid;
  String _aid;
  String _title;
  String _description;
  String _dueDate; //SQLite will store the dueDate as TEXT type
  String _location;

  //constructor
  Task(this._aid, this._title,
      {description = null, dueDate = null, location = null}) {
    this._tid = new Uuid().v4();
    this._description = description;
    this._dueDate = duedate;
    this._location = location;
  }

  // Defines a user map.  Helps with moving info betwen the db
  //   and the app
  Task.map(dynamic obj) {
    _tid = obj["tid"]; //represents the PK TID from SQLite db
    _aid = obj["aid"];
    _title = obj["title"];
    _description = obj["description"];
    _dueDate = obj["duedate"];
    _location = obj["location"];
  }

  //getters
  String get tid => _tid;
  String get aid => _aid;
  String get title => _title;
  String get description => _description;
  String get duedate => _dueDate;
  String get location => _location;

  // Puts object data onto a user map
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["aid"] = _aid;
    map["title"] = _title;
    map["description"] = _description;
    map["duedate"] = _dueDate;
    map["location"] = _location;

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
  }
}
