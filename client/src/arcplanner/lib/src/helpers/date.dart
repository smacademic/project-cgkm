/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Matthew Chastain, Kevin Kelly
 *    Contributors: 
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file contains functions that involve specifying Arcs and Tasks by their
 *  dueDate.
 */

import '../blocs/bloc.dart';

Future<List<dynamic>> getItemsBetweenDates(String fromDate, String toDate) async {
  List<Map> upcomingItemsMapList = await bloc.db.getItemsBetweenDates(fromDate, toDate);
  //bloc.insertListIntoMap(await bloc.db.getItemsBetweenDates(fromDate, toDate));


  List<dynamic> upcomingItems = new List();

  for (Map map in upcomingItemsMapList) {
    if (map.containsKey('TID')) {
      // Task task = toTask(map);
      // loadedObjects[map['TID']] = task;
      upcomingItems.add(bloc.toTask(map));
    } else {
      // Arc arc = toArc(map);
      // loadedObjects[map['AID'].toString()] = arc;
      upcomingItems.add(bloc.toArc(map));
    }
  }
  //insertListIntoMap(upcomingItems);  NOT CORRECT FUNCTION
  return upcomingItems;
}