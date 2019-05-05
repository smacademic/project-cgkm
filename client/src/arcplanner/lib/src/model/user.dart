/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Jonathan Middleton
 *    Contributors: 
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file has the User class and associated functions
 */

import 'package:uuid/uuid.dart';

class User {
  // In flutter, underscore denotes private members
  String _uid;
  String _firstName;
  String _lastName;
  String _email;

  /// The default Constructor for Task object
  /// @param firstName the first name of the user
  /// @param lastName the Last name of the user
  /// @param email the email of the user
  User(this._firstName, this._lastName, this._email) {
    this._uid = new Uuid().v4();
  }

  // Getters
  String get uid => _uid;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;

  // Puts object data onto a user map
  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map["firstname"] =_firstName;
    map["lastname"] = _lastName;
    map["email"] =_email;

    if (uid != null) {
      map["uid"] = _uid;
    }
    return map;
  }
}