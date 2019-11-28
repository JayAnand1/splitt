import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:splitt/styling.dart';
import 'firestore_helper.dart';
import 'add_friends.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  FireStoreFunctions fireStoreFunctions = FireStoreFunctions();

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
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Notifications',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget friendRequests() {
    return FutureBuilder(
      future: fireStoreFunctions.getFriendRequests(),
      builder: (context, snapShot) {
        if (snapShot.data == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container(
            child: loadingAnimation,
          );
        }
        return Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapShot.data.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
                color: Colors.transparent,
                //elevation: 20,
                child: ListTile(
                  contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                  //trailing: Icon(Icons.delete_outline),
                  leading: Image.asset('assets/images/new2.png'),
                  title: Text(
                    '${snapShot.data[index].firstName} ${snapShot.data[index].lastName}',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  isThreeLine: true,
                  dense: true,
                  subtitle: Text('Sent you a friend request', style: TextStyle(fontSize: 16, color: Colors.grey),),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      await fireStoreFunctions
                          .confirmRequest(snapShot.data[index]);
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
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
        body: Column(
          children: <Widget>[
            customAppBar(),
            friendRequests(),
          ],
        ),
      ),
    );
  }
}
