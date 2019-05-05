/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Matthew Chastain, Justin Grabowski, Kevin Kelly
 *    Contributors: 
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file contains the implementation of the BLoC Pattern for Software Design for use with 
 *  Flutter. The Bloc present in this file handles data flow throughout the application.
 */

import 'dart:async';
import '../model/arc.dart';
import '../model/task.dart';
import '../model/user.dart';
import '../util/databaseHelper.dart';
import '../blocs/validators.dart';
import 'package:rxdart/rxdart.dart';
import '../helpers/date.dart';

class Bloc extends Object with Validators {
  final DatabaseHelper db = DatabaseHelper();
  Map<String, dynamic> loadedObjects = Map<String, dynamic>();

  // Constructor
  Bloc();

  // Create streams and getters for views to interact with
  final _arcViewController = StreamController<dynamic>.broadcast();
  final _homeController = StreamController<dynamic>.broadcast();

  // Create streams and getters for parent selection view
  final _arcParentSelectViewController = StreamController<dynamic>.broadcast();

  // Streams for add_arc_screen
  final _arcTitleFieldController = BehaviorSubject<String>();
  final _arcEndDateFieldController = BehaviorSubject<String>();
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

  Stream<String> get arcDescriptionFieldStream =>
      _arcDescriptionFieldController.stream;

  Stream<Arc> get arcParentFieldStream => _arcParentFieldController.stream;

  Stream<bool> get submitValidArc => Observable.combineLatest2(
      arcTitleFieldStream, arcDescriptionFieldStream, (t, d) => true);

  // Change data for Add Arc Screen
  Function(String) get changeArcTitle => _arcTitleFieldController.sink.add;
  Function(String) get changeArcEndDate => _arcEndDateFieldController.sink.add;
  Function(String) get changeArcDescription =>
      _arcDescriptionFieldController.sink.add;
  Function(Arc) get changeArcParent => _arcParentFieldController.sink.add;

  // Create stream and getters for parent selection view
  final _taskViewController = StreamController<dynamic>.broadcast();

  // Streams for add_task_screen
  final _taskTitleFieldController = BehaviorSubject<String>();
  final _taskEndDateFieldController = BehaviorSubject<String>();
  final _taskDescriptionFieldController = BehaviorSubject<String>();
  final _taskLocationFieldController = BehaviorSubject<String>();

  Stream<dynamic> get taskViewStream =>
      _taskViewController.stream.map(transformData);

  // Add data to streams for Add Arc Screen
  Stream<String> get taskTitleFieldStream =>
      _taskTitleFieldController.stream; //.transform(validateTitle);

  Stream<String> get taskEndDateFieldStream =>
      _taskEndDateFieldController.stream;

  Stream<String> get taskDescriptionFieldStream =>
      _taskDescriptionFieldController.stream;

  Stream<String> get taskLocationFieldStream =>
      _taskLocationFieldController.stream;

  Stream<bool> get submitValidTask => Observable.combineLatest2(
      taskTitleFieldStream, arcParentFieldStream, (t, d) => true);

  // Change data for Add Arc Screen
  Function(String) get changeTaskTitle => _taskTitleFieldController.sink.add;
  Function(String) get changeTaskEndDate =>
      _taskEndDateFieldController.sink.add;
  Function(String) get changeTaskDescription =>
      _taskDescriptionFieldController.sink.add;
  Function(String) get changeTaskLocation =>
      _taskLocationFieldController.sink.add;

  void arcViewInsert(dynamic obj) {
    _arcViewController.sink.add(obj);
  }

  void homeInsert(dynamic obj) {
    _homeController.sink.add(obj);
  }

  void parentSelectInsert(dynamic obj) {
    _arcParentSelectViewController.sink.add(obj);
  }

  // Map function that based on the given flag from stream will perform
  //  varying operations that return needed arcs to stream
  dynamic transformData(data) async {
    if (data['flag'] == "add") {
      return await data['object'];
    } else if (data['flag'] == "getChildren") {
      return await getChildren(data['object']);
    } else if (data['flag'] == "getChildArcs") {
      return await getChildArcs(data['object']);
    } else if (data['flag'] == "backButton") {
      Arc parent = getFromMap(data['object']);
      return await getChildren(parent.parentArc);
    } else if (data['flag'] == 'getUpcomingItems') {
      return await getItemsBetweenDates(DateTime.now().toString(), DateTime.now().add(Duration(days: 7)).toString());
    } else if (data['flag'] == "clear") {
      return null;
    }
  }

  // Reads from the DB and returns an Arc object
  Arc toArc(Map map) {
    return Arc.read(map['UID'], map['AID'], map['Title'],
        description: map['Description'],
        dueDate: map['DueDate'],
        parentArc: map['ParentArc'],
        completed: map['Completed'],
        childrenUUIDs: map['ChildrenUUIDs']);

  }

  // Reads from the DB and returns a Task object
  Task toTask(Map map) {
    return Task.read(map['TID'], map['AID'], map['Title'],
        description: map['Description'],
        dueDate: map['DueDate'],
        location: map['Location'],
        completed: map['Completed']);
  }

  // Takes a task or arc as an argument and places it into their respective maps
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

  // Inserts a map of Arcs/Tasks into the map using insertObjectIntoMap for
  //   each object in list.
  List<dynamic> insertListIntoMap(List<Map> list) {
    List<dynamic> objects = List<dynamic>();
    for (Map map in list) {
      objects.add(insertObjectIntoMap(map));
    }
    return objects;
  }

  // Determines whether the given UUID exists within the map
  bool checkMap(String uuid) {
    if (loadedObjects.containsKey(uuid)) {
      return true;
    } else {
      return false;
    }
  }

  // Loads Arc or Task from loaded objects map given a UUID
  dynamic getFromMap(String uuid) {
    return loadedObjects[uuid];
  }

  // Checks to see if children are in map. If they exist in map then send them
  //  back via stream. Otherwise load them from database and into map. Then
  //  to the UI via stream
  Future<List<dynamic>> getChildren(String parentUUID) async {
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
          children = insertListIntoMap(await db.getChildren(parentUUID));
          break;
        }
      }
    }
    return children;
  }

  // Checks to see if children are in map. If they exist in map then send them
  //  back via stream. Otherwise load them from database and into map. Then
  //  to the UI via stream
  Future<List<dynamic>> getChildArcs(String parentUUID) async {
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
          children = insertListIntoMap(await db.getChildArcs(parentUUID));
          break;
        }
      }
    }
    return children;
  }

  submitArc() {
    final validArcTitle = _arcTitleFieldController.value;
    final arcEndDate = _arcEndDateFieldController.value;
    final arcDescription = _arcDescriptionFieldController.value;
    final arcParent = _arcParentFieldController.value;

    //Create arc with new data
    // This section should be removed when we decide how to procede
    // with defining `user` or removing the paramerter from Arc constructor
    User tempUser = new User("Temp", "seashells", "this@that.com");

    if (arcParent == null) {
      Arc ar = new Arc(tempUser.uid, validArcTitle,
          description: arcDescription, dueDate: arcEndDate);
      db.insertArc(ar);
    } else {
      Arc ar = new Arc(tempUser.uid, validArcTitle,
          description: arcDescription,
          dueDate: arcEndDate,
          parentArc: arcParent.aid);
      db.insertArc(ar);
    }

    initializeAddArcStreams();
  }

  editArc() {}

  completeArc() {}

  deleteArc(Arc arc) {
    db.deleteArc(arc.aid);
  }

  submitTask() {
    final validTaskTitle = _taskTitleFieldController.value;
    final taskEndDate = _taskEndDateFieldController.value;
    final taskDescription = _taskDescriptionFieldController.value;
    final taskLocation = _taskLocationFieldController.value;
    final taskParent = _arcParentFieldController.value;

    Task tk = new Task(taskParent.aid, validTaskTitle,
        description: taskDescription,
        dueDate: taskEndDate,
        location: taskLocation);

    db.insertTask(tk);

    initializeAddTaskStreams();
  }

  // Reset the streams used by the add arc screen
  initializeAddArcStreams() {
    bloc.changeArcTitle(null);
    bloc.changeArcEndDate(null);
    bloc.changeArcDescription(null);
    bloc.changeArcParent(null);
  }

  // Reset the streams used by the add task screen
  initializeAddTaskStreams() {
    bloc.changeTaskTitle(null);
    bloc.changeTaskDescription(null);
    bloc.changeTaskEndDate(null);
    bloc.changeTaskLocation(null);
    bloc.changeArcParent(null);
  }

  // Closes the stream controller
  dispose() {
    _arcViewController.close();
    _taskViewController.close();
    _homeController.close();
    _arcParentSelectViewController.close();

    // Close Add Arc Screen streams
    _arcDescriptionFieldController.close();
    _arcEndDateFieldController.close();
    _arcTitleFieldController.close();
    _arcViewController.close();
    _arcParentFieldController.close();

    // Close Add Task screen streams
    _taskDescriptionFieldController.close();
    _taskEndDateFieldController.close();
    _taskTitleFieldController.close();
    _taskLocationFieldController.close();
    _taskViewController.close();
  }
}

final bloc = Bloc();
