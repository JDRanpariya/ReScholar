import 'package:flutter/material.dart';
import './screens/wrapper.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:
        Wrapper(), // wrapper checks for auth and decides where user should go login/register or homepage
    theme: ThemeData(
      brightness: Brightness.dark,
    ),
    themeMode: ThemeMode.dark,
  ));
}
