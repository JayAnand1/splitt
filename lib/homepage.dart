import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:splitt/add_friends.dart';
import 'package:splitt/add_transaction.dart';
import 'package:splitt/create_group.dart';
import 'package:splitt/my_friends.dart';
import 'package:splitt/my_groups.dart';
import 'package:splitt/notifications.dart';
import 'package:splitt/settings.dart';
import 'package:splitt/styling.dart';
import 'firestore_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'loginpage.dart';
import 'package:splitt/firestore_helper.dart';
import 'package:splitt/selected_group.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'notifications.dart';

//For Loading Animations -
//https://flutterawesome.com/a-collection-of-loading-indicators-animated-with-flutter/

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FireStoreFunctions fireStoreFunctions = FireStoreFunctions();
  final _auth = FirebaseAuth.instance;
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

  Widget groups() {
    return FutureBuilder(
      future: fireStoreFunctions.fetchMyGroups(),
      builder: (context, snapShot) {
        if (snapShot.data == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container(
            child: loadingAnimation,
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          primary: false,
//          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//              crossAxisCount: 1, childAspectRatio: 3),
          itemCount: snapShot.data.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.transparent,
              //color: Color(0xff0ABFBC),
              margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
              //elevation: 20,
              child: ListTile(
                //contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    snapShot.data[index].groupName,
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                leading: Image.asset('assets/images/new2.png'),
                subtitle: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Stack(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          //Positioned(child: ,),

                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://www.pngfind.com/pngs/m/488-4887957_facebook-teerasej-profile-ball-circle-circular-profile-picture.png"),
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://www.scripturaengage.com/wp-content/uploads/2017/03/Profile-Picture-Erik-Vanherck-Circle.png"),
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://www.scripturaengage.com/wp-content/uploads/2017/05/Profile-Picture-Pauline-Suy-circle-ScripturaEngage.png"),
                          ),
                        ],
                      ),

                      // Image.asset('assets/images/new2.png'),
                      // Image.asset('assets/images/new2.png'),
                    ],
                  ),
                ),

//                Text(
//                  snapShot.data[index].groupID,
//                  style: TextStyle(color: Colors.grey),
//                ),
                trailing: Container(
                  //color: Colors.yellow,
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Text(
                    '\$ 100.00',
                    style: TextStyle(fontSize: 20, color: Colors.greenAccent),
                  ),
                ),

                onTap: () async {
                  //push to new screen for specific group
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectedGroup(
                        selectedGroup: snapShot.data[index],
                      ),
                    ),
                  );
                },
//                subtitle: Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Text(
//                    '\@' + snapShot.data[index].groupID,
//                    style: TextStyle(fontSize: 16, color: Colors.black87),
//                  ),
//                ),
              ),
            );
          },
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
                SizedBox(height: 30),
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
                SizedBox(height: 30),
                //Container(
                Center(
                  child: Text(
                    'sdfsd',
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
                    if (returnedUser != false) {
                      //fix searchFriend func
                      print(returnedUser.email);
                      addFriendDialogBox(
                          'Username ${returnedUser.username} Found: ${returnedUser.firstName} ${returnedUser.lastName}',
                          returnedUser);
                    } else if (returnedUser == false) {
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
                        builder: (context) => MyFriends(),
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
                    ListTile(
                      leading: Icon(
                        Icons.exit_to_app,
                        size: 26,
                      ),
                      title: Text(
                        'Log Out',
                        style: TextStyle(fontSize: 16),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget topScrollableMenu() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                child: OutlineButton(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  borderSide: BorderSide(color: Colors.white),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(0)),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                        child: Icon(
                          Icons.person_add,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      Text(
                        'Add Friends',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  onPressed: _searchBarVisibility,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: Container(
                child: OutlineButton(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  borderSide: BorderSide(color: Colors.white),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(0)),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                        child: Icon(
                          Icons.group_add,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      Text(
                        'Create Group',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateGroup(),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: Container(
                child: OutlineButton(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  borderSide: BorderSide(color: Colors.white),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(0)),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                        child: Icon(
                          Icons.group,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      Text(
                        'My Friends',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyFriends(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget debitCredit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          child: Text(
            '+ \$1,400',
            style: TextStyle(
              fontSize: 26,
              color: Colors.greenAccent,
              //fontStyle: FontStyle.italic,
              fontFamily: 'Gisbon',
              letterSpacing: 3,
            ),
          ),
        ),
        Container(
          width: 1,
          height: 15,
          color: Colors.grey,
        ),
        Container(
          child: Text(
            '- \$400',
            style: TextStyle(
                fontSize: 26,
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontFamily: 'Gisbon',
                letterSpacing: 3),
          ),
        ),
      ],
    );
  }

  bool isAddFriendButtonPressed = false;

  void _searchBarVisibility() {
    setState(() {
      if (isAddFriendButtonPressed) {
        isAddFriendButtonPressed = false;
      } else {
        isAddFriendButtonPressed = true;
      }
    });
  }

  Widget hiddenSearchBar() {
    return Visibility(
      visible: isAddFriendButtonPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () async {
                returnedUser = await fireStoreFunctions.searchFriend(user);
                if (returnedUser != null) {
                  print(returnedUser.email);
                  addFriendDialogBox(
                      'Username ${returnedUser.username} Found [${returnedUser.firstName} ${returnedUser.lastName}]',
                      returnedUser);
                } else {
                  print('User does not exist');
                  customDialogBox('User does not exist');
                }
              },
            ),
//suffix: IconButton(icon: Icon(Icons.search),),
            labelText: 'Enter Friends Username',
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1,
              ),
            ),
          ),
          onChanged: (value) {
            user = value;
          },
        ),
      ),
    );
  }

  Widget netBalance() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Text(
                '+1,000',
                style: TextStyle(
                    fontSize: 65,
                    color: Colors.white,
                    fontFamily: 'deadpack',
                    letterSpacing: 5),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 55, 0, 0),
              child: Container(
                decoration: ShapeDecoration(
                  color: Color.fromRGBO(41, 167, 77, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: Text(
                  '\$',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: 'Ariel',
                      letterSpacing: 5),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.fromLTRB(32, 0, 0, 10),
              child: Text(
                'NET BALANCE',
                style: TextStyle(fontSize: 16, color: Colors.white),
              )),
        ),
        debitCredit(),
        Divider(
          color: Colors.white,
          thickness: 2,
          endIndent: 20,
          indent: 20,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Text(
              'My Groups',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
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
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: RawMaterialButton(

              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://www.skylightsearch.co.uk/wp-content/uploads/2017/01/Hadie-profile-pic-circle.png"),
              ),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Settings(),
                  ),
                );
              },
            ),
          ),
//          leading: IconButton(
//            icon: Icon(
//              Icons.account_circle,
//              size: 25,
//            ),
//            onPressed: () async {
//              Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => Settings(),
//                ),
//              );
//            },
//          ),
          //iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          title: Align(
            alignment: Alignment(0.3, 0),
            child: Text(
              'SPLITT',
              style: TextStyle(
                  fontFamily: 'deadpack',
                  color: Colors.white,
                  letterSpacing: 4,
                  fontSize: 30),
            ),
          ),
          actions: <Widget>[
            Stack(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.yellow,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Notifications(),
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Icon(
                    Icons.brightness_1,
                    color: Colors.red,
                    size: 10,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.sms,
                color: Colors.blue,
              ),
              onPressed: () {},
            ),
          ],
        ),
        drawer: appDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              topScrollableMenu(),
              hiddenSearchBar(),
              netBalance(),
              groups(),
            ],
          ),
        ),
      ),
    );
  }
}
