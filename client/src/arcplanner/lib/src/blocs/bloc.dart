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
//import '../model/user.dart';
import '../util/databaseHelper.dart';
import '../blocs/validators.dart';
import 'package:rxdart/rxdart.dart';


class Bloc extends Object with Validators {
  final DatabaseHelper db = DatabaseHelper();
  Map<String, dynamic> loadedObjects = Map<String, dynamic>();
  
  // Constructor
  Bloc();  

  // Create stream and getters for views to interact with
  final _arcViewController = StreamController<dynamic>.broadcast();
  final _homeController = StreamController<dynamic>.broadcast();

  // Streams for add_arc_screen
  final _arcLocationFieldController = BehaviorSubject<String>();
  final _arcTitleFieldController = BehaviorSubject<String>();
  final _arcEndDateFieldController = BehaviorSubject<String>();
  final _arcDescriptionFieldController = BehaviorSubject<String>();
  final _arcParentFieldController = BehaviorSubject<Arc>();
  
  Stream<dynamic> get arcViewStream => _arcViewController.stream.map(transformData);

  // Stream for interaction with Home screen
  Stream<dynamic> get homeStream => _homeController.stream.map(transformData);

  // Add data to streams for Add Arc Screen
  Stream<String> get arcLocationFieldStream => _arcLocationFieldController.stream;

  Stream<String> get arcTitleFieldStream => _arcTitleFieldController.stream.transform(validateTitle);

  Stream<String> get arcEndDateFieldStream => _arcEndDateFieldController.stream;

  Stream<String> get arcDescriptionFieldStream => _arcDescriptionFieldController.stream;

  Stream<Arc> get arcParentFieldStream => _arcParentFieldController.stream;

  Stream<bool> get submitValidArc =>
      Observable.combineLatest2(arcTitleFieldStream, 
    arcDescriptionFieldStream, (t, d) => true);

  // Change data for Add Arc Screen
  Function(String) get changeLocation => _arcLocationFieldController.sink.add;
  Function(String) get changeTitle => _arcTitleFieldController.sink.add;
  Function(String) get changeEndDate => _arcEndDateFieldController.sink.add;
  Function(String) get changeDescription => _arcDescriptionFieldController.sink.add;
  Function(Arc) get changeParent => _arcParentFieldController.sink.add;

  void arcViewInsert(dynamic obj) {
    _arcViewController.sink.add(obj);
  } 

  void homeInsert(dynamic obj) {
    _homeController.sink.add(obj);
  }

  // Map function that based on the given flag from stream will perform
  //  varying operations that return needed arcs to stream 
  dynamic transformData(data) async {
    if (data['flag'] == "add") {
      return await data['object'];
    } else if (data['flag'] == "getChildren") {
      return await getChildren(data['object']);
    } else if (data['flag'] == "backButton") {
      Arc parent = getFromMap(data['object']);
      return await getChildren(parent.parentArc);
    } else if (data['flag'] == 'getUpcoming') {
      return await getUpcomingTasks();
    } else if (data['flag'] == "clear") {
      return null;
    }
  }
  
  // Reads from the DB and returns an Arc object
  Arc toArc(Map map) {
    return Arc.read(map['UID'], map['AID'], map['Title'], description: 
        map['Description'], parentArc: map['ParentArc'], completed: 
        map['Completed'], childrenUUIDs: map['ChildrenUUIDs']);
  }

  // Reads from the DB and returns a Task object
  Task toTask(Map map) {
    return Task.read(map['TID'], map['AID'], map['Title'], description: 
        map['Description'], dueDate: map['DueDate'], location: 
        map['Location'], completed: map['Completed']);
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

  // Pulls all Arcs and Tasks that are due in the next 7 days into the app
  Future<List<dynamic>> getUpcomingTasks() async {
    List<dynamic> upcomingTasks = new List();

    return upcomingTasks;
  }

  // Checks to see if children are in map. If they exist in map then send them
  //  back via stream. Otherwise load them from database and into map. Then
  //  to the UI via stream
  Future<List<dynamic>> getChildren (String parentUUID) async {
    List<dynamic> children = new List();


    // If there is no supplied UUID supply parentArc = null, the masterArcs
    if (parentUUID == null) {
      children = insertListIntoMap(await db.getMasterArcs());
      return children;
    }

    Arc parent = getFromMap(parentUUID);
    
    // If childrenUUIDs is empty then it has no children
    if (parent.childrenUUIDs?.isEmpty ?? true) { // Key does not exist in map yet or doesn't have children
      return null;
    } else {
      // If Children exist in map already
      for (String uuid in parent.childrenUUIDs) {
        if (checkMap(uuid)) {
          children.add(getFromMap(uuid));
        }    
        else {
          // If one child UUID is missing use query to get all children and
          //  add to map. This is to avoid many queries if large list of children
          children = insertListIntoMap(await db.getChildren(parentUUID));
          break;
        }          
      }
    }
    return children;
  }

  submitArc() {
    final arcLoc = _arcLocationFieldController.value;
    final validArcTitle = _arcTitleFieldController.value;
    final arcEndDate = _arcEndDateFieldController.value;
    final arcDescription = _arcEndDateFieldController.value;

    print("$validArcTitle");
    //TODO create arc with new data
    //User sally = new User("sally", "seashells", "this@that.com");
    //Arc ar = new Arc(sally.uid, validArcTitle);
    //db.insertArc(ar);
    //TODO insert to new arc
  }

  // Closes the stream controller
  dispose() {
    _arcViewController.close();
    _homeController.close();

    // Close Add Arc Screen streams
    _arcDescriptionFieldController.close();
    _arcEndDateFieldController.close();
    _arcLocationFieldController.close();
    _arcTitleFieldController.close();
    _arcViewController.close();
    _arcParentFieldController.close();
  }
}

final bloc = Bloc();