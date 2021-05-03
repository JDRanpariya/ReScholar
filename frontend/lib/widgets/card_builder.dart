import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:rescholar/widgets/buttons.dart';

class CardBuilder extends StatefulWidget {
  final int index;
  final dynamic data;

  const CardBuilder({Key key, this.index, this.data}) : super(key: key);

  @override
  _CardBuilderState createState() => _CardBuilderState();
}

class _CardBuilderState extends State<CardBuilder> {
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
    // TODO: Add drag trigger's onTap() navigation
    return Slidable(
      closeOnScroll: true,
      enabled: true,
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: <Widget>[
        IconSlideAction(
          color: Color(0x4D4880DE),
          iconWidget: Icon(
              widget.data[widget.index]['paperProperties']["isRead"]
                  ? Icons.remove_done
                  : Icons.done_rounded,
              size: 48.0,
              color: Color(0xFF4880DE)),
          onTap: widget.data[widget.index]['paperProperties']["isRead"]
              ? () {}
              : () {},
        ),
        IconSlideAction(
          color: Color(0x4DFF9536),
          iconWidget: Icon(
              widget.data[widget.index]['paperProperties']["isArchived"]
                  ? Icons.unarchive_rounded
                  : Icons.archive,
              size: 48.0,
              color: Color(0xFFFF9536)),
          onTap: widget.data[widget.index]['paperProperties']["isArchived"]
              ? () {}
              : () {},
        ),
        IconSlideAction(
          color: Color(0x33EB5757),
          iconWidget: Icon(
              widget.data[widget.index]['paperProperties']["isDeleted"]
                  ? Icons.settings_backup_restore_rounded
                  : Icons.delete_rounded,
              size: 48.0,
              color: Color(0xFFEB5757)),
          onTap: widget.data[widget.index]['paperProperties']["isDeleted"]
              ? () {}
              : () {},
        ),
      ],
      child: Card(
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
                              fontWeight: FontWeight.w600, fontSize: 15),
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
                      fontSize: 9,
                    ),
                  ),
                ),
                Text(widget.data[widget.index]['snippet'],
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 11)),
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
      ),
    );
  }
}
