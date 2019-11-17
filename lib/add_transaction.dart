import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'firestore_helper.dart';

class AddTransaction extends StatefulWidget {
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {

  var amount;
  var description;
  String groupName;
  String userName;

  FireStoreFunctions fireStoreFunctions = FireStoreFunctions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
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
            ),
            MaterialButton(
              child: Text("Add transaction"),
              onPressed: () {
              fireStoreFunctions.addTransaction(amount, description, groupName, userName);
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



