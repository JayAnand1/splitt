import 'package:flutter/material.dart';
import 'firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
//  Group userDetails;
//
//  Settings({this.userDetails});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  FireStoreFunctions fireStoreFunctions = FireStoreFunctions();

  getMyDetails() async {
    Friend myProfile = await fireStoreFunctions.myDetails();
    return myProfile;
  }

  void customDialogBox(String dialogMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(dialogMessage),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget customAppBar() {
    return Container(
      decoration: BoxDecoration(
          //border: Border.all(width: 0, color: Colors.white),
          //color: Colors.white,
          ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FlatButton(
              child: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Icon(Icons.info_outline, color: Colors.white, size: 30),
              onPressed: () {
                customDialogBox(
                    'Copyright © 2019 Splitt.\nAll rights reserved.');
              },
            ),
          ],
        ),
      ),
    );
  }

  void helpDialogBox() {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
              'If you have any feedback feel free to contact us.\n\nCopyright © 2019 Quick Notes.\nAll rights reserved.'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
            FlatButton(
              child: Text('Contact Us'),
              onPressed: () {
                _sendEmail();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _sendEmail() async {
    final String _email =
        'mailto:anandwick@gmail.com?subject=App Feedback&body=If you have any issues with the app, please make sure to let us know your phone and app version';
    try {
      await launch(_email);
    } catch (e) {
      throw 'Could not reach email client';
    }
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
        //appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //getMyDetails(),
              customAppBar(),
              Container(
                height: 190,
                width: 190,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image:
                          new NetworkImage("https://i.imgur.com/BoN9kdC.png")),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Harith Wickramasingha',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                child: Text(
                  '@harithsen',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
              Divider(
                color: Colors.white,
                thickness: 1,
                endIndent: 30,
                indent: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Default Currency',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Background Color',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'CURRENCY',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Remove Advertisements',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                child: Text(
                  'V 1.001',
                  style: Theme.of(context).textTheme.button,
                ),
              ),
              FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.help,
                      size: 26,
                      color: Colors.white,
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Help and Feedback',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ],
                ),
                onPressed: () {helpDialogBox();},
              ),
              FlatButton(
                //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0),),),
//                  shape: RoundedRectangleBorder(
//                    side: BorderSide(
//                        color: Colors.white, width: 2, style: BorderStyle.solid),
//                    borderRadius: BorderRadius.circular(0),
//                  ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.exit_to_app,
                      size: 26,
                      color: Colors.white,
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Logout',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
