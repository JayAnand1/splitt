import 'add_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';

//import 'package:rect_getter/rect_getter.dart';
import 'firestore_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = 'qwe';

  FireStoreFunctions fireStoreFunctions = FireStoreFunctions();

  FirebaseUser _loggedInUser;

  void initState() {
    super.initState();
  }

  getReceivables() {
    return Container(
      child: FutureBuilder(
        future: fireStoreFunctions.getTransactions(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text("Loading"),
              ),
            );
            // ignore: missing_return
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile();
                });
          }
        },
      ),
    );
  }

  int _receivables = 0;

  Widget customAppBarHomePage() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0, color: Colors.white),
        color: Colors.white,
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              child: Icon(Icons.menu, color: Colors.black87, size: 30),
              onPressed: () {

              },
            ),
            FlatButton(
              child:
                  Icon(Icons.account_circle, color: Colors.black87, size: 30),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget welcomeMsg() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 0, color: Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(40.0),
              bottomRight: const Radius.circular(40.0))),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 40, 0, 40),
            child: Text(
              'Good Morning',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          )
        ],
      ),
    );
  }

  Widget receivablesCard() {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 20, 16, 20),
      decoration: BoxDecoration(
          color: Color(0xffE0EAFC),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            new BoxShadow(
              color: Colors.black45,
              blurRadius: 10.0,
              spreadRadius: 1,
            ),
          ]),
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(16, 50, 16, 50),
        title: Text('Receivables'),
        trailing: Text(
          '\$ 10,000.00',
          style: TextStyle(fontSize: 30, color: Colors.green),
        ),
      ),
    );
  }

  Widget payablesCard() {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 20, 16, 20),
      decoration: BoxDecoration(
          color: Color(0xff4CA1AF),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            new BoxShadow(
              color: Colors.black45,
              blurRadius: 10.0,
              spreadRadius: 1,
            ),
          ]),
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(16, 50, 16, 50),
        leading: Icon(
          Icons.account_circle,
          color: Colors.white,
        ),
        title: Text('Payables'),

        //subtitle: Text('asdas'),
        trailing: Text(
          '\$ 10,000.00',
          style: TextStyle(fontSize: 30, color: Colors.red),
        ),
      ),
    );
  }

  Widget customFloatingActionButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTransaction()));
        },
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            customAppBarHomePage(),
            welcomeMsg(),
            SizedBox(height: 30),
            receivablesCard(),
            SizedBox(height: 30),
            payablesCard(),
          ],
        ),
        floatingActionButton: customFloatingActionButton(),
      ),
    );
  }
}
