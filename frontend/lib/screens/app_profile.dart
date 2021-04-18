import 'package:flutter/material.dart';

import 'package:rescholar/services/auth.dart';

class AppProfile extends StatelessWidget {
  const AppProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Container(
      child: Column(
        children: [
          Center(child: Text("App Profile Screen")),
          TextButton(
            onPressed: () async {
              await _auth.signOut();
            },
            child: Text("Sign Out"),
          )
        ],
      ),
    );
  }
}
