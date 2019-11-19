import 'package:flutter/material.dart';
import 'firestore_helper.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  String groupName;
  String groupDescription;

  List<Friend> friendList = List<Friend>();

  FireStoreFunctions fireStoreFunctions = FireStoreFunctions();

  Future<List<Friend>> getFriends() async {
    List<Friend> friendList = await fireStoreFunctions.getFriends();
    return friendList;
  }

  Widget friends() {
    return Expanded(
      child: FutureBuilder(
        future: getFriends(),
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
                onTap: () {
                  friendList.add(snapShot.data[index]);
                },
                title: Text(snapShot.data[index].email),
              );
            },
          );
        },
      ),
    );
  }

  Widget createGroupBody() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                groupName = value;
              },
              obscureText: false,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  labelText: 'Group name',
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 3,
                    ),
                  ),
                  prefixIcon: Padding(
                    child: IconTheme(
                      data:
                          IconThemeData(color: Theme.of(context).primaryColor),
                      child: Icon(Icons.account_circle),
                    ),
                    padding: EdgeInsets.only(left: 30, right: 10),
                  )),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                groupDescription = value;
              },
              obscureText: false,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 3,
                    ),
                  ),
                  prefixIcon: Padding(
                    child: IconTheme(
                      data:
                          IconThemeData(color: Theme.of(context).primaryColor),
                      child: Icon(Icons.account_circle),
                    ),
                    padding: EdgeInsets.only(left: 30, right: 10),
                  )),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            MaterialButton(
              child: Text("Save group"),
              onPressed: () async {
                await fireStoreFunctions.createGroup(groupName, groupDescription, friendList);
              },
            ),
            createGroupBody(),
            friends(),
          ],
        ),
      ),
    );
  }
}
