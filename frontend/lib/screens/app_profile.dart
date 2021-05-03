import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rescholar/services/auth.dart';
import 'package:rescholar/models/rescholar_user.dart';

/// Page to access the settings page and all the other tertiary functionalities of the app.
class AppProfile extends StatelessWidget {
  const AppProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user = Provider.of<ReScholarUser>(context);

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("App Profile Screen"),
          ),
          user.isAnonymous == false
              ? Column(children: [
                  Container(
                    child: Image.network(user.profilePicture),
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(height: 15.0),
                  Text(user.username),
                  SizedBox(height: 15.0),
                  Text(user.email),
                ])
              : Text("You are logged in as a Guest"),
          SizedBox(height: 15.0),
          ElevatedButton(
            onPressed: () async {
              await _auth.signOut();
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(125, 50)),
                backgroundColor: MaterialStateProperty.all(Color(0x40EB5757)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))))),
            child: Text(
              "Sign Out",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFEB5757),
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
