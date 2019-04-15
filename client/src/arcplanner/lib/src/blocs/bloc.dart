
import 'dart:async';
import '../model/arc.dart';
import '../model/task.dart';
import '../util/databaseHelper.dart';

class Bloc {
  final DatabaseHelper db = DatabaseHelper();
  Map<String, dynamic> loadedObjects = Map<String, dynamic>();

  // Constructor
  Bloc() {
    //initArcView();
  }
  
  // Load the BLoC with records from the database to be used by the app
  void initArcView() async {
    insertListIntoMap(await db.getMasterArcs());
    List<Arc> initialList = new List();
    loadedObjects.forEach((key, value) {
      initialList.add(value);
    });
  }


  // Create stream and getters for views to interact with
  final _arcViewController = StreamController<dynamic>.broadcast();
  Stream<dynamic> get arcViewStream => _arcViewController.stream.map(transformData);
  
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
    } else if (data['flag'] == "backButton") {
      Arc parent = getFromMap(data['object']);
      return await getChildren(parent.parentArc);
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

  dynamic getFromMap(String uuid) {
    return loadedObjects[uuid];
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

  // Closes the stream controller
  dispose() {
    _arcViewController.close();
  }
}

final bloc = Bloc();