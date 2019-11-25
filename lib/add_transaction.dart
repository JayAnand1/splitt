import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'firestore_helper.dart';
import 'package:flutter/cupertino.dart';

class AddTransaction extends StatefulWidget {
  List<GroupUser> selectedGroup;

  AddTransaction({this.selectedGroup});

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  void customDialogBox(String dialogMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(dialogMessage),
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

  var totalAmount;
  var yourShare;
  var description;
  String groupName;
  String userName;

  var groupAmountPayable;

  FireStoreFunctions fireStoreFunctions = FireStoreFunctions();

  calculateSplitAmount() {
    groupAmountPayable = double.parse(totalAmount) - double.parse(yourShare);
    groupAmountPayable = groupAmountPayable / widget.selectedGroup.length;
    groupAmountPayable = groupAmountPayable.toString();
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
          title: Text('Add Transactions'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    totalAmount = value;
                    calculateSplitAmount();
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Amount",
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    yourShare = value;
                    calculateSplitAmount();
                  },
                  decoration: InputDecoration(
                    hintText: "Your Share",
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    description = value;
                  },
                  decoration: InputDecoration(
                    hintText: "Description",
                  ),
                ),
                SizedBox(height: 40),
                MaterialButton(
                  child: Text("Split Equally"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SplitEqual(
                                  totalAmount: totalAmount,
                                  yourShare: yourShare,
                                  description: description,
                                  groupAmountPayable: groupAmountPayable,
                                  selectedGroup: widget.selectedGroup,
                                )));
                  },
                ),
                MaterialButton(
                  child: Text("Select Users"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SplitUnequally(
                                  totalAmount: totalAmount,
                                  yourShare: yourShare,
                                  description: description,
                                  groupAmountPayable: groupAmountPayable,
                                  selectedGroup: widget.selectedGroup,
                                )));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SplitEqual extends StatefulWidget {
  String totalAmount;
  String yourShare;
  String description;
  var groupAmountPayable;

  List<GroupUser> selectedGroup;

  SplitEqual(
      {this.totalAmount,
      this.yourShare,
      this.description,
      this.groupAmountPayable,
      this.selectedGroup});

  @override
  _SplitEqualState createState() => _SplitEqualState();
}

class _SplitEqualState extends State<SplitEqual> {
  @override
  Widget build(BuildContext context) {
    print(widget.groupAmountPayable);
    return Scaffold(
      body: ListView.builder(
          itemCount: widget.selectedGroup.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(widget.selectedGroup[index].fullName),
              trailing: Text(widget.groupAmountPayable),
            );
          }),
    );
  }
}

class SplitUnequally extends StatefulWidget {
  String totalAmount;
  String yourShare;
  String description;
  var groupAmountPayable;

  List<GroupUser> selectedGroup;

  SplitUnequally(
      {this.totalAmount,
      this.yourShare,
      this.description,
      this.groupAmountPayable,
      this.selectedGroup});

  @override
  _SplitUnequallyState createState() => _SplitUnequallyState();
}

class _SplitUnequallyState extends State<SplitUnequally> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: widget.selectedGroup.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(widget.selectedGroup[index].fullName),
              trailing: new Container(
                width: 150.0,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Expanded(
                      flex: 3,
                      child: new TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.end,
                        decoration: new InputDecoration.collapsed(
                            hintText: 'Enter Amount'),
                      ),
                    ),
                    new Expanded(
                      child: new IconButton(
                        icon: new Icon(Icons.monetization_on),
                        color: Colors.black26,
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
