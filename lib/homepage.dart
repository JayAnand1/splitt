import 'package:flutter/material.dart';
import 'firestore_helper.dart';
import 'FriendRequests.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 200),
            TextField(
              onChanged: (value) {
                user = value;
              },
            ),
            MaterialButton(
              child: Text('Search User'),
              onPressed: () async {
                returnedUser = await fireStoreFunctions.searchFriend(user);
                if (returnedUser != false) {
                  print(returnedUser.email);
                } else {
                  print('User does not exist');
                }
              },
            ),
            SizedBox(height: 10.0),
            MaterialButton(
              child: Text('My profile'),
              onPressed: () async {
                Friend myProfile = await fireStoreFunctions.myDetails();
                print(myProfile.email);
              },
            ),
            SizedBox(height: 10.0),
            MaterialButton(
              child: Text('Send Friend Request'),
              onPressed: () async {
                var result = await fireStoreFunctions.addFriend(returnedUser);
                if (result) {
                  print("Request sent");
                } else {
                  print("Friend request has already been sent");
                }
              },
            ),
            SizedBox(height: 10.0),
            MaterialButton(
              child: Text('Get friend list'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FriendRequests()));
//                var friends = await fireStoreFunctions.getFriendRequests();
//                print(friends[0].username);
              },
            ),
            SizedBox(height: 2000),
            Text('asdasd')
          ],
        ),
      ),
    );
  }
}
