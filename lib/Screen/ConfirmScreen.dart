import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vote_app/Authen.dart';
import 'VotingScreen.dart';
import 'main.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String email = "";
  String name = "";
  String avatarUrl = "";
  Future<void> getUsername() async {
    setState(() {
      email = box.getAt(0);
      name = box.getAt(1);
      avatarUrl = box.getAt(2);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
          child: Column(
        children: [
          Text("Hello ${name}, your email address is: ${email}"),
          Image.network(avatarUrl),
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => VotingScreen()));
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
