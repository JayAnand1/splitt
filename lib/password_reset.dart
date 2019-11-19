import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'firestore_helper.dart';

class PasswordReset extends StatefulWidget {
  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final _auth = FirebaseAuth.instance;
  String email;

  @override
  Widget resetEmailTextField() {
    return TextField(
      obscureText: false,
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
      decoration: InputDecoration(
          labelText: 'EMAIL',
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 3,
            ),
          ),
          prefixIcon: Padding(
            child: IconTheme(
              data: IconThemeData(color: Theme.of(context).primaryColor),
              child: Icon(Icons.email),
            ),
            padding: EdgeInsets.only(left: 30, right: 10),
          )),
      onChanged: (value) {
        email = value;
      },
    );
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Widget resetPasswordButton() {
    return SizedBox(
      width: double.infinity,
      child: FlatButton(
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0),),),
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Colors.white, width: 2, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(0)),
        child: Text(
          'RESET PASSWORD',
          style: Theme.of(context).textTheme.button,
        ),
        onPressed: () async {
          resetPassword(email);
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter email address to resent your password bla bla\n'),
            SizedBox(height: 40),
            resetEmailTextField(),
            SizedBox(height: 40),
            resetPasswordButton(),
          ],
        ),
      ),
    );
  }
}
