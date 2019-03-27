/** Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 Team CGKM 
 * 
 * Provided AS IS. No warranties expressed or implied. Use at your own risk.
 */

import 'package:uuid/uuid.dart';

class User {
  // In flutter, underscore denotes private members
  String _uid;
  String _firstName;
  String _lastName;
  String _email;

  // Constructor
  User(this._firstName, this._lastName, this._email) {
    this._uid = new Uuid().v4();
  }

  // Defines a user map.  Helps with moving info between the db
  //   and the app
  User.map(dynamic obj){
    _uid = obj["uid"];
    _firstName = obj["firstname"];
    _lastName = obj["lastname"];
    _email = obj["email"];
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

  // Puts user map data into a user object
  User.fromMap(Map<String, dynamic> map)
  {
    _uid = map["uid"];
    _firstName = map["firstname"];
    _lastName = map["lastname"];
    _email = map["email"];
  }
}