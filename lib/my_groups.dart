import 'package:flutter/material.dart';
import 'package:splitt/firestore_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:splitt/selected_group.dart';


class MyGroups extends StatefulWidget {
  @override
  _MyGroupsState createState() => _MyGroupsState();
}

class _MyGroupsState extends State<MyGroups> {
  Widget groups() {
    return FutureBuilder(
      future: fireStoreFunctions.fetchMyGroups(),
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
                  //push to new screen for specific group
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SelectedGroup(selectedGroup: snapShot.data[index],)));
                },
                title: Text(
                  snapShot.data[index].groupName,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '\@' + snapShot.data[index].groupID,
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

  FireStoreFunctions fireStoreFunctions = FireStoreFunctions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: groups(),
    );
  }
}
