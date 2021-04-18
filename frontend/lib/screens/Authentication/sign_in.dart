import 'package:flutter/material.dart';

import 'package:rescholar/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "ReScholar",
                  style: TextStyle(
                    fontSize: 36.0,
                    color: Color(0xFF4880DE),
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                onTap: () async {
                  dynamic user = await _auth.signInWithGoogle();
                  if (user == null) {
                    print("Error signing in!");
                  } else {
                    print("User has signed in successfully!");
                    print(user);
                  }
                },
                child: Container(
                    height: 50,
                    width: 215,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        color: Color(0x404880DE)),
                    alignment: Alignment.center,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: AssetImage("assets/icons/google_logo.png"),
                            height: 25.0,
                            width: 25.0,
                          ),
                          Text("Sign in using Google",
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'OpenSans'))
                        ])),
              ),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("OR",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ))),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                onTap: () async {
                  dynamic user = await _auth.signInAnon();
                  if (user == null) {
                    print("Error signing in!");
                  } else {
                    print("User has signed in successfully!");
                    print(user);
                  }
                },
                child: Container(
                    height: 50,
                    width: 195,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        color: Color(0x40FFFFFF)),
                    alignment: Alignment.center,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.account_circle_rounded, size: 25.0),
                          Text("Sign in as a Guest",
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'OpenSans'))
                        ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
