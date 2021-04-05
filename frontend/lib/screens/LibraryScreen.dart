import 'package:flutter/material.dart';
import 'package:fluentui_icons/fluentui_icons.dart'; //flutent icons
import 'package:frontend/Cards.dart';

class LibraryScreen extends StatefulWidget {
  LibraryScreen({Key key}) : super(key: key);

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          toolbarHeight: 65,
          leading: Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: GestureDetector(
              onTap: () {/* Write listener code here */},
              child: ShaderMask(
                shaderCallback: (rect) => LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFFFFA740),
                    const Color(0xFFFFCA8B),
                  ],
                ).createShader(rect),
                child: Icon(
                  FluentSystemIcons.ic_fluent_library_filled,
                  size: 48,
                ),
              ),
            ),
          ),
          title: ShaderMask(
            shaderCallback: (rect) => LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  const Color(0xFFFFC27A),
                  const Color(0xFF8BB6FF),
                ]).createShader(rect),
            child: Text(
              "library",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 24, 0),
              child: GestureDetector(
                onTap: () {/* Write listener code here */},
                child: ShaderMask(
                  shaderCallback: (rect) => LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      const Color(0xFF4880DE),
                      const Color(0xFF9DD0FF),
                    ],
                  ).createShader(rect),
                  child: Icon(
                    Icons.search_rounded,
                    size: 48,
                  ),
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            feed(),
          ],
        ),
      ),
    );
  }
}
