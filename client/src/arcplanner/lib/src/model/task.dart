/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Justin Grabowski
 *    Contributors: Jonathan Middleton
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file has the Task class and associated functions
 */

import 'package:uuid/uuid.dart';
import '../util/databaseHelper.dart';

class Task {
  // In flutter, underscrore denotes private members
  String _tid;
  String _aid;
  String _title;
  String _description;
  String _dueDate; // SQLite will store the dueDate as TEXT type
  String _location;
  bool _completed;

  /// The default Constructor for Task object
  /// @param aid The UUID of the parent Arc
  /// @param description an optional parameter which is the description of Task.
  ///   The default is null
  /// @param dueDate an optional parameter which is the expected completion date
  ///   of the Task. The default is null
  /// @param location an optional parameter representing the location where
  ///   task is to be completed. The default is null
  Task(this._aid, this._title, {description, dueDate, location}) {
    this._tid = new Uuid().v4();
    this._description = description;
    this._dueDate = dueDate;
    this._location = location;
    this._completed = false;
  }

  /// The default Constructor for Task object
  /// @param aid The UUID of the parent Arc
  /// @param description an optional parameter which is the description of Task.
  ///   The default is null
  /// @param dueDate an optional parameter which is the expected completion date
  ///   of the Task. The default is null
  /// @param location an optional parameter representing the location where
  ///   task is to be completed. The default is null
  Task.read(this._tid, this._aid, this._title, 
      {description, dueDate, location, completed}) {
    this._description = description;
    this._dueDate = dueDate;
    this._location = location;
    if (completed == 'true') {
      this._completed = true;
    } else {
      this._completed = false;
    }
  }

  // Getters
  String get tid => _tid;
  String get aid => _aid;
  String get title => _title;
  String get description => _description;
  String get dueDate => _dueDate;
  String get location => _location;
  bool get completed => _completed;

  /// Puts object data onto a map and returns it
  /// @returns A map of the Task
  Map<String,dynamic> toMap() {
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
