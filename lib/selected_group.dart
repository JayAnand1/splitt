import 'package:flutter/material.dart';
import 'firestore_helper.dart';
import 'add_transaction.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SelectedGroup extends StatefulWidget {
  Group selectedGroup;

  SelectedGroup({this.selectedGroup});

  @override
  _SelectedGroupState createState() => _SelectedGroupState();
}

class _SelectedGroupState extends State<SelectedGroup> {
  List<GroupUser> users = List<GroupUser>();

  FireStoreFunctions fireStoreFunctions = FireStoreFunctions();

  Future getGroupUsers() async {
    users =
        await fireStoreFunctions.getGroupUsers(widget.selectedGroup.groupID);
  }

  Widget groupUsers() {
    getGroupUsers();
    return FutureBuilder(
      future: fireStoreFunctions.getGroupUsers(widget.selectedGroup.groupID),
      builder: (context, snapShot) {
        if (snapShot.data == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container(
            child:  SpinKitThreeBounce(
              color: Colors.white,
              size: 20.0,
            ),
          );
        }
        return ListView.builder(
          itemCount: snapShot.data.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.red,
              elevation: 20,
              child: ListTile(
                onTap: () {
//              fireStoreFunctions.confirmRequest(snapShot.data[index]);
                },
                trailing: Text(
                  '\$ 100',
                  style: TextStyle(fontSize: 30, color: Colors.greenAccent),
                ),
                leading: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 40,
                ),
                title: Text(snapShot.data[index].fullName),
                subtitle: Text(snapShot.data[index].username),
              ),
            );
          },
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
        appBar: AppBar(
          title: Text('Group: ${widget.selectedGroup.groupName}'),
        ),
        body: groupUsers(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTransaction(selectedGroup: users),
              ),
            );
          },
        ),
      ),
    );
  }
}
