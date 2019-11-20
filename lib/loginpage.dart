import 'package:splitt/firestore_helper.dart';
import 'package:splitt/password_reset.dart';

import 'privacypolicypage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'homepage.dart';
import 'signuppage.dart';
import 'privacypolicypage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  FireStoreFunctions fireStoreFunctions = FireStoreFunctions();

  String email;
  String password;

//  Widget logoImage() {
//    return Image.asset(
//      'assets/images/logo.png',
//      height: 150,
//      width: 150,
//      colorBlendMode: BlendMode.colorDodge,
//    );
//  }

  Widget emailTextField() {
    return TextField(
      obscureText: false,
      style: TextStyle(
        fontSize: 20, color: Colors.white,
      ),
      decoration: InputDecoration(
          labelText: 'EMAIL', labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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

  Widget passwordTextField() {
    return TextField(
      obscureText: true,
      style: TextStyle(
        fontSize: 20, color: Colors.white,
      ),
      decoration: InputDecoration(
          labelText: 'PASSWORD', labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
              child: Icon(Icons.lock),
            ),
            padding: EdgeInsets.only(left: 30, right: 10),
          )),
      onChanged: (value) {
        password = value;
      },
    );
  }

  Widget loginButton() {
    return SizedBox(
      width: double.infinity,
      child: FlatButton(
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0),),),
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Colors.white, width: 2, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(0)),
        child: Text(
          'LOGIN',
          style: Theme.of(context).textTheme.button,
        ),
        onPressed: () async {
          bool result = await fireStoreFunctions.logIn(email, password);
          if(result){
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          } else {
            print("You have not verified your email");
          }

        },
      ),
    );
  }

  Widget forgotPassword() {
    return FlatButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PasswordReset(),),);
      },
      child: Text('Forgot Password', style: TextStyle(color: Colors.white)),
    );
  }

  Widget signUpButtonLoginPage() {
    return FlatButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpPage()),
        );
      },
      child: Text(
        'Don\'t have an account\? Sign Up',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        //color: Color(0xffE74C3C),
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50.0),
//            logoImage(),
            SizedBox(height: 50.0),
            emailTextField(),
            SizedBox(height: 10.0),
            passwordTextField(),
            SizedBox(height: 50.0),
            loginButton(),
            SizedBox(height: 20.0),
            forgotPassword(),
            SizedBox(height: 10.0),
            signUpButtonLoginPage(),
//              signUpButton(),
          ],
        ),
      ),
    );
  }
}

//
//Container(height: MediaQuery.of(context).size.height,
//
//padding: EdgeInsets.all(8.0),
//color: Color(0xff4a4a58),
//child: ListView(
//
//children: <Widget>[
//SizedBox(height: 50),
//Container(
//
//height: 100,
//width: 100,
//decoration: new BoxDecoration(
//
//shape: BoxShape.circle,
//image: new DecorationImage(
//fit: BoxFit.scaleDown,
//image: ExactAssetImage('assets/images/new.png'),
//),
//),
//),
//SizedBox(height: 30),
//Container(
//child: Center(
//child: Text(
//'Harith Wickramasigha',
//style: TextStyle(color: Colors.white, fontSize: 22),
//),
//),
//),
//SizedBox(height: 10),
//Container(
//child: Center(
//child: Text(
//'@harithsen',
//style: TextStyle(color: Colors.white, fontSize: 18),
//),
//),
//),
//Divider(
//thickness: 1,
//endIndent: 35,
//indent: 35,
//height: 50,
//color: Colors.white,
//),
//ListTile(
//leading: Icon(
//Icons.group_add,
//size: 30,
//color: Colors.white,
//),
//title: Text(
//'Create Group',
//style: TextStyle(fontSize: 18, color: Colors.white),
//),
//),
//ListTile(
//leading: Icon(
//Icons.group_add,
//size: 30,
//color: Colors.white,
//),
//title: Text(
//'Create Group',
//style: TextStyle(fontSize: 18, color: Colors.white),
//),
//),ListTile(
//leading: Icon(
//Icons.group_add,
//size: 30,
//color: Colors.white,
//),
//title: Text(
//'Create Group',
//style: TextStyle(fontSize: 18, color: Colors.white),
//),
//),Container(
//// This align moves the children to the bottom
//child: Align(
//alignment: FractionalOffset.bottomCenter,
//// This container holds all the children that will be aligned
//// on the bottom and should not scroll with the above ListView
//child: Container(
//child: Column(
//children: <Widget>[
//Divider(),
//ListTile(
//leading: Icon(Icons.settings),
//title: Text('Settings')),
//ListTile(
//leading: Icon(Icons.help),
//title: Text('Help and Feedback'))
//],
//)
//)
//)
//)