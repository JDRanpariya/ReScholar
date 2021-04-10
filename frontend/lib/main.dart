import 'package:flutter/material.dart';

import 'package:rescholar/widgets/navigation_bar.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ReScholar(),
    theme: ThemeData(
      brightness: Brightness.dark,
    ),
    themeMode: ThemeMode.dark,
  ));
}

class ReScholar extends StatefulWidget {
  @override
  _ReScholarState createState() => _ReScholarState();
}

class _ReScholarState extends State<ReScholar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: NavigationBar());
  }
}
