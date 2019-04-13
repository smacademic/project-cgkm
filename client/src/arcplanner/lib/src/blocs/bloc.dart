
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
  Bloc() {
    initMap();
    //?TODO create user?
  }
  
  // Load the BLoC with records from the database to be used by the app
  void initMap() async {
    insertListIntoMap(await db.getMasterArcs());
    List<Arc> initialList = new List();
    loadedObjects.forEach((key, value) {
      initialList.add(value);
    });
    _arcViewController.add({'object': initialList, 'flag': "add"});
  }

  // Create stream and getters for views to interact with
  final _arcViewController = StreamController<dynamic>.broadcast();

  // Streams for add_arc_screen
  final _arcLocationFieldController = BehaviorSubject<String>();
  final _arcTitleFieldController = BehaviorSubject<String>();
  final _arcEndDateFieldController = BehaviorSubject<String>();
  final _arcDescriptionFieldController = BehaviorSubject<String>();
  
  Stream<dynamic> get arcViewStream => _arcViewController.stream.map(transformData);

  // Add data to streams for Add Arc Screen
  Stream<String> get arcLocationFieldStream => _arcLocationFieldController.stream;

  Stream<String> get arcTitleFieldStream => _arcTitleFieldController.stream.transform(validateTitle);

  Stream<String> get arcEndDateFieldStream => _arcEndDateFieldController.stream;

  Stream<String> get arcDescriptionFieldStream => _arcDescriptionFieldController.stream;

  Stream<bool> get submitValidArc =>
      Observable.combineLatest2(arcTitleFieldStream, 
    arcDescriptionFieldStream, (t, d) => true);

  // Change data for Add Arc Screen
  Function(String) get changeLocation => _arcLocationFieldController.sink.add;
  Function(String) get changeTitle => _arcTitleFieldController.sink.add;
  Function(String) get changeEndDate => _arcEndDateFieldController.sink.add;
  Function(String) get changeDescription => _arcDescriptionFieldController.sink.add;

  void arcViewInsert(dynamic obj) {
    _arcViewController.sink.add(obj);
  } 

  // Map function that based on the given flag from stream will perform
  //  varying operations that return needed arcs to stream 
  dynamic transformData(data) async {
    if (data['flag'] == "add") {
      return await data['object'];
    } else if (data['flag'] == "getChildren") {
      return await getChildren(data['object']);
    }
  }
  
  // Reads from the DB and returns an Arc object
  Arc toArc(Map map) {
    return Arc.read(map['UID'], map['AID'], map['Title'], description: 
        map['Description'], parentArc: map['ParentArc'], completed: 
        map['Completed']);
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

  // Using the UUID the associated object is sent to the arcViewController
  sendToArcView(List<dynamic> listOfObjects) {
    _arcViewController.add(listOfObjects);
  }

  // Checks to see if children are in map. If they exist in map then send them
  //  back via stream. Otherwise load them from database and into map. Then
  //  to the UI via stream
  Future<List<dynamic>> getChildren (Arc parent) async {
    List<dynamic> children;

    // Get first child UUID and see if it exists. If and only if at 
    //  least 1 child exists in map then all children exists
    if (parent.childrenUUIDs.isEmpty) { // Key does not exist in map yet or doesn't have children
      // Add all children to map
      children = insertListIntoMap(await db.getChildren(parent.aid));
      children.forEach((object) {
        if (object is Arc) {
          parent.childrenUUIDs.add(object.aid);
        } else {
          parent.childrenUUIDs.add(object.tid);
        }
      });
    } else {
      parent.childrenUUIDs.forEach((uuid) => children.add(loadedObjects[uuid]));
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

    // Close Add Arc Screen streams
    _arcDescriptionFieldController.close();
    _arcEndDateFieldController.close();
    _arcLocationFieldController.close();
    _arcTitleFieldController.close();
    _arcViewController.close();
  }
}

final bloc = Bloc();