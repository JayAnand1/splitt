import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreFunctions {
  final _auth = FirebaseAuth.instance;
  final _db = Firestore.instance;

  Future<bool> checkUserExists(username) async {
    print("test1");
    var query = await _db
        .collection('Users')
        .where("Username", isEqualTo: "$username")
        .getDocuments();
      print(query.documents);
    if (query.documents.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> logIn(email, password) async {
    FirebaseUser user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    try {
      if (user.isEmailVerified) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  createUser(firstName, lastName, userName, email, password) async {
    var check = await checkUserExists(userName);
    if (check) {
      print('Username exists');
    } else {
      FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      try {
        await user.sendEmailVerification();
      } catch (e) {
        print(e);
        print("An error occured while trying to send email verification");
      }

      await _db.collection('Users').add({
        'First Name': '$firstName',
        'Last Name': '$lastName',
        'Username': '$userName',
        'Email': '$email',
      });
    }
  }

  _getDate() {
    var now = new DateTime.now();
    var date;
    date = new DateTime(now.year, now.month, now.day, now.hour, now.minute,
        now.second, now.millisecond);
    return date;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser loggedInUser;
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
    return loggedInUser;
  }

  sendFriendRequest(email) async {
    FirebaseUser user = await getCurrentUser();
    bool friendInList = false;

    await _db
        .collection('Users')
        .document(user.email)
        .collection('Friends')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        if (email == f.data["email"]) {
          print("Friend already added");
          friendInList = true;
        }
      });
    });

    if (friendInList == false) {
      //send a request to user
      await _db
          .collection('Users')
          .document(email)
          .collection('FriendsRequests')
          .add({
        'To': '$email',
        'From': '${user.email}',
      });
    } else {
      return "friend added";
    }
  }

  Future<List<Friend>> searchFriend(username) async {
    List<Friend> friendList = List<Friend>();

    await _db
        .collection('Users')
        .where("Full name == $username")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        friendList.add(Friend(
          username: f.data["username"],
          fullName: f.data["Full name"],
        ));
      });
    });

    return friendList;
  }

  acceptFriendRequest(friendEmail, fullName) async {
    FirebaseUser user = await getCurrentUser();

    //add to your friend list
    await _db
        .collection('Users')
        .document('${user.email}')
        .collection('Friends')
        .add({
      'username': '$friendEmail',
      'name': '$fullName',
    });

    //add yourself to your new friend's friend list
    await _db
        .collection('Users')
        .document('$friendEmail') // check what is being passed
        .collection('Friends')
        .add({
      'username': '${user.email}',
      'name': ' ',
      // your full name, need to have a profile for the user when they sign up so we can get full name, and other details
    });
  }

  Future<List<Friend>> getAllFriendRequests() async {
    List<Friend> friendRequestList = List<Friend>();

    FirebaseUser loggedInUser = await getCurrentUser();
    if (loggedInUser != null) {
      await _db
          .collection('Users')
          .document(loggedInUser.email)
          .collection('FriendRequests')
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          friendRequestList.add(Friend(
            username: f.data["username"],
            fullName: f.data["fullname"],
          ));
        });
      });
    } else {
      print("error retrieving");
    }
    return friendRequestList;
  }

  void addFriend(userName, fullName) async {
    FirebaseUser user = await getCurrentUser();
    await _db
        .collection('Users')
        .document('${user.email}')
        .collection('Friends')
        .add({
      'username': '$userName',
      'name': '$fullName',
    });
  }

  void newGroup(groupName, users) async {
    FirebaseUser user = await getCurrentUser();
    var members = {};
    for (int i = 0; i < users.length; i++) {
      members['$i'] = users[i];
    }
    await _db
        .collection('Users')
        .document('${user.email}')
        .collection('Groups')
        .add(members);
  }

  void addTransaction(amount, description, groupName, userName) async {
    var date = _getDate();
    FirebaseUser user = await getCurrentUser();

    await _db
        .collection('Users')
        .document('${user.email}')
        .collection('Transactions')
        .add({
      'amount': '$amount',
      'date': '$date',
      'description': '$description',
      'groupName': '$groupName',
    });
  }

  Future<List<TransactionDetail>> getTransactions() async {
    List<TransactionDetail> transactionList = List<TransactionDetail>();

    FirebaseUser loggedInUser = await getCurrentUser();
    if (loggedInUser != null) {
      await _db
          .collection('Users')
          .document(loggedInUser.email)
          .collection('Transactions')
          .orderBy("date", descending: true)
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          print('${f.data["date"]}');
          print('${f.data["description"]}');
          transactionList.add(TransactionDetail(
            amount: int.parse(f.data["amount"]),
            date: f.data["date"],
            description: f.data["description"],
            groupName: f.data["groupName"],
          ));
        });
      });
    } else {
      print("error retrieving");
    }
    return transactionList;
  }

  Future<List<Friend>> getAllFriends() async {
    List<Friend> friendList = List<Friend>();

    FirebaseUser loggedInUser = await getCurrentUser();
    if (loggedInUser != null) {
      await _db
          .collection('Users')
          .document(loggedInUser.email)
          .collection('Friends')
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          friendList.add(Friend(
            username: f.data["username"],
            fullName: f.data["fullName"],
          ));
        });
      });
    } else {
      print("error retrieving");
    }
    return friendList;
  }
}

class TransactionDetail {
  int amount;
  String date;
  String description;
  String groupName;

  TransactionDetail({this.amount, this.date, this.description, this.groupName});
}

class Friend {
  String username;
  String fullName;

  Friend({this.username, this.fullName});
}
