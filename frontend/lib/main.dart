import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:rescholar/services/auth.dart';
import 'package:rescholar/models/rescholar_user.dart';
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
    return StreamProvider<ReScholarUser>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthWrapper(),
        theme: ThemeData(
          fontFamily: 'OpenSans',
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
