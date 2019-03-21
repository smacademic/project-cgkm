/** Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 Team CGKM 
 * 
 * Provided AS IS. No warranties expressed or implied. Use at your own risk.
 */

import 'package:flutter/material.dart';

class User extends StatelessWidget{
  //in flutter, underscrore denotes private members
  String _uid;
  String _firstName;
  String _lastName;
  String _email;

  //constructor
  User(this._firstName, this._lastName, this._email);

  // Defines a user map.  Helps with moving info betwen the db
  //   and the app
  User.map(dynamic obj){
    this._uid = obj["uid"];
    this._firstName = obj["firstname"];
    this._lastName = obj["lastname"];
    this._email = obj["email"];
  }

  //getters
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

    if (_uid != null) {
      map["uid"] = _uid;
    }
  }

  // Puts user map data into a user object
  User.fromMap(Map<String, dynamic> map)
  {
    this._uid = map["uid"];
    this._firstName = map["firstname"];
    this._lastName = map["lastname"];
    this._email = map["email"];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}