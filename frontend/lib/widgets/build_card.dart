import 'package:flutter/material.dart';

import 'buttons.dart';

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
    setState(() {
      onpress = !onpress;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Card(
      margin: EdgeInsets.all(0),
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _pressed(),
        onLongPress: () {},
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
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                    ),
                  ),
                  PopUpMenuButton(),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Text(
                  widget.data[widget.index]['publishers'],
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
              Text(widget.data[widget.index]['snippet'],
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 12)),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
