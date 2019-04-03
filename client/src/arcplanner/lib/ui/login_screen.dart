/* 
 * Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 * team-CGKM
 * CS 298 - Software Devops; Spring 2019
 * 
 * File: login_screen.dart
*/

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
//import 'package:arcplanner/main.dart';

class LoginScreen extends StatefulWidget {
  final String title;

  LoginScreen({Key key, this.title}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  _LoginScreenState();

  String errorMessage = '';

  /*
   * 
  */
  void _sendLogin() async {
    try {
      Navigator.pushReplacementNamed(context, '/home');
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/ArcPlannerLogo.PNG',
                    height: (MediaQuery.of(context).size.height) * 0.35,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Username',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Password',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                minWidth: 120,
                height: 50,
                child: RaisedButton(
                  onPressed: _sendLogin,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                errorMessage,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Container(
          padding: EdgeInsets.all(2),
          child: AutoSizeText(
            'ArcPlanner v0.0.1\nDeveloped as part of CS 298 at WCSU in Spring 2019\nteam-CGKM\nMatthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton',
            style: TextStyle(
              color: Colors.white,
            ),
            maxFontSize: 24.0,
            minFontSize: 8.0,
            maxLines: 4,
          ),
        ),
      ),
    );
  }
}
