import 'package:flutter/material.dart';

import 'package:rescholar/widgets/card_builder.dart';

/// Calls the [CardBuilder] widget repeatedly to build a list of cards.
class CardListBuilder extends StatefulWidget {
  final List<Map<String, dynamic>> papers;

  CardListBuilder({Key key, @required this.papers}) : super(key: key);

  @override
  _CardListBuilderState createState() => _CardListBuilderState();
}

class _CardListBuilderState extends State<CardListBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Build the ListView
      itemBuilder: (BuildContext context, int index) {
        return CardBuilder(index: index, data: widget.papers);
      },
      itemCount: widget.papers == null ? 0 : widget.papers.length,
    );
  }
}
