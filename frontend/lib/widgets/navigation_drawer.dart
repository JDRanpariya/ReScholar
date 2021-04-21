import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rescholar/models/rescholar_user.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  String _selection = 'All Papers';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ReScholarUser>(context);

    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0)),
        child: Drawer(
            child: Container(
                color: Color(0xFF1C1C1C),
                child: user.isAnonymous == false
                    ? Column(
                        children: [
                          ListTile(
                            trailing: IconButton(
                              icon: Icon(Icons.menu_rounded, size: 28.0),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          // TODO: Write logic for getting the item count inside each library sub-sections
                          // TODO: Implement onTap routing to different pages
                          // TODO: Implement onLongPress menu & logic
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 0.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              color: Color(0x4D21629D),
                            ),
                            child: ListTile(
                                onTap: () {
                                  setState(() {
                                    _selection = 'All Papers';
                                  });
                                },
                                selected: _selection == 'All Papers',
                                tileColor: Color(0xFF1C1C1C),
                                selectedTileColor: Colors.transparent,
                                leading: Icon(
                                  Icons.article_rounded,
                                  color: Colors.white,
                                  size: 28.0,
                                ),
                                minLeadingWidth: 0.0,
                                horizontalTitleGap: 10.0,
                                title: Text("All Papers",
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white)),
                                trailing: Text("30",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xFFB2B2B2))),
                                visualDensity: VisualDensity(vertical: -3.0)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 0.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              color: Color(0x4D21629D),
                            ),
                            child: ListTile(
                                onTap: () {
                                  setState(() {
                                    _selection = 'Favourites';
                                  });
                                },
                                selected: _selection == 'Favourites',
                                tileColor: Color(0xFF1C1C1C),
                                selectedTileColor: Colors.transparent,
                                leading: Icon(
                                  Icons.star_rounded,
                                  size: 28.0,
                                  color: Color(0xFFFFC000),
                                ),
                                minLeadingWidth: 0.0,
                                horizontalTitleGap: 10.0,
                                title: Text("Favourites",
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white)),
                                trailing: Text("0",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xFFB2B2B2))),
                                visualDensity: VisualDensity(vertical: -3.0)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 0.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              color: Color(0x4D21629D),
                            ),
                            child: ListTile(
                                onTap: () {
                                  setState(() {
                                    _selection = 'Archive';
                                  });
                                },
                                selected: _selection == 'Archive',
                                tileColor: Color(0xFF1C1C1C),
                                selectedTileColor: Colors.transparent,
                                leading: Icon(Icons.archive_rounded,
                                    size: 28.0, color: Color(0xFFFF9536)),
                                minLeadingWidth: 0.0,
                                horizontalTitleGap: 10.0,
                                title: Text("Archive",
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white)),
                                trailing: Text("0",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xFFB2B2B2))),
                                visualDensity: VisualDensity(vertical: -3.0)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 0.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              color: Color(0x4D21629D),
                            ),
                            child: ListTile(
                                onTap: () {
                                  setState(() {
                                    _selection = 'Recycle Bin';
                                  });
                                },
                                selected: _selection == 'Recycle Bin',
                                tileColor: Color(0xFF1C1C1C),
                                selectedTileColor: Colors.transparent,
                                leading: Icon(Icons.delete_rounded,
                                    size: 28.0, color: Color(0xFFEB5757)),
                                minLeadingWidth: 0.0,
                                horizontalTitleGap: 10.0,
                                title: Text("Recycle Bin",
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white)),
                                trailing: Text("0",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xFFB2B2B2))),
                                visualDensity: VisualDensity(vertical: -3.0)),
                          ),
                          Divider(
                            color: Color(0xFFB2B2B2),
                            thickness: 2.0,
                            height: 20.0,
                            indent: 12.0,
                            endIndent: 12.0,
                          ),
                          Expanded(
                              child: ListView(
                            children: [
                              // ExpandablePanel(collapsed: collapsed, expanded: expanded)
                            ],
                          ))
                        ],
                      )
                    : Center(
                        child:
                            Text("SignIn With Google to Access this Feature"),
                      ))),
      ),
    );
  }
}
