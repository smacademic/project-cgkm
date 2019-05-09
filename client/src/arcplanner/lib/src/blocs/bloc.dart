/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Matthew Chastain, Justin Grabowski, Kevin Kelly
 *    Contributors: Jonathan Middleton
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file contains the implementation of the BLoC Pattern for Software Design for use with 
 *  Flutter. The Bloc present in this file handles data flow throughout the application.
 */

import 'dart:async';
import '../model/arc.dart';
import '../model/task.dart';
import '../util/databaseHelper.dart';
import '../blocs/validators.dart';
import 'package:rxdart/rxdart.dart';
import '../helpers/date.dart';
import 'package:intl/intl.dart';

class Bloc extends Object with Validators {
  var formatter = new DateFormat('yyyy-MM-dd');
  final DatabaseHelper db = DatabaseHelper();
  Map<String, dynamic> loadedObjects = Map<String, dynamic>();
  String userID;

  // Constructor
  Bloc();

  // Create streams and getters for views to interact with
  final _arcViewController = StreamController<dynamic>.broadcast();
  final _homeController = StreamController<dynamic>.broadcast();

  // Create streams and getters for parent selection view
  final _arcParentSelectViewController = StreamController<dynamic>.broadcast();
  
  // Stream for task_screen 
  final _taskController = BehaviorSubject<Task>();

  // Streams for add_arc_screen
  final _arcTitleFieldController = BehaviorSubject<String>();
  final _arcEndDateFieldController = BehaviorSubject<String>();
  final _arcTimeDueFieldController= BehaviorSubject<String>();
  final _arcDescriptionFieldController = BehaviorSubject<String>();
  final _arcParentFieldController = BehaviorSubject<Arc>();

  Stream<dynamic> get arcViewStream =>
      _arcViewController.stream.map(transformData);

  Stream<dynamic> get arcParentSelectViewStream =>
      _arcParentSelectViewController.stream.map(transformData);

  // Stream for interaction with Home screen
  Stream<dynamic> get homeStream => _homeController.stream.map(transformData);

  // Add data to streams for Add Arc Screen
  Stream<String> get arcTitleFieldStream =>
      _arcTitleFieldController.stream; //.transform(validateTitle);

  Stream<String> get arcEndDateFieldStream => _arcEndDateFieldController.stream;

  Stream<String> get arcTimeDueFieldStream => _arcTimeDueFieldController.stream;

  Stream<String> get arcDescriptionFieldStream =>
      _arcDescriptionFieldController.stream;

  Stream<Arc> get arcParentFieldStream => _arcParentFieldController.stream;

  Stream<bool> get submitValidArc => Observable.combineLatest2(
      arcTitleFieldStream, arcDescriptionFieldStream, (t, d) => true);

  // Add data to the stream for Task Screen
  Stream<Task> get taskStream => _taskController.stream;

  // Change data for Add Arc Screen
  Function(String) get changeArcTitle => _arcTitleFieldController.sink.add;
  Function(String) get changeArcEndDate => _arcEndDateFieldController.sink.add;
  Function(String) get changeArcTimeDue => _arcTimeDueFieldController.sink.add;
  Function(String) get changeArcDescription =>
      _arcDescriptionFieldController.sink.add;
  Function(Arc) get changeArcParent => _arcParentFieldController.sink.add;

  // Change data for Task Stream
  Function(Task) get changeTask => _taskController.sink.add;

  // Create stream and getters for parent selection view
  final _taskViewController = StreamController<dynamic>.broadcast();

  // Streams for add_task_screen
  final _taskTitleFieldController = BehaviorSubject<String>();
  final _taskEndDateFieldController = BehaviorSubject<String>();
  final _taskTimeDueFieldController= BehaviorSubject<String>();
  final _taskDescriptionFieldController = BehaviorSubject<String>();
  final _taskLocationFieldController = BehaviorSubject<String>();

  Stream<dynamic> get taskViewStream =>
      _taskViewController.stream.map(transformData);

  // Add data to streams for Add Task Screen
  Stream<String> get taskTitleFieldStream =>
      _taskTitleFieldController.stream; //.transform(validateTitle);

  Stream<String> get taskEndDateFieldStream =>
      _taskEndDateFieldController.stream;

  Stream<String> get taskTimeDueFieldStream => 
      _taskTimeDueFieldController.stream;

  Stream<String> get taskDescriptionFieldStream =>
      _taskDescriptionFieldController.stream;

  Stream<String> get taskLocationFieldStream =>
      _taskLocationFieldController.stream;

  Stream<bool> get submitValidTask => Observable.combineLatest2(
      taskTitleFieldStream, arcParentFieldStream, (t, d) => true);

  // Change data for Add Task Screen
  Function(String) get changeTaskTitle => _taskTitleFieldController.sink.add;
  Function(String) get changeTaskEndDate =>
      _taskEndDateFieldController.sink.add;
  Function(String) get changeTaskTimeDue => _taskTimeDueFieldController.sink.add;
  Function(String) get changeTaskDescription =>
      _taskDescriptionFieldController.sink.add;
  Function(String) get changeTaskLocation =>
      _taskLocationFieldController.sink.add;

  /// Inserts a dynamic object into the `arcViewController` sink
  /// @param obj any object that needs to be added to the `arcViewController` sink
  void arcViewInsert(dynamic obj) {
    _arcViewController.sink.add(obj);
  }

  /// Inserts a dynamic object into the `homeController` sink
  /// @param obj any object that needs to be added to the `homeController` sink
  void homeInsert(dynamic obj) {
    _homeController.sink.add(obj);
  }

  /// Inserts a dynamic object into the `arcParentSelectViewController` sink
  /// @param obj any object that needs to be added to the `arcParentSelectViewController` sink
  void parentSelectInsert(dynamic obj) {
    _arcParentSelectViewController.sink.add(obj);
  }

  /// Map function that based on the given flag from stream will perform
  ///  varying operations that return needed arcs to stream
  /// @param data a map containing a flag and object
  /// @param flag `data` map attribute that signifies what operation to use
  ///   on given object
  /// @param object `data` map attribute that hold the objects to be sent by the
  ///   stream
  /// @returns a list of objects. That list type and quantity is determined by
  ///   the given flag
  dynamic transformData(data) async {
    if (data['flag'] == "add") {
      return await data['object'];
    } else if (data['flag'] == "getChildren") {
      return await getChildren(data['object']);
    } else if (data['flag'] == "getChildArcs") {
      return await getChildren(data['object'], tasks: false);
    } else if (data['flag'] == "backButton") {
      Arc parent = getFromMap(data['object']);
      return await getChildren(parent.parentArc);
    } else if (data['flag'] == 'getUpcomingItems') {
      return await getItemsBetweenDates(DateTime.now().toString(),
          DateTime.now().add(Duration(days: 7)).toString());
    } else if (data['flag'] == "clear") {
      return null;
    }
  }

  /// When given a map of an Arc object, presumably from the database, this
  ///   function converts the map into a Arc object using the `Arc.read`
  ///   constructor
  /// @param map A map of an Arc object
  /// @returns The Arc object that was constructed 
  Arc toArc(Map map) {
    return Arc.read(map['UID'], map['AID'], map['Title'],
        description: map['Description'],
        dueDate: map['DueDate'],
        timeDue: map['TimeDue'],
        parentArc: map['ParentArc'],
        completed: map['Completed'],
        childrenUUIDs: map['ChildrenUUIDs']);
  }

  /// When given a map of an Task object, presumably from the database, this
  ///   function converts the map into a Task object using the `Task.read`
  ///   constructor
  /// @param map A map of a Task object
  /// @returns The Task object that was constructed 
  Task toTask(Map map) {
    return Task.read(map['TID'], map['AID'], map['Title'],
        description: map['Description'],
        dueDate: map['DueDate'],
        timeDue: map['TimeDue'],
        location: map['Location'],
        completed: map['Completed']);
  }

  /// Given a map of a Task or Arc object it will insert its UUID and itself
  ///   into the `loadedObjects` map. UUID represents the key of the map
  /// @param map contains a map of either a Task or Arc
  /// @returns Task or Arc object that was sent via map
  dynamic insertObjectIntoMap(Map map) {
    if (map.containsKey('TID')) {
      Task task = toTask(map);
      loadedObjects[map['TID']] = task;
      return task;
    } else {
      Arc arc = toArc(map);
      loadedObjects[map['AID'].toString()] = arc;
      return arc;
    }
  }

  /// Inserts a map of Arcs/Tasks into the `LoadedObjects` map using
  ///   `insertObjectIntoMap` function foreach object in list.
  /// @param list A list of Arc and/or Task maps to be converted and added 
  ///   to the `LoadedObjects` map
  /// @returns the List of objects that was converted from the list of maps
  List<dynamic> insertListIntoMap(List<Map> list) {
    List<dynamic> objects = List<dynamic>();
    for (Map map in list) {
      objects.add(insertObjectIntoMap(map));
    }
    return objects;
  }

  /// Determines whether the given UUID exists within the `LoadedObjects` map
  /// @param uuid A uuid to be checked if it exists within the `LoadedObjects`
  ///   map
  /// @returns boolean value representing whether the UUID exists in the 
  ///   `LoadedObjects` map
  bool checkMap(String uuid) {
    if (loadedObjects.containsKey(uuid)) {
      return true;
    } else {
      return false;
    }
  }

  /// Loads Arc or Task from `LoadedObjects` map given a UUID.
  /// @param UUID represents a UUID of the object that will be returned
  /// @returns The object whos UUID matches the given UUID. UUID is the key of
  ///   `LoadedObjects` map
  dynamic getFromMap(String uuid) {
    return loadedObjects[uuid];
  }

  /// Checks to see if children are in map. If they exist in map then send them
  ///   back via stream. Otherwise load them from database and into map. Then
  ///   to the UI via stream
  /// @param parentUUID the UUID of the parent whos children will be returned
  /// @param arcs determines whether arcs should be returned. Default is true
  /// @param tasks determines whether tasks should be returned. Default is true
  /// @returns All Tasks and Arcs that have `parentUUID` set as their `parentArc`
  Future<List<dynamic>> getChildren(String parentUUID, {arcs = true, tasks = true}) async {
    List<dynamic> children = new List();

    // If there is no supplied UUID supply parentArc = null, the masterArcs
    if (parentUUID == null) {
      children = insertListIntoMap(await db.getMasterArcs());
      return children;
    }

    Arc parent = getFromMap(parentUUID);

    // If childrenUUIDs is empty then it has no children
    if (parent.childrenUUIDs?.isEmpty ?? true) {
      // Key does not exist in map yet or doesn't have children
      return null;
    } else {
      // If Children exist in map already
      for (String uuid in parent.childrenUUIDs) {
        if (checkMap(uuid)) {
          children.add(getFromMap(uuid));
        } else {
          // If one child UUID is missing use query to get all children and
          //  add to map. This is to avoid many queries if large list of children
          children = insertListIntoMap(await db.getChildren(parentUUID, arcs: arcs, tasks: tasks));
          break;
        }
      }
    }
    return children;
  }

  /// Using the various streams from `add_arc_screen.dart` an arc object is
  ///   created and then added to the database
  void submitArc() {
    final validArcTitle = _arcTitleFieldController.value;
    final arcEndDate = _arcEndDateFieldController.value;
    final arcTimeDue = _arcTimeDueFieldController.value;
    final arcDescription = _arcDescriptionFieldController.value;
    final arcParent = _arcParentFieldController.value;

    //Create arc with new data
    // This section should be removed when we decide how to proceed
    // with defining `user` or removing the parameter from Arc constructor
    String formattedDueDate = null;

    if (arcEndDate != null) {
      DateTime parsedDueDate = DateTime.parse(arcEndDate);
      formattedDueDate = formatter.format(parsedDueDate);
    } 

    if (arcParent == null) {
      Arc ar = new Arc(bloc.userID, validArcTitle,
          description: arcDescription, 
          timeDue: arcTimeDue,
          dueDate: formattedDueDate);
      db.insertArc(ar);
    } else {

      Arc ar = new Arc(bloc.userID, validArcTitle,
          description: arcDescription,
          timeDue: arcTimeDue,
          dueDate: formattedDueDate,
          parentArc: arcParent.aid);
      db.insertArc(ar);
    }

    initializeAddArcStreams();
  }

  editArc(Arc arc) {}
  
  ///  Marks an arc as complete database
  ///  @param arc, the Arc to be completed
  ///
  completeArc(Arc arc) async {
    arc.completeArc();
    await db.updateArc(arc);
  }

  ///  Deletes an arc from the database BLOC
  ///  Removes reference to itself if it has a parent; deletes arc from
  ///   loadedObjects, and deletes the arc from the db
  ///  @param arc, the Arc to be deleted
  ///
  deleteArc(Arc arc) async {

    List<Map> parentList = await db.getArc(arc.parentArc);

    if (parentList.length > 0) {
      Arc parent = new Arc.fromMap(parentList.first);
      parent.childrenUUIDs.remove(arc.aid);
      await db.updateArc(parent);
    }

    if (loadedObjects.containsKey(arc.aid)) {
      loadedObjects.remove(arc.aid);
    }
    await db.deleteArc(arc.aid);
    
  }


  /// Using the various streams from `add_task_screen.dart` an Task object is
  ///   created and then added to the database
  void submitTask() {
    final validTaskTitle = _taskTitleFieldController.value;
    final taskEndDate = _taskEndDateFieldController.value;
    final taskTimeDue = _taskTimeDueFieldController.value;
    final taskDescription = _taskDescriptionFieldController.value;
    final taskLocation = _taskLocationFieldController.value;
    final taskParent = _arcParentFieldController.value;

    String formattedDueDate = null;

    if (taskEndDate != null) {
      DateTime parsedDueDate = DateTime.parse(taskEndDate);
      formattedDueDate = formatter.format(parsedDueDate);
    }

    Task tk = new Task(taskParent.aid, validTaskTitle,
        description: taskDescription,
        dueDate: formattedDueDate,
        timeDue: taskTimeDue,
        location: taskLocation);

    db.insertTask(tk);

    initializeAddTaskStreams();
  }

  editTask(Task task){}

  ///  Marks a task as complete database
  ///  @param task, the Task to be completed
  ///
  completeTask(Task task) async {
    task.completeTask();
    await db.updateTask(task);
  }

  ///  Deletes a task from the database BLOC
  ///  Removes reference to itself if it has a parent; deletes task from
  ///   loadedObjects, and deletes the task from the db
  ///  @param task, the Task to be deleted
  ///
  deleteTask(Task task) async {

    List<Map> parentList = await db.getArc(task.aid);

    if (parentList.length > 0) {
      Arc parent = new Arc.fromMap(parentList.first);
      parent.childrenUUIDs.remove(task.tid);
      await db.updateArc(parent);
    }

    if (loadedObjects.containsKey(task.tid)) {
      loadedObjects.remove(task.tid);
    }
    await db.deleteTask(task.tid);
  }


  /// Resets the streams used by the add arc screen
  void initializeAddArcStreams() {
    bloc.changeArcTitle(null);
    bloc.changeArcEndDate(null);
    bloc.changeArcTimeDue(null);
    bloc.changeArcDescription(null);
    bloc.changeArcParent(null);
  }

  /// Reset the streams used by the add task screen
  void initializeAddTaskStreams() {
    bloc.changeTaskTitle(null);
    bloc.changeTaskDescription(null);
    bloc.changeTaskEndDate(null);
    bloc.changeTaskTimeDue(null);
    bloc.changeTaskLocation(null);
    bloc.changeArcParent(null);
  }

  /// Closes the stream controllers
  void dispose() {
    _arcViewController.close();
    _taskViewController.close();
    _homeController.close();
    _arcParentSelectViewController.close();

    // Close Add Arc Screen streams
    _arcDescriptionFieldController.close();
    _arcEndDateFieldController.close();
    _arcTimeDueFieldController.close();
    _arcTitleFieldController.close();
    _arcViewController.close();
    _arcParentFieldController.close();

    // Close Add Task screen streams
    _taskDescriptionFieldController.close();
    _taskEndDateFieldController.close();
    _taskTimeDueFieldController.close();
    _taskTitleFieldController.close();
    _taskLocationFieldController.close();
    _taskViewController.close();

    // Close Task Screen stream
    _taskController.close();
  }
}

final bloc = Bloc();
