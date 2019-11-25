import 'package:flutter/material.dart';
import 'firestore_helper.dart';
import 'add_friends.dart';
import 'package:splitt/FriendRequests.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FriendRequests extends StatefulWidget {
  @override
  _FriendRequestsState createState() => _FriendRequestsState();
}

class _FriendRequestsState extends State<FriendRequests> {
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
            child: SpinKitThreeBounce(
              color: Colors.white,
              size: 20.0,
            ),
          );
        }
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,

            shrinkWrap: true,
            itemCount: snapShot.data.length,
            itemBuilder: (context, index) {
              return Card(

                elevation: 20,
                child: ListTile(

                  //trailing: Icon(Icons.delete_outline),
                  leading: Image.asset('assets/images/new2.png'),
                  onTap: () async {
                    await fireStoreFunctions
                        .confirmRequest(snapShot.data[index]);
                  },
                  title: Text(
                    snapShot.data[index].firstName +
                        ' ' +
                        snapShot.data[index].lastName,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
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
          ),
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

  List<Friend> friendList = List<Friend>();

  Future<List<Friend>> getFriends() async {
    List<Friend> friendList = await fireStoreFunctions.getFriends();
    return friendList;
  }

  Widget myFriends() {
    bool _isPressed = true;

    return FutureBuilder(
      future: getFriends(),
      builder: (context, snapShot) {
        if (snapShot.data == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container(
            child: SpinKitThreeBounce(
              color: Colors.white,
              size: 20.0,
            ),
          );
        }
        return Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapShot.data.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(8.0),
                elevation: 20,
                child: ListTile(
                  leading: Image.asset('assets/images/new2.png'),
                  trailing: FlatButton(
                    child: Icon(
                      Icons.add,
                      size: 30,
                      //color: (_isPressed) ? Color(0xff007397) : Colors.red,
                    ),
                    onPressed: () {
                      friendList.add(snapShot.data[index]);
//                      setState(() {
//                        _isPressed = true;
//                      });
                    },
                  ),
                  title: Text(
                    snapShot.data[index].firstName +
                        ' ' +
                        snapShot.data[index].lastName,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '\@' + snapShot.data[index].username,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                  onTap: () {
                    //friendList.add(snapShot.data[index]);
                  },
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
        resizeToAvoidBottomInset: true,
//        appBar: AppBar(
//          title: Text('My Friends'),
//        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            customAppBar(),
            Container(
              //height: MediaQuery.of(context).size.height,
              alignment: Alignment.centerLeft,
              child: Text(
                'Friends',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
            myFriends(),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Friends Requests',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
            friendRequests(),
            //addNewFriendsButton(),
          ],
        ),
      ),
    );
  }
}
