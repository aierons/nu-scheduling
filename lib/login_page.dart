import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:layout/services/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email, password;
  String error = '';
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 10.0,
        title: Text('Login Authentication'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        // child: RaisedButton(
        //   child: Text('Sign in anonyn'),
        //   onPressed: () async {
        //     dynamic result = await _auth.loginAnon();
        //     if (result == null) {
        //       print('error signing in');
        //     } else {
        //       print('signed in with uid: ' + result.uid);
        //     }
        //   },
        // ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                onChanged: (input) {
                  setState(() => email = input);
                },
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Enter an email';
                    // } else if (!input.contains('@northeastern.edu') ||
                    //     !input.contains('@husky.neu.edu')) {
                    //   return 'Enter a Northeastern email';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink, width: 2)),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (input) {
                  setState(() => password = input);
                },
                validator: (input) =>
                    input.length < 6 ? 'Enter your password' : null,
                //onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  hintText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink, width: 2)),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text('Log In', style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result =
                          await _auth.loginNortheastern(email, password);
                      if (result == null) {
                        setState(() {
                          error =
                              'Could not log in with provided Northeastern credentials';
                        });
                      }
                    }
                  }),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
