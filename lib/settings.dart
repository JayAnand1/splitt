import 'package:flutter/material.dart';
import 'firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  FireStoreFunctions fireStoreFunctions = FireStoreFunctions();

  getMyDetails() async {
    Friend myProfile = await fireStoreFunctions.myDetails();
    return myProfile;
  }

  Widget customAppBar() {
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
          body: Column(
            children: <Widget>[
              customAppBar(),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 40),
                    Container(
                      height: 150,
                      width: 150,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: ExactAssetImage('assets/images/new.png'),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    //Container(
                    Center(
                      child: Text(
                        'F.Name L.Name',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Center(
                        child: Text(
                          '@username',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.person_add,
                        size: 30,
                      ),
                      title: Text(
                        'asdsad',
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.person_add,
                        size: 30,
                      ),
                      title: Text(
                        'qwdqwdq',
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.person_add,
                        size: 30,
                      ),
                      title: Text(
                        'wqdqwdqw',
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.group_add,
                        size: 30,
                      ),
                      title: Text(
                        'qwdqwdwqd',
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
