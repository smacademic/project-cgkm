/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Justin Grabowski, Kevin Kelly
 *    Contributors:  Jonathan Middleton
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file has the Arc class and associated functions
 */

import 'package:uuid/uuid.dart';

class Arc {
  // In flutter, underscore denotes private members
  String _aid;
  String _uid;
  String _title;
  String _description;
  String _dueDate;
  String _timeDue;
  String _parentArc;
  bool _completed;
  List<String> childrenUUIDs = new List();

  /// The default Constructor for Arc object
  /// @param uid The UUID of the user
  /// @param title the title of the arc
  /// @param description an optional parameter which is the description of Arc.
  ///   The default is null
  /// @param dueDate an optional parameter which is the expected completion date
  ///   of the given arc. The default is null
  /// @param parentArc an optional parameter representing the UUID of the parent
  ///   arc. The default is null
  Arc(this._uid, this._title, {description, timeDue, dueDate, parentArc,}) {
    this._aid = new Uuid().v4();
    this._description = description;
    this._dueDate = dueDate;

    if (timeDue == null) {
      timeDue = '23:59:59';
    } else {
      this._timeDue = timeDue;
    }
    
    this._parentArc = parentArc;
    this._completed = false;
  }

  /// A Constructor for Arc object that is used to upon reading from database
  ///   to create an Arc object
  /// @param uid The UUID of the user
  /// @param title the title of the arc
  /// @param description an optional parameter which is the description of Arc.
  ///   The default is null
  /// @param dueDate an optional parameter which is the expected completion date
  ///   of the given arc. The default is null
  /// @param parentArc an optional parameter representing the UUID of the parent
  ///   arc. The default is null
  /// @param completed represents whether the arc has been completed
  /// @param childrenUUIDs A list of UUIDs repesenting the UUIDs of the children
  ///   Arcs and Tasks
  Arc.read(this._uid, this._aid, this._title, 
      {description, dueDate, timeDue, parentArc, completed, childrenUUIDs}) {
    this._description = description;
    this._dueDate = dueDate;

    if (timeDue == null) {
      timeDue = '23:59:59';
    } else {
      this._timeDue = timeDue;
    }

    this._parentArc = parentArc;
    this.childrenUUIDs = childrenUUIDs?.split(",");
    if (completed == '1') {
      this._completed = true;
    } else {
      this._completed = false;
    }
  }

  // Getters
  String get aid => _aid;
  String get uid => _uid;
  String get title => _title;
  String get description => _description;
  String get dueDate => _dueDate;
  String get timeDue => _timeDue;
  String get parentArc => _parentArc;
  bool get completed => _completed;

  /// Converts arc objects to a map of its attributes and its values
  /// @returns a map of the object
  Map<String,dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["uid"] = _uid;
    map["title"] = _title;
    map["description"] = _description;
    map["dueDate"] = _dueDate;
    map["timeDue"] = _timeDue;
    map["parentarc"] = _parentArc;
    map["completed"] =_completed;

    if (aid != null) {
      map["aid"] = _aid;
    }
    return map;
  }

  /// Puts user map data into a arc object
  Arc.fromMap(Map<String, dynamic> map) {
    _aid = map["aid"];
    _uid = map["uid"];
    _title = map["title"];
    _description = map["description"];
    _dueDate = map["dueDate"];
    _timeDue = map["timeDue"];
    _parentArc = map["parentarc"];
    _completed = map["completed"];
  }
}
