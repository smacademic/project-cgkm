/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Matthew Chastain
 *    Contributors: 
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file contains the generic tile Widget present in many screens in the 
 *  application. It can be used to build either Arc Tiles or Task Tiles.
 */

import 'package:flutter/material.dart';
import '../model/arc.dart';
import '../model/task.dart';
import '../ui/arc_tile.dart';
import '../ui/task_tile.dart';

/// Build method for the tile object
/// @param obj Arc or Task to build
/// @param context BuildContext for tile object
Widget tile(dynamic obj, BuildContext context) {
  if (obj is Arc) {
    return arcTile(obj, context);
  } else if (obj is Task) {
    return taskTile(obj, context);
  } else {
    return Text('tile tried to build not an Arc or Task');
  }
}