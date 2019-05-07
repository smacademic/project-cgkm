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
 *  This file contains ArcPlanner's main method which runs the application.
 */

import 'package:flutter/material.dart';
import 'src/arcplanner.dart';
import 'src/blocs/bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await bloc.initBloc();
  initializeDateFormatting().then((_) => runApp(ArcPlanner()));
}


