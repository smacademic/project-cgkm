/* 
 * Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 * team-CGKM
 * CS 298 - Software Devops; Spring 2019
 * 
 * File: drawer_menu.dart
 * 
 * Purpose:
 *  This file defines a single method 'drawerMenu' which builds the 
 *  side-menu for a number of the screens in the application. The 
 *  menu can be accessed by pulling from the left side of the screen.
*/

import 'package:flutter/material.dart';

Drawer drawerMenu(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget> [
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
          child: DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue[400],
            ),
          ),
        ),
        ListTile(
          title: Text(
            'Home',
              style: TextStyle(
                fontSize: 20.0,
              ),
          ),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
          },
        ),
        ListTile(
          title: Text(
            'Create New Task',
              style: TextStyle(
                fontSize: 20.0,
              ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text(
            'Create New Arc',
              style: TextStyle(
                fontSize: 20.0,
              ),
          ),
          onTap: () {
            Navigator.popAndPushNamed(context, '/addarc');       
          },
        ),
        ListTile(
          title: Text(
            'Arc View',
              style: TextStyle(
                fontSize: 20.0,
              ),
          ),
          onTap: () {
            Navigator.popAndPushNamed(context, '/arcview');
          },
        ),
        ListTile(
          title: Text(
            'Calendar View',
              style: TextStyle(
                fontSize: 20.0,
              ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text(
            'Archived Items',
              style: TextStyle(
                fontSize: 20.0,
              ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text(
            'Help',
              style: TextStyle(
                fontSize: 20.0,
              ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text(
            'About',
              style: TextStyle(
                fontSize: 20.0,
              ),
          ),
          onTap: () {
            Navigator.popAndPushNamed(context, '/about');
          },
        ),
        ListTile(
          title: Text(
            'Settings',
              style: TextStyle(
                fontSize: 20.0,
              ),
          ),
          onTap: () {
            Navigator.popAndPushNamed(context, '/settings');
          },
        ),
        // ListTile(
        //   title: Text(
        //     'Logout',
        //       style: TextStyle(
        //         fontSize: 20.0,
        //       ),
        //   ),
        //   onTap: () {
        //     Navigator.popAndPushNamed(context, '/login');
        //   },
        // ),
      ],
    )
  );
}