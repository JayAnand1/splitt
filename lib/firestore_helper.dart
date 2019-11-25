import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


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

  Future fetchMyGroups() async {
    FirebaseUser user = await getCurrentUser();

    List<Group> myGroupsList = List<Group>();

    await _db
        .collection('Users')
        .document(user.uid)
        .collection('Groups')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        myGroupsList.add(Group(
          groupID: f.data["GroupID"],
          groupName: f.data["Group Name"],
        ));
      });
    });

    if (myGroupsList != null) {
      return myGroupsList;
    } else {
      return false;
    }
  }

  Future<bool> logIn(email, password) async {
    if (password != null) {

      SpinKitThreeBounce(
        color: Colors.white,
        size: 20.0,
      );

      FirebaseUser user = (await _auth.signInWithEmailAndPassword(
          email: email, password: password))
          .user;
      try {
        if (user.isEmailVerified) {
          print("user id ----> ${user.uid}");
          return true;
        }
      } catch (e) {
        print(e);
      }
    }
    return false;
  }

  createUser(firstName, lastName, userName, email, password) async {
    var check = await checkUserExists(userName);
    if (check) {
      print('Username exists');
      return false;
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

      await _db.collection('Users').document(user.uid).setData({
        'First Name': '$firstName',
        'Last Name': '$lastName',
        'Username': '$userName',
        'Email': '$email',
        'Uid': '${user.uid}'
      });
    }
    return true;
  }

  _getDate() {
    var now = new DateTime.now();
    var date;
    date = new DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
        now.minute,
        now.second,
        now.millisecond);
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

  searchFriend(username) async {
    var query = await _db
        .collection('Users')
        .where("Username", isEqualTo: "$username")
        .getDocuments();

    if (query.documents.isNotEmpty) {
      Friend newFriend = Friend(
          firstName: query.documents.first.data["First Name"],
          lastName: query.documents.first.data["Last Name"],
          email: query.documents.first.data["Email"],
          uID: query.documents.first.data["Uid"],
          username: query.documents.first.data["Username"]);
      return newFriend;
    } else {
      return false;
    }
  }

  myDetails() async {
    final me = await _auth.currentUser();
    Friend myProfile = Friend();
    await _db
        .collection('Users')
        .document(me.uid)
        .get()
        .then((DocumentSnapshot ds) {
      myProfile.firstName = ds.data["First Name"];
      myProfile.lastName = ds.data["Last Name"];
      myProfile.email = ds.data["Email"];
      myProfile.uID = ds.data["Uid"];
      myProfile.username = ds.data["Username"];
    });
    return myProfile;
  }

  addFriend(Friend user) async {
    final myProfile = await myDetails();

    bool requestSent = false;

    await _db
        .collection('Users')
        .document(myProfile.uID)
        .collection('FriendRequests')
        .document('Request sent to: ${user.username}')
        .get()
        .then((DocumentSnapshot ds) {
      print("7878787878787878788");
      print(ds.data);
      if (ds.data != null) {
        print(requestSent);
        requestSent = true;
      }
    });

    if (!requestSent) {
      //put friend request in opposite party's friend request list
      await _db
          .collection('Users')
          .document(user.uID)
          .collection('FriendRequests')
          .document('Request from: ${myProfile.username}')
          .setData({
        'First Name': '${myProfile.firstName}',
        'Last Name': '${myProfile.lastName}',
        'Username': '${myProfile.username}',
        'Email': '${myProfile.email}',
        'Uid': '${myProfile.uID}'
      });

      //show us in our friend list that we have sent a request
      await _db
          .collection('Users')
          .document(myProfile.uID)
          .collection('FriendRequests')
          .document('Request sent to: ${user.username}')
          .setData({
        'First Name': '${user.firstName}',
        'Last Name': '${user.lastName}',
        'Username': '${user.username}',
        'Email': '${user.email}',
        'Uid': '${user.uID}'
      });
      return true;
    } else {
      return false;
    }
  }

  confirmRequest(Friend user) async {
    final me = await _auth.currentUser();
    final myProfile = await myDetails();

    await _db
        .collection('Users')
        .document(me.uid)
        .collection('Friends')
        .document(user.username)
        .setData({
      'First Name': '${user.firstName}',
      'Last Name': '${user.lastName}',
      'Username': '${user.username}',
      'Email': '${user.email}',
      'Uid': '${user.uID}'
    });

    await _db
        .collection('Users')
        .document(me.uid)
        .collection('FriendRequests')
        .document("Request from: ${user.username}")
        .delete();

    await _db
        .collection('Users')
        .document(user.uID)
        .collection('Friends')
        .document(myProfile.username)
        .setData({
      'First Name': '${myProfile.firstName}',
      'Last Name': '${myProfile.lastName}',
      'Username': '${myProfile.username}',
      'Email': '${myProfile.email}',
      'Uid': '${myProfile.uID}'
    });

    await _db
        .collection('Users')
        .document(user.uID)
        .collection('FriendRequests')
        .document('Request sent to: ${myProfile.username}')
        .delete();

    return myProfile;
  }

  Future<List<Friend>> getFriendRequests() async {
    List<Friend> friendRequestList = List<Friend>();

    FirebaseUser loggedInUser = await getCurrentUser();
    if (loggedInUser != null) {
      await _db
          .collection('Users')
          .document(loggedInUser.uid)
          .collection('FriendRequests')
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          friendRequestList.add(Friend(
            email: f.data["Email"],
            firstName: f.data["First Name"],
            lastName: f.data["Last Name"],
            uID: f.data["Uid"],
            username: f.data["Username"],
          ));
        });
      });
    } else {
      print("error retrieving");
    }
    return friendRequestList;
  }

  Future<List<Friend>> getFriends() async {
    List<Friend> friendList = List<Friend>();

    FirebaseUser loggedInUser = await getCurrentUser();
    if (loggedInUser != null) {
      await _db
          .collection('Users')
          .document(loggedInUser.uid)
          .collection('Friends')
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          friendList.add(Friend(
            email: f.data["Email"],
            firstName: f.data["First Name"],
            lastName: f.data["Last Name"],
            uID: f.data["Uid"],
            username: f.data["Username"],
          ));
        });
      });
    } else {
      print("error retrieving");
    }
    return friendList;
  }

  createGroup(groupName, groupDescription, List<Friend> groupUsers) async {
    print(groupDescription);

    //full name, username
//    GroupUser groupUser = GroupUser();

    //List<GroupUser> users = List<GroupUser>();

    Uuid uuid = Uuid();
    String groupID = uuid.v4();

    print(groupID);

    FirebaseUser user = await getCurrentUser();

    await _db.collection('Groups').document('$groupID').setData({
      'Group Name': '$groupName',
      'Group Description': '$groupDescription',
      'AdminID': '${user.uid}',
      'GroupID': '$groupID'
    });

    for (int i = 0; i < groupUsers.length; i++) {
      await _db
          .collection('Groups')
          .document('$groupID')
          .collection('Users')
          .document(groupUsers[i].uID)
          .setData({
        "Full Name":
        "${groupUsers[i].firstName + " " + groupUsers[i].lastName}",
        "Username": "${groupUsers[i].username}",
        "UserID": "${groupUsers[i].uID}"
      });
    }

    await _db
        .collection('Users')
        .document('${user.uid}')
        .collection('Groups')
        .document('$groupID')
        .setData({
      "Group Name": "$groupName",
      "GroupID": "$groupID",
      "Group Size": "${groupUsers.length}"
    });
  }

//  Future<List<Friend>> searchFriend(username) async {
//    List<Friend> friendList = List<Friend>();
//
//    await _db
//        .collection('Users')
//        .where("Full name == $username")
//        .getDocuments()
//        .then((QuerySnapshot snapshot) {
//      snapshot.documents.forEach((f) {
//        friendList.add(Friend(
//          username: f.data["username"],
//          fullName: f.data["Full name"],
//        ));
//      });
//    });
//
//    return friendList;
//  }
//
//  acceptFriendRequest(friendEmail, fullName) async {
//    FirebaseUser user = await getCurrentUser();
//
//    //add to your friend list
//    await _db
//        .collection('Users')
//        .document('${user.email}')
//        .collection('Friends')
//        .add({
//      'username': '$friendEmail',
//      'name': '$fullName',
//    });
//
//    //add yourself to your new friend's friend list
//    await _db
//        .collection('Users')
//        .document('$friendEmail') // check what is being passed
//        .collection('Friends')
//        .add({
//      'username': '${user.email}',
//      'name': ' ',
//      // your full name, need to have a profile for the user when they sign up so we can get full name, and other details
//    });
//  }

//  Future<List<Friend>> getAllFriendRequests() async {
//    List<Friend> friendRequestList = List<Friend>();
//
//    FirebaseUser loggedInUser = await getCurrentUser();
//    if (loggedInUser != null) {
//      await _db
//          .collection('Users')
//          .document(loggedInUser.email)
//          .collection('FriendRequests')
//          .getDocuments()
//          .then((QuerySnapshot snapshot) {
//        snapshot.documents.forEach((f) {
//          friendRequestList.add(Friend(
//            username: f.data["username"],
//            fullName: f.data["fullname"],
//          ));
//        });
//      });
//    } else {
//      print("error retrieving");
//    }
//    return friendRequestList;
//  }

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

  searchFriendID(username) async {
    var query = await _db
        .collection('Users')
        .where("Username", isEqualTo: "$username")
        .getDocuments();

    if (query.documents.isNotEmpty) {
      Friend newFriend = Friend(
          firstName: query.documents.first.data["First Name"],
          lastName: query.documents.first.data["Last Name"],
          email: query.documents.first.data["Email"],
          uID: query.documents.first.data["Uid"],
          username: query.documents.first.data["Username"]);
      return newFriend;
    } else {
      return false;
    }
  }

  void addTransaction(amount, description, groupName, userName, groupID) async {
    var date = _getDate();
    FirebaseUser user = await getCurrentUser();

    FirebaseUser getUser = await searchFriend(userName);
    print(getUser.uid);

    await _db
        .collection('Users')
        .document('${getUser.uid}')
        .collection('Transactions')
        .add({
      'amount': '$amount',
      'date': '$date',
      'description': '$description',
      'groupName': '$groupName',
    });

    await _db
        .collection('Group')
        .document('${getUser.uid}')
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

  getGroupUsers(groupID) async {
    List<GroupUser> users = List<GroupUser>();
    FirebaseUser user = await getCurrentUser();

    await _db
        .collection('Groups')
        .document(groupID)
        .collection('Users')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        users.add(GroupUser(
          fullName: f.data["Full Name"],
          username: f.data["Username"],
          userID: f.data["UserID"],
        ));
      });
    });
    if (users.length > 0) {
      return users;
    } else {
      return null;
    }
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
  String firstName;
  String lastName;
  String email;
  String uID;

  Friend({this.username, this.firstName, this.lastName, this.email, this.uID});
}

class GroupUser {
  String fullName;
  String username;
  String userID;

  GroupUser({this.fullName, this.username, this.userID});
}

class Group {
  String groupName;
  String groupID;

  Group({this.groupName, this.groupID});
}
