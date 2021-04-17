import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rescholar/services/auth.dart';

import './models/user.dart';
import 'screens/auth_wrapper.dart';

void main() {
  runApp(ReScholar());
}

class ReScholar extends StatelessWidget {
  const ReScholar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserR>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
            AuthWrapper(), // wrapper checks for auth and decides where user should go login/register or homepage
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
