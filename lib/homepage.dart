import 'package:flutter/material.dart';
import 'package:splitt/add_friends.dart';
import 'package:splitt/add_transaction.dart';
import 'package:splitt/create_group.dart';
import 'package:splitt/my_groups.dart';
import 'package:splitt/settings.dart';
import 'firestore_helper.dart';
import 'FriendRequests.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FireStoreFunctions fireStoreFunctions = FireStoreFunctions();
  String user;
  var returnedUser;

  Future<List<Friend>> getFriendRequests() async {
    List<Friend> friendList = await fireStoreFunctions.getFriendRequests();
    return friendList;
  }

  Widget friendRequests() {
    return FutureBuilder(
      future: getFriendRequests(),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.none &&
            snapShot.hasData == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container(
            child: Text('Loading'),
          );
        }
        return ListView.builder(
          itemCount: snapShot.data.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
//              fireStoreFunctions.confirmRequest(snapShot.data[index]);
              },
              title: Text(snapShot.data[index].email),
            );
          },
        );
      },
    );
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

  void addFriendDialogBox(String dialogMessage, var returnedUser) {
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
            FlatButton(
              onPressed: () async {
                var result = await fireStoreFunctions.addFriend(returnedUser);
                if (result) {
                  print('Request sent');
                  customDialogBox('Request sent');
                } else {
                  customDialogBox("Friend request has already been sent");
                  print("Friend request has already been sent");
                }
              },
              child: Text('Add Friend'),
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

  Widget appDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(height: 50),
                Container(
                  height: 100,
                  width: 100,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.scaleDown,
                      image: ExactAssetImage('assets/images/new.png'),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                //Container(
                Center(
                  child: Text(
                    'F.name L.name',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Center(
                    child: Text(
                      '@username',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: TextField(
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        hintText: 'Search for friends Username',
                        hintStyle: TextStyle(color: Colors.black87)),
                    onChanged: (value) {
                      user = value;
                    },
                  ),
                ),
                MaterialButton(
                  child: Text('Search User'),
                  onPressed: () async {
                    returnedUser = await fireStoreFunctions.searchFriend(user);
                    if (returnedUser != null) { //fix searchFriend func
                      print(returnedUser.email);
                      addFriendDialogBox(
                          'Username ${returnedUser.username} Found',
                          returnedUser);
                    } else {
                      print('User does not exist');
                      customDialogBox('User does not exist');
                    }
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.person_add,
                    size: 30,
                  ),
                  title: Text(
                    'Add Friends',
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddFriends(),
                      ),
                    );
                  },
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FriendRequests(),
                      ),
                    );
                  },
                  leading: Icon(
                    Icons.person,
                    size: 30,
                  ),
                  title: Text(
                    'My Friends',
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateGroup(),
                      ),
                    );
                  },
                  leading: Icon(
                    Icons.group_add,
                    size: 30,
                  ),
                  title: Text(
                    'Create Group',
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyGroups(),
                      ),
                    );
                  },
                  leading: Icon(
                    Icons.group,
                    size: 30,
                  ),
                  title: Text(
                    'My Groups',
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ],
            ),
          ),
          // This container holds the align
          Container(
              // This align moves the children to the bottom
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  // This container holds all the children that will be aligned
                  // on the bottom and should not scroll with the above ListView
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      Divider(),
                      ListTile(
                        leading: Icon(
                          Icons.settings,
                          size: 26,
                        ),
                        title: Text(
                          'Settings',
                          style: TextStyle(fontSize: 16),
                        ),
                        onTap: () async {
                          //Friend myProfile = await fireStoreFunctions.myDetails();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Settings(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.help,
                          size: 26,
                        ),
                        title: Text(
                          'Help and Feedback',
                          style: TextStyle(fontSize: 16),
                        ),
                        onTap: () {
                          helpDialogBox();
                        },
                      ),
                    ],
                  ))))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    bool isPressed = false;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4a4a58),

        title: Center(
          child: Text(
            'asdsadad',
            style: TextStyle(color: Colors.white),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: appDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 200),
            SizedBox(height: 10.0),
            MaterialButton(color: (isPressed) ? Colors.black87 : Colors.yellow,

              child: Text('Test My profile'),
              onPressed: () async {
                Friend myProfile = await fireStoreFunctions.myDetails();
                customDialogBox(
                    'F Name: ${myProfile.firstName}\n L Name: ${myProfile.lastName}\nEmail: ${myProfile.email}\n Username: ${myProfile.username}\n');

                print(myProfile.email);
              },
            ),
            SizedBox(height: 10.0),
            Center(
                child: Text(
              'swipe right on the screen',
              style: TextStyle(fontSize: 20),
            )),
            SizedBox(height: 20.0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 20,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTransaction(),
            ),
          );
        },
      ),
    );
  }
}
