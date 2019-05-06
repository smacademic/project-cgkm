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


/// Retrieves all Arcs and Tasks inclusively between the given two dates
/// @param fromDate Represents the starting date of range of dates to be searched
/// @param toDate Represents the ending date of range of dates to be searched
/// @returns a future list of Arcs and Tasks from the data. This inherently will
///   result in maps of these objects
Future<List<dynamic>> getItemsBetweenDates(String fromDate, String toDate) async {
  List<Map> upcomingItemsMapList = await bloc.db.getItemsBetweenDates(fromDate, toDate);

  List<dynamic> upcomingItems = new List();

  for (Map map in upcomingItemsMapList) {
    bloc.insertObjectIntoMap(map);
    if (map.containsKey('TID')) {
      upcomingItems.add(bloc.toTask(map));
    } else {
      upcomingItems.add(bloc.toArc(map));
    }
  }
  return upcomingItems;
}