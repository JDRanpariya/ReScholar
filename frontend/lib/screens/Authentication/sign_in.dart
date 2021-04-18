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
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text("Sign In"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
            child: Column(
          children: [
            SizedBox(height: 20.0),
            ElevatedButton(
                child: Text(
                  "Sign In using Google",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  dynamic user = await _auth.signInWithGoogle();
                  if (user == null) {
                    print("error signing in");
                  } else {
                    print("User Signed In");
                    print(user);
                  }
                }),
            SizedBox(height: 20.0),
            Text("OR"),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () async {
                dynamic user = await _auth.signInAnon();
                if (user == null) {
                  print("error signing in");
                } else {
                  print("User Signed In");
                  print(user);
                }
              },
              child: Text("Sign In as Guest"),
            ),
          ],
        )),
      ),
    );
  }
}
