import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rescholar/services/auth.dart';
import 'package:rescholar/models/rescholar_user.dart';
import 'package:rescholar/widgets/auth_wrapper.dart';

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
        theme: _themeData(),
        themeMode: ThemeMode.dark,
      ),
    );
  }
}

ThemeData _themeData() {
  return ThemeData(
    fontFamily: 'OpenSans',
    brightness: Brightness.dark,
  );
}
