import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// Builds a card for display in the library or search results.
class CardBuilder extends StatefulWidget {
  final int index;
  final dynamic data;
  final bool inLibrary;

  const CardBuilder({Key key, this.index, this.data, this.inLibrary})
      : super(key: key);

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

    // TODO: Add drag trigger's onTap() logic
    return Slidable(
      closeOnScroll: true,
      enabled: widget.inLibrary ? true : false,
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: widget.inLibrary
          ? <Widget>[
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
                    widget.data[widget.index]['paperProperties']['isArchived']
                        ? Icons.unarchive_rounded
                        : Icons.archive,
                    size: 48.0,
                    color: Color(0xFFFF9536)),
                onTap: widget.data[widget.index]['paperProperties']
                        ['isArchived']
                    ? () {}
                    : () {},
              ),
              IconSlideAction(
                color: Color(0x33EB5757),
                iconWidget: Icon(
                    widget.data[widget.index]['paperProperties']['isDeleted']
                        ? Icons.settings_backup_restore_rounded
                        : Icons.delete_rounded,
                    size: 48.0,
                    color: Color(0xFFEB5757)),
                onTap: widget.data[widget.index]['paperProperties']['isDeleted']
                    ? () {}
                    : () {},
              ),
            ]
          : null,
      child: Card(
        margin: EdgeInsets.all(0),
        color: Colors.transparent,
        child: InkWell(
          onTap: _pressed,
          onLongPress: () {/* TODO: Implement long press menu logic */},
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: Icon(Icons.more_vert),
                        iconSize: 21.0,
                        onPressed: () {/* TODO: Implement Pop-up Menu */}),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Text(
                    widget.data[widget.index]['authors'].join(", ") +
                        " - " +
                        widget.data[widget.index]['journal'] +
                        " - " +
                        widget.data[widget.index]['year'],
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
                    IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          onpress
                              ? Icons.add_to_photos_rounded
                              : Icons.add_to_photos_outlined,
                          color: Color(0xFF9DD0FF),
                          size: 30,
                        ),
                        onPressed: () {
                          /* TODO: Implement Add To Favourties logic */
                        }),
                    IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          onpress
                              ? Icons.star_rounded
                              : Icons.star_border_rounded,
                          color: Color(0xFFFFC000),
                          size: 36,
                        ),
                        onPressed: () {
                          /* TODO: Implement Add To Folder logic & UI */
                        }),
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
