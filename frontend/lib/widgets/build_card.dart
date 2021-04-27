import 'package:flutter/material.dart';

import 'package:rescholar/widgets/buttons.dart';

class BuildCard extends StatefulWidget {
  final int index;
  final dynamic data;

  const BuildCard({Key key, this.index, this.data}) : super(key: key);

  @override
  _BuildCardState createState() => _BuildCardState();
}

class _BuildCardState extends State<BuildCard> {
  bool onpress = false;

  _pressed() {
    // TODO: Implement research paper page logic
    setState(() {
      onpress = !onpress;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Card(
      margin: EdgeInsets.all(0),
      color: Colors.transparent,
      child: InkWell(
        onTap: _pressed,
        onLongPress: () {/* TODO: Implement long press menu logic */},
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 2),
                    child: Container(
                      width: screenWidth - 80,
                      child: Text(
                        widget.data[widget.index]['title'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                    ),
                  ),
                  PopUpMenuButton(),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Text(
                  widget.data[widget.index]['authors'] +
                      " - " +
                      widget.data[widget.index]['journal'] +
                      " - " +
                      widget.data[widget.index]['year'] +
                      " - " +
                      widget.data[widget.index]['publisher'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
              Text(widget.data[widget.index]['snippet'],
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ToFolder(),
                  ToFavourites(),
                ],
              ),
              Divider(
                color: Color(0x2EFFFFFF),
                height: 2,
                thickness: 1.25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
