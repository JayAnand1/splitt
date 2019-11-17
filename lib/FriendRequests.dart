import 'package:flutter/material.dart';
import 'firestore_helper.dart';

class FriendRequests extends StatefulWidget {
  @override
  _FriendRequestsState createState() => _FriendRequestsState();
}

class _FriendRequestsState extends State<FriendRequests> {
  FireStoreFunctions fireStoreFunctions = FireStoreFunctions();

  Widget friendRequests() {
    return FutureBuilder(
      future: fireStoreFunctions.getFriendRequests(),
      builder: (context, snapShot) {
        if (snapShot.data == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container(
            child: Text('Loading'),
          );
        }
        return ListView.builder(
          itemCount: snapShot.data.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () async {
                await fireStoreFunctions.confirmRequest(snapShot.data[index]);
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
      body: friendRequests(),
    );
  }
}
