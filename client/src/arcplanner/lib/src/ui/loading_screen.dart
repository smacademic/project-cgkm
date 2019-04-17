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
 *  This file contains a splash screen of the ArcPlanner logo and is used to hide long load screens.
 */

import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/ArcPlannerLogo.PNG',
            width: (MediaQuery.of(context).size.width),
            fit: BoxFit.cover,
          ),
        ]
      ),
    );
  }
}