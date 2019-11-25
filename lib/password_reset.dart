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
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: TextField(
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
      ),
    );
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Widget resetPasswordButton() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
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
      ),
    );
  }

  Widget customAppBarSignUpPage() {
    return Container(
      decoration: BoxDecoration(
          //border: Border.all(width: 0, color: Colors.white),
          //color: Colors.white,
          ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FlatButton(
              child: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16,0, 16, 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.9],
          colors: [
            Color(0xff485563),
            Color(0xff29323c),
          ],
        ),
      ),
      child: Scaffold(
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            customAppBarSignUpPage(),
            SizedBox(height: 0),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: Text(
                'Reset Password',
                style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 120),
            resetEmailTextField(),
            SizedBox(height: 40),
            resetPasswordButton(),
          ],
        ),
      ),
    );
  }
}
