import 'package:flutter/material.dart';

import 'package:rescholar/widgets/card_builder.dart';

/// Calls the [CardBuilder] widget repeatedly to build a list of cards.
class CardListBuilder extends StatefulWidget {
  // final List<Map<String, dynamic>> papers;
  final List<Map<String, dynamic>> papers;
  final bool inLibrary;

  CardListBuilder({Key key, @required this.papers, this.inLibrary = true})
      : super(key: key);

  @override
  _CardListBuilderState createState() => _CardListBuilderState();
}

class _CardListBuilderState extends State<CardListBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Build the ListView
      itemBuilder: (BuildContext context, int index) {
        return CardBuilder(
            index: index, data: widget.papers, inLibrary: widget.inLibrary);
      },
      itemCount: widget.papers == null ? 0 : widget.papers.length,
    );
  }
}
