/** Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 Team CGKM 
 * 
 * Provided AS IS. No warranties expressed or implied. Use at your own risk.
 */

import 'package:flutter/material.dart';

class Arc extends StatelessWidget{
  //in flutter, underscrore denotes private members
  String _aid;
  String _uid;
  String _title;
  String _description;
  String _parentArc;

  //constructor
  Arc(this._aid, this._uid, this._title, this._description, this._parentArc);

  // Defines a user map.  Helps with moving info betwen the db
  //   and the app
  Arc.map(dynamic obj){
    _aid = obj["aid"];
    _uid = obj["uid"];
    _title = obj["title"];
    _description = obj["description"];
    _parentArc = obj["parentarc"];
  }

  //getters
  String get aid => _aid;
  String get uid => _uid;
  String get title => _title;
  String get description => _description;
  String get parentarc => _parentArc;

  // Puts object data onto a user map
  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map["uid"] = _uid;
    map["title"] = _title;
    map["description"] =_description;
    map["parentarc"] =_parentArc;

    if (aid != null) {
      map["aid"] = _aid;
    }
    return map;
  }

  // Puts user map data into a user object
  Arc.fromMap(Map<String, dynamic> map)
  {
    _aid = map["aid"];
    _uid = map["uid"];
    _title = map["title"];
    _description = map["description"];
    _parentArc = map["parentarc"];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}