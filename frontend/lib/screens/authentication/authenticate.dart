import 'package:flutter/material.dart';

import 'package:rescholar/screens/authentication/sign_in.dart';

/// Initiates the [SignIn] screen.
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
}
