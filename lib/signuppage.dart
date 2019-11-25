import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:splitt/firestore_helper.dart';
import 'privacypolicypage.dart';
import 'loginpage.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String username;
  String password;
  String email;
  String firstName;
  String lastName;

  FireStoreFunctions fireStoreFunctions = FireStoreFunctions();

  Widget customAppBarSignUpPage() {
    return Container(
      decoration: BoxDecoration(
        //border: Border.all(width: 0, color: Colors.white),
        //color: Colors.white,
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
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

  Widget signUpHeading() {
    return Container(
//        decoration: BoxDecoration(
//          //border: Border.all(width: 0, color: Colors.white),
//          //color: Colors.white,
//          borderRadius: BorderRadius.only(
//            bottomLeft: const Radius.circular(40.0),
//            bottomRight: const Radius.circular(40.0),
//          ),
//        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: Text(
              'Sign Up ',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ));
  }

  Widget signUpPageBody() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                firstName = value;
              },
              obscureText: false,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  labelText: 'First name',
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                      data:
                          IconThemeData(color: Theme.of(context).primaryColor),
                      child: Icon(Icons.account_circle),
                    ),
                    padding: EdgeInsets.only(left: 30, right: 10),
                  )),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                lastName = value;
              },
              obscureText: false,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                      data:
                          IconThemeData(color: Theme.of(context).primaryColor),
                      child: Icon(Icons.account_circle),
                    ),
                    padding: EdgeInsets.only(left: 30, right: 10),
                  )),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                username = value;
              },
              obscureText: false,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  labelText: 'USERNAME',
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                      data:
                          IconThemeData(color: Theme.of(context).primaryColor),
                      child: Icon(Icons.account_circle),
                    ),
                    padding: EdgeInsets.only(left: 30, right: 10),
                  )),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                email = value;
              },
              obscureText: false,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  labelText: 'EMAIL',
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                      data:
                          IconThemeData(color: Theme.of(context).primaryColor),
                      child: Icon(Icons.email),
                    ),
                    padding: EdgeInsets.only(left: 30, right: 10),
                  )),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                password = value;
              },
              obscureText: true,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  labelText: 'PASSWORD',
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                      data:
                          IconThemeData(color: Theme.of(context).primaryColor),
                      child: Icon(Icons.email),
                    ),
                    padding: EdgeInsets.only(left: 30, right: 10),
                  )),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget signUpButtonSignUpPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: FlatButton(
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0),),),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Colors.white, width: 2, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(0)),
          child: Text(
            'SIGNUP',
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () async {
            var check = await fireStoreFunctions.createUser(
                firstName, lastName, username, email, password);
            if (!check) {
              print('--------------username exists');
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Please verfiy email"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Ok'),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    );
                  });
            }
          },
        ),
      ),
    );
  }

  Widget privacyPolicy() {
    return FlatButton(
        child: Text(
          'PRIVACY POLICY',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PrivacyPolicyPage()));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        //resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              customAppBarSignUpPage(),
              signUpHeading(),
              SizedBox(height: 50),
              signUpPageBody(),
              signUpButtonSignUpPage(),
              SizedBox(height: 20),
              privacyPolicy(),
            ],
          ),
        ),
      ),
    );
  }
}
