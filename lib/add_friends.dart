import 'package:flutter/material.dart';
import 'firestore_helper.dart';
import 'package:flutter/cupertino.dart';

// REDUNDANT PAGE

class AddFriends extends StatefulWidget {
  @override
  _AddFriendsState createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {
  FireStoreFunctions fireStoreFunctions = FireStoreFunctions();
  String user;
  var returnedUser;

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
        },);
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
      },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Need to get rid of page", style: TextStyle(fontSize: 30),),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter friends username',
            ),
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
                addFriendDialogBox('Username ${returnedUser.username} Found', returnedUser);
              } else {
                print('User does not exist');
                customDialogBox('User does not exist');
              }
            },
          ),
//          MaterialButton(
//            child: Text('Send Friend Request'),
//            onPressed: () async {
//              var result = await fireStoreFunctions.addFriend(returnedUser);
//              if (result) {
//                print('Request sent');
//                customDialogBox('Request sent');
//              } else {
//                customDialogBox("Friend request has already been sent");
//                print("Friend request has already been sent");
//              }
//            },
//          ),
        ],
      ),
    );
  }
}
