import 'package:flutter/material.dart';

import 'package:rescholar/services/auth.dart';

class AppProfile extends StatelessWidget {
  const AppProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("App Profile Screen"),
          ),
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
                  fontFamily: 'OpenSans'),
            ),
          ),
        ],
      ),
    );
  }
}
