import 'package:flutter/material.dart';
import 'firestore_helper.dart';
import 'add_transaction.dart';


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
    users = await fireStoreFunctions.getGroupUsers(widget.selectedGroup.groupID);
  }


  Widget groupUsers() {
    getGroupUsers();
    return FutureBuilder(
      future: fireStoreFunctions.getGroupUsers(widget.selectedGroup.groupID),
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
//              fireStoreFunctions.confirmRequest(snapShot.data[index]);
              },
              title: Text(snapShot.data[index].fullName),

            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.selectedGroup.groupName),),
      body: groupUsers(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTransaction(selectedGroup: users )));
        },
      ),
    );
  }
}
