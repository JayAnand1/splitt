import 'package:flutter/material.dart';
import 'package:splitt/settled_transactions.dart';
import 'package:splitt/styling.dart';
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

  Widget groupDebitCredit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          child: Text(
            '+ \$600',
            style: TextStyle(
              fontSize: 20,
              color: Colors.greenAccent,
              fontStyle: FontStyle.italic,
              fontFamily: 'Gisbon',
              letterSpacing: 3,
            ),
          ),
        ),
        Container(
          width: 1,
          height: 15,
          color: Colors.grey,
        ),
        Container(
          child: Text(
            '- \$400',
            style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontFamily: 'Gisbon',
                letterSpacing: 3),
          ),
        ),
      ],
    );
  }

  Widget groupNetBalance() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                '+100',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontFamily: 'deadpack',
                    letterSpacing: 5),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 55, 0, 10),
              child: Container(
                decoration: ShapeDecoration(
                  color: Color.fromRGBO(41, 167, 77, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: Text(
                  '\$',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Ariel',
                      letterSpacing: 5),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.fromLTRB(32, 0, 0, 10),
              child: Text(
                'GROUP NET BALANCE',
                style: TextStyle(fontSize: 14, color: Colors.white),
              )),
        ),
        groupDebitCredit(),
        Divider(
          color: Colors.white,
          thickness: 2,
          endIndent: 20,
          indent: 20,
        ),
      ],
    );
  }

  Widget groupUsers() {
    getGroupUsers();
    return FutureBuilder(
      future: fireStoreFunctions.getGroupUsers(widget.selectedGroup.groupID),
      builder: (context, snapShot) {
        if (snapShot.data == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container(
            child: Center(
              child: loadingAnimation,
            ),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: snapShot.data.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.transparent,
              margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
              //elevation: 20,
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
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
                title: Text(
                  snapShot.data[index].fullName,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '@${snapShot.data[index].username}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          },
        );
      },
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FlatButton(
              child: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              'Group: ${widget.selectedGroup.groupName}',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            IconButton(
              icon: Icon(
                Icons.history,
                color: Colors.orange,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettledTransactions(),
                  ),
                );
              },
            ),
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
//        appBar: AppBar(
//          title: Text('Group: ${widget.selectedGroup.groupName}'),
//        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              customAppBar(),
              groupNetBalance(),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text(
                    'Tranactions',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              groupUsers(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            //icon: Icon(Icons.add),
            backgroundColor: Colors.blue,
            label: Icon(Icons.add),
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
