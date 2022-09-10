import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vote_app/Authen.dart';
import 'VotingScreen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key, required User user})
      : _user = user,
        super(key: key);
  final User _user;

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late User user;
  String username = "";

  // Future<void> getUsername() async {
  //   var box = await Hive.openBox('user');
  //   username = box.length.toString();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = widget()._user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
          child: Column(
        children: [
          Text("Hello ${user.displayName}, email: ${username}"),
          TextButton(
              onPressed: () {
                Authentication.signOut(context: context);
                Navigator.of(context).pop();
              },
              child: Text(
                "Sign out",
                style: TextStyle(fontSize: 24),
              )),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VotingScreen(user: user)));
              },
              child: Text(
                "Continue",
                style: TextStyle(fontSize: 24),
              ))
        ],
      )),
    );
  }
}
