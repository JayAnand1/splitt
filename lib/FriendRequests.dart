import 'package:flutter/material.dart';
import 'firestore_helper.dart';
import 'add_friends.dart';

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
            return Card(
              elevation: 20,
              child: ListTile(

                //trailing: Icon(Icons.delete_outline),
                leading: Image.asset('assets/images/new2.png'),
                onTap: () async {
                  await fireStoreFunctions.confirmRequest(snapShot.data[index]);
                },
                title: Text(
                  snapShot.data[index].firstName + ' ' + snapShot.data[index].lastName,
                  style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '\@' + snapShot.data[index].username,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget addNewFriendsButton() {
    return SizedBox(
      width: double.infinity,
      child: FlatButton(
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0),),),
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Colors.white, width: 2, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(0)),
        child: Text(
          'Add New Friends',
          style: Theme.of(context).textTheme.button,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFriends(),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Friends'),
      ),
      body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Expanded(child: friendRequests()),
              addNewFriendsButton(),
            ],
          )),
    );
  }
}
