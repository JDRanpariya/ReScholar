import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:rescholar/services/auth.dart';
import 'package:rescholar/models/user.dart';
import 'package:rescholar/screens/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
            AuthWrapper(), // Wrapper checks for auth and decides if the user should be directed to the login/register screen or home screen
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
