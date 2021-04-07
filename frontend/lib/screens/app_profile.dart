import 'package:flutter/material.dart';

class AppProfile extends StatefulWidget {
  AppProfile({Key key}) : super(key: key);

  @override
  _AppProfileState createState() => _AppProfileState();
}

class _AppProfileState extends State<AppProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("App Profile Screen")),
    );
  }
}
