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
import 'package:intl/intl.dart';

Map<String, List<String>> loadedDates = Map<String, List<String>>();
var formatter = new DateFormat('yyyy-MM-dd');

/// Retrieves all Arcs and Tasks inclusively between the given two dates
/// @param fromDate Represents the starting date of range of dates to be searched
/// @param toDate Represents the ending date of range of dates to be searched
/// @returns a future list of Arcs and Tasks from the data. This inherently will
///   result in maps of these objects
Future<List<dynamic>> getItemsBetweenDates(String fromDate, String toDate) async {
  List<dynamic> upcomingItems = new List();
  
  if (checkIfDateRangeInMap(fromDate, toDate)) {
    DateTime date = DateTime.parse(fromDate);
    DateTime dayAfterEndDate = (DateTime.parse(toDate)).add(Duration(days:1));
    while (date.isBefore(dayAfterEndDate)) {
      List<String> uuids = loadedDates[formatter.format(date)];
      for (String uuid in uuids) {
        upcomingItems.add(bloc.getFromMap(uuid));
      }
    }
  } else {
    List<Map> upcomingItemsMapList = await bloc.db.getItemsBetweenDates(fromDate, toDate);

    for (Map map in upcomingItemsMapList) {
      bloc.insertObjectIntoMap(map);
      addToLoadedDates(map);
      if (map.containsKey('TID')) {
        upcomingItems.add(bloc.toTask(map));
      } else {
        upcomingItems.add(bloc.toArc(map));
      }
    }
  }
  return upcomingItems;
}

/// Checks to see if all dates are within the date range
/// @param fromDate Represents the starting date of range of dates to be searched
/// @param toDate Represents the ending date of range of dates to be searched
/// @returns whether all dates exist in map. If at least 1 date is missing it 
///   will return false
bool checkIfDateRangeInMap(String fromDate, String toDate) {
  DateTime date = DateTime.parse(fromDate);
  DateTime dayAfterEndDate = (DateTime.parse(toDate)).add(Duration(days:1));
  bool dateMissingInMap = false;
  while (date.isBefore(dayAfterEndDate)) {
    if (!loadedDates.containsKey(formatter.format(date))) {
      dateMissingInMap = true;
      break;
    }
    date.add(Duration(days:1));
  }
  
  if (dateMissingInMap)
    return false;
  else
    return true;
}

/// Adds map to the `loadedDates` object 
/// @param map A map containing DueDate and the UUID of the object 
void addToLoadedDates(Map map) {
  if (loadedDates.containsKey(map['DueDate'])) {
    if (map.containsKey('TID')) {
      loadedDates.update(map['DueDate'], (dynamic listValue) => new List.from(listValue)..add(map['TID']));  //listValue.add(map['TID']));
    } else {
      loadedDates.update(map['DueDate'], (dynamic listValue) => new List.from(listValue)..add(map['AID']));
    }
  } else {
    if (map.containsKey('TID')) {
      loadedDates[map['DueDate']] = [map['TID']];
    } else {
      loadedDates[map['DueDate']] = [map['AID']];
    }
  }
}