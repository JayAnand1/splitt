import 'package:flutter/material.dart';
import 'package:splitt/password_reset.dart';

import 'loginpage.dart';
import 'homepage.dart';
import 'signuppage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense',
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        primaryIconTheme: IconThemeData(color: Colors.white,),
        accentIconTheme: IconThemeData(color: Colors.white,),
        cardColor: Colors.white,
        primaryColor: Colors.white,
        accentColor: Colors.white,
        buttonColor: Colors.white,
          //0xffE74C3C
        scaffoldBackgroundColor: Colors.transparent,
        hintColor: Colors.white,
        textSelectionColor: Colors.white,
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          button: TextStyle(
              fontSize: 20.0, fontFamily: 'Hind', color: Colors.white),
        ),
        buttonTheme: ButtonThemeData(padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          buttonColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0),),
          ),
          height: 45,
        ),
      ),
      home: LoginPage(),
    );
  }
}
