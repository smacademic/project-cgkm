
import 'dart:async';
import '../model/arc.dart';
import '../model/task.dart';
import '../util/databaseHelper.dart';

class Bloc {
  final DatabaseHelper db = DatabaseHelper();
  Map<String, dynamic> loadedObjects = Map<String, dynamic>();

  // Constructor
  Bloc() {
    initMap();
  }
  
  void initMap() async {
    insertListIntoMap(await db.getMasterArcs());
    List<Arc> initialList = new List();
    loadedObjects.forEach(((key, value) => initialList.add(value)));
    sendToArcView(initialList); 

  }

  // Takes in 
  final _arcViewController = StreamController<dynamic>.broadcast();
  Stream<dynamic> get arcViewStream => _arcViewController.stream;
  Function(dynamic) get arcViewInsert => _arcViewController.sink.add;
  
  Arc toArc(Map map) {
    return Arc.read(map['UID'], map['AID'], map['Title'], description: 
        map['Description'], parentArc: map['ParentArc'], completed: 
        map['Completed']);
  }

  Task toTask(Map map) {
    return Task.read(map['TID'], map['AID'], map['Title'], description: 
        map['Description'], dueDate: map['DueDate'], location: 
        map['Location'], completed: map['Completed']);
  }

  insertObjectIntoMap(Map map) {
    if (map.containsKey('TID')) {
      loadedObjects[map['TID']] = toTask(map);
    } else {
      loadedObjects[map['AID'].toString()] = toArc(map);
    }
  }

  insertListIntoMap(List<Map> list) {
    for (Map map in list) {
      insertObjectIntoMap(map);
    }
  }

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
  void getChildren (Arc parent) async {
    // Get first child UUID and see if it exists. If and only if at 
    //  least 1 child exists in map then all children exists
    String firstChildUUID = parent.childrenUUIDs[0];
    if (!checkMap(firstChildUUID)) { // Key does not exist in map yet
      // Add all children to map
      insertListIntoMap(await db.getChildren(parent.aid));
    }
    
    List<dynamic> children;
    parent.childrenUUIDs.forEach((uuid) => children.add(loadedObjects[uuid]));
    sendToArcView(children);
  }

  updateArcView(Arc parent, String flag){
    //flag conditions: getChildren, ...
    if (flag == "getChildren"){
      getChildren(parent);
    } else if (flag == "getParent"){
        //get parent
    } else if (flag == "getParentSiblings"){
      // get parent's siblings
    }
    /*else if... */
  }

  dispose() {
    _arcViewController.close();
  }
}

final bloc = Bloc();