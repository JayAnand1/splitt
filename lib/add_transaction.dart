import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'firestore_helper.dart';
import 'package:flutter/cupertino.dart';

class AddTransaction extends StatefulWidget {
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

  var amount;
  var description;
  String groupName;
  String userName;

  FireStoreFunctions fireStoreFunctions = FireStoreFunctions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Transactions'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            TextField(
              onChanged: (value) {
                amount = value;
              },
              decoration: InputDecoration(
                hintText: "Enter Amount",
              ),
            ),
            TextField(
              onChanged: (value) {
                description = value;
              },
              decoration: InputDecoration(
                hintText: "Enter description",
              ),
            ),
            TextField(
              onChanged: (value) {
                userName = value;
              },
              decoration: InputDecoration(
                hintText: "Enter user name",
              ),
            ),SizedBox(height: 40),
            MaterialButton(
              child: Text("Add transaction"),
              onPressed: () {
              fireStoreFunctions.addTransaction(amount, description, groupName, userName);
              customDialogBox('Transaction Recorded');
              },
            ),
            MaterialButton(
              child: Text("Print transactions to console"),
              onPressed: () {
                fireStoreFunctions.getTransactions();
              },
            ),
          ],),),
      ),);
  }
}



