import 'package:flutter/material.dart';
import 'package:rescholar/models/rescholar_user.dart';
import 'package:provider/provider.dart';
import 'package:rescholar/services/auth.dart';

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
          SizedBox(height: 20.0),
          user.isAnonymous == false
              ? Column(children: [
                  Container(
                    child: Image.network(user.profilePic),
                    height: 50,
                    width: 50,
                  ),
                  Text(user.username),
                  SizedBox(height: 20.0),
                  Text(user.email),
                ])
              : Text("You are Logged in as Guest"),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              await _auth.signOut();
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(125, 50)),
                backgroundColor: MaterialStateProperty.all(Color(0x40BD2B4B)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))))),
            child: Text(
              "Sign Out",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFBD2B4B),
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
