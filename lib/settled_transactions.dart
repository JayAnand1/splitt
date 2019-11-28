import 'package:flutter/material.dart';

class SettledTransactions extends StatefulWidget {
  @override
  _SettledTransactionsState createState() => _SettledTransactionsState();
}

class _SettledTransactionsState extends State<SettledTransactions> {

  Widget customAppBar() {
    return Container(
      decoration: BoxDecoration(
        //border: Border.all(width: 0, color: Colors.white),
        //color: Colors.white,
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
                'Settled Transactions',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              customAppBar()
            ],
          ),
        ),
      ),
    );
  }
}
