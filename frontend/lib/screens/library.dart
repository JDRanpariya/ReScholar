import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:rescholar/widgets/library_builder.dart';
import 'package:rescholar/widgets/header.dart';
import 'package:rescholar/data/user_library.dart';

/// Initial gateway into the Papers section of the [Library].
class Library extends StatefulWidget {
  Library({Key key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> papers = userLibrary["papers"];
    return LibraryBuilder(
        header: Header(
            Icon(
              FluentIcons.library_20_filled,
              size: 54,
            ),
            [
              const Color(0xFFFFA740),
              const Color(0xFFFFCA8B),
            ],
            "papers",
            [
              const Color(0xFFFFC27A),
              const Color(0xFF8BB6FF),
            ],
            true,
            [
              const Color(0xFF9DD0FF),
              const Color(0xFF4880DE),
            ]),
        renderGreeting: true,
        papers: papers);
  }
}
