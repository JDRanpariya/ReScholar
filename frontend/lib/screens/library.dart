import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

import 'package:rescholar/widgets/build_card_list.dart';
import 'package:rescholar/widgets/header.dart';
import 'package:rescholar/widgets/navigation_drawer.dart';

class Library extends StatefulWidget {
  Library({Key key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      drawer: NavigationDrawer(),
      appBar: Header(
          Icon(
            FluentSystemIcons.ic_fluent_library_filled,
            size: 54,
          ),
          [
            const Color(0xFFFFA740),
            const Color(0xFFFFCA8B),
          ],
          "library",
          [
            const Color(0xFFFFC27A),
            const Color(0xFF8BB6FF),
          ],
          true,
          [
            const Color(0xFF9DD0FF),
            const Color(0xFF4880DE),
          ]),
      body: Column(
        children: [
          Expanded(child: BuildCardList()),
        ],
      ),
    );
  }
}
