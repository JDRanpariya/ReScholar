import 'package:flutter/material.dart';

import 'package:rescholar/widgets/build_card.dart';
import 'package:rescholar/data/user_library.dart';

class BuildCardList extends StatefulWidget {
  @override
  _BuildCardListState createState() => _BuildCardListState();
}

class _BuildCardListState extends State<BuildCardList> {
  final List<Map<String, dynamic>> items = userLibrary['items'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Build the ListView
      itemBuilder: (BuildContext context, int index) {
        return BuildCard(index: index, data: items);
      },
      itemCount: items == null ? 0 : items.length,
    );
  }
}
