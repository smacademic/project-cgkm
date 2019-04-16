/** Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 Team CGKM 
 * 
 * Provided AS IS. No warranties expressed or implied. Use at your own risk.
 */

import 'package:uuid/uuid.dart';

class Arc {
  // In flutter, underscore denotes private members
  String _aid;
  String _uid;
  String _title;
  String _description;
  String _dueDate;
  String _parentArc;
  bool _completed;
  List<String> childrenUUIDs = new List();

  // Constructor
  Arc(this._uid, this._title, {description, dueDate, parentArc}) {
    this._aid = new Uuid().v4();
    this._description = description;
    this._dueDate = dueDate;
    this._parentArc = parentArc;
    this._completed = false;
  }

  // Constructor to build object read from database
  Arc.read(this._uid, this._aid, this._title, 
      {description, dueDate, parentArc, completed}) {
    this._description = description;
    this._dueDate = dueDate;
    this._parentArc = parentArc;
    this.childrenUUIDs = childrenUUIDs?.split(",");
    if (completed == '1') {
      this._completed = true;
    } else {
      this._completed = false;
    }
  }

  // Defines a user map.  Helps with moving info between the db
  //  and the app
  Arc.map(dynamic obj) {
    _aid = obj["aid"];
    _uid = obj["uid"];
    _title = obj["title"];
    _description = obj["description"];
    _dueDate = obj["dueDate"];
    _parentArc = obj["parentarc"];
    _completed = obj["completed"];
  }

  // Getters
  String get aid => _aid;
  String get uid => _uid;
  String get title => _title;
  String get description => _description;
  String get dueDate => _dueDate;
  String get parentArc => _parentArc;
  bool get completed => _completed;

  // Puts object data onto a user map
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["uid"] = _uid;
    map["title"] = _title;
    map["description"] = _description;
    map["dueDate"] = _dueDate;
    map["parentarc"] = _parentArc;
    map["completed"] =_completed;

    if (aid != null) {
      map["aid"] = _aid;
    }
    return map;
  }

  // Puts user map data into a user object
  Arc.fromMap(Map<String, dynamic> map) {
    _aid = map["aid"];
    _uid = map["uid"];
    _title = map["title"];
    _description = map["description"];
    _dueDate = map["dueDate"];
    _parentArc = map["parentarc"];
    _completed = map["completed"];
  }

/*
/*---------------Member Functions-------------*/

  /*
  * Description: The parameters supply needed information to create a Task within
  *  the SQLite database with the exception of the ID. This ID needs to be 
  *  generated with a UUID. This data is sent to the SQLite database to be
  *  inserted into the task table. If successfully inserted the data should be
  *  used to create a task object. That task object should then be added to the
  *  list of tasks belonging to the Arc which called the instance method.
  * @param title represents the title of the Task
  * @param description is the information that describes the  task objective. 
  *  This is null by default
  * @param dueDate is the date when the task should be completed by.
  *  This is null by default
  * @param location is where the task takes place. This is null by default
  * Return: Returns the created task
  */
  Task addTask(String title,
      {String description = null,
      DateTime dueDate = null,
      String location = null}) {
    var db = new DatabaseHelper();

    try {
      Task task = new Task(this._aid, title,
          description: description,
          dueDate: dueDate.toString(),
          location: location);

      // Insert new task into db
      db.insertTask(task);

      // Add the new task to the list of tasks belonging to this arc
      tasks.add(task);

      return task;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /*   
  * Description: Given a taskID it deletes the task entry for the supplied task ID. 
  *  It then searches the collection of task objects in the instance of Arc until it 
  *  finds the correct task. It then removes and deletes that task from the arc object. 
  * @param taskID the TID of the task that needs to be deleted 
  */
  void removeTask(String taskID) {
    var db = new DatabaseHelper();

    try {
      // Insert new task into db
      db.deleteTask(taskID);

      // Add the new task to the list of tasks belonging to this arc
      tasks.removeWhere((task) => task.tid == taskID);
    } catch (e) {
      print(e);
      return null;
    }
  }

  /*
  * Description: Adds the given subArc to the collection of subArcs that the Arc class has.
  * @param subArc is the Arc to be added to the parent's collection of subarcs
  */
  void addSubArc(Arc subArc) {
    subArcs.add(subArc);
  }

  /*
  * Description: Given the ID of the sub arc the correct Arc is found in the SQLite file 
  *  and deleted. It is then also found in the arc instance's collection of sub arcs. 
  *  Once found that arc runs its own destructor function.
  * @param subArcID is the ID that represents the subArc that is going to removed.
  */
  void removeSubArc(String subArcID) {
    var db = new DatabaseHelper();

    subArcs.firstWhere((subArc) => subArc.aid == subArcID).removeAll();

    db.deleteArc(subArcID);
    subArcs.removeWhere((subArc) => subArc.aid == subArcID);
  }

  /*
  * Description: Removes all tasks and subArcs that belong to the Arc
  */
  void removeAll() {
    var db = new DatabaseHelper();

    // Delete all tasks in database then all objects
    tasks.forEach((task) => db.deleteTask(task.tid));
    tasks.clear();

    // Call remove all function on each subArc
    subArcs.forEach((subArc) {
      subArc.removeAll();
      db.deleteArc(subArc.aid);
    });
    subArcs.clear(); 
  }

  /*
  * Description: Updates the SQLite related arc completed field to true. It then also changes its on instance variable to true.
  */
  void completeArc() {
    var db = new DatabaseHelper();

    _completed = true;
    
    // Update database with updated arc
    db.updateArc(this);
  } 
  */
}
