import 'package:flutter/material.dart';
import 'firestore_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

  void creatGroupDialogBox() {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Group created successfully'),
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

  Widget friends() {
    bool _isPressed = true;

    return Expanded(
      child: FutureBuilder(
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
          return ListView.builder(
            itemCount: snapShot.data.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(8.0),
                elevation: 20,
                child: ListTile(
                  leading: Image.asset('assets/images/new2.png'),
                  trailing: FlatButton(
                    child: Icon(Icons.add),
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
          );
        },
      ),
    );
  }

  Widget createGroupBody() {
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
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
              maxLength: 20,
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
            SizedBox(height: 5),
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
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text(
                  'Add Friends To Group',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createGroupButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: FlatButton(
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0),),),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Colors.white, width: 2, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(0)),
          child: Text(
            'CREATE GROUP',
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () async {
            await fireStoreFunctions.createGroup(
                groupName, groupDescription, friendList);
            creatGroupDialogBox();
          },
        ),
      ),
    );
  }

  Widget customAppBar() {
    return Container(
      decoration: BoxDecoration(
          //border: Border.all(width: 0, color: Colors.white),
          //color: Colors.white,
          ),
      child: SafeArea(
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.start,
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
                'Create Group',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            )
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
        resizeToAvoidBottomPadding: false,
//        appBar: AppBar(
//          title: Text('Create Group'),
//        ),
        body: Column(
          children: <Widget>[
            customAppBar(),
            createGroupBody(),
            friends(),
            createGroupButton(),
          ],
        ),
      ),
    );
  }
}
