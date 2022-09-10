import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vote_app/Authen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vote_app/Screen/VotingScreen.dart';

import 'ConfirmScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    String name = "name";

    Authentication.signOut(context: context);

    return Scaffold(
      body: Column(
        children: [
          Image.asset("assets/images/girl_login.png"),
          TextButton(
              onPressed: () async {
                User user =
                    await Authentication.signInWithGoogle(context: context)
                        as User;
                if (user != null) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UserScreen()));
                }
              },
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Login with Google"),
                    Icon(Icons.g_mobiledata_outlined)
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
