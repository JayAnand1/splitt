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
            Text(
              'Settings',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
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
              'If you have any feedback feel free to contact us.\n\nCopyright © 2019 Splitt.\nAll rights reserved.'),
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
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //getMyDetails(),
                customAppBar(),

                SizedBox(height: 40),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: new NetworkImage(
                            "https://www.scripturaengage.com/wp-content/uploads/2017/05/Profile-Picture-Pauline-Suy-circle-ScripturaEngage.png")),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(16, 30, 16, 8),
                  child: Text(
                    'Harith Wickramasingha',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                  child: Text(
                    '@harithsen',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                SizedBox(height: 30),

                Card(
                  color: Colors.transparent,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    dense: true,
                    title: Text(
                      'Default Currency',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    leading: Icon(Icons.monetization_on,
                        color: Colors.white, size: 25),
                    trailing: Icon(Icons.arrow_forward,
                        color: Colors.white, size: 25),
                  ),
                ),
                Card(
                  color: Colors.transparent,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    dense: true,
                    title: Text(
                      'Background Color',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    leading:
                        Icon(Icons.color_lens, color: Colors.white, size: 25),
                    trailing: Icon(Icons.arrow_forward,
                        color: Colors.white, size: 25),
                  ),
                ),
                Card(
                  color: Colors.transparent,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    dense: true,
                    title: Text(
                      'Remove Advertisements',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    leading: Icon(Icons.remove_circle_outline,
                        color: Colors.white, size: 25),
                    trailing: Icon(Icons.arrow_forward,
                        color: Colors.white, size: 25),
                  ),
                ),

                SizedBox(height: 40),
                SizedBox(
                  child: Text(
                    'V 1.001',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.help,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Help and Feedback',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () {helpDialogBox();},
                ),
                FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.exit_to_app,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Logout',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
