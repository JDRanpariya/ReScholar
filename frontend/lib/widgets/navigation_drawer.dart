import 'package:flutter_treeview/tree_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rescholar/models/custom_icons.dart';
import 'package:rescholar/data/user_library.dart';
import 'package:rescholar/widgets/custom_toast.dart';
import 'package:rescholar/models/rescholar_user.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  String _selection = 'All Papers';
  Map<String, int> libraryItemCount = userLibrary['libraryItemCount'];
  TreeViewController _treeViewController = TreeViewController();

  TreeViewTheme _treeViewTheme = TreeViewTheme(
    expanderTheme: ExpanderThemeData(
      type: ExpanderType.chevron,
      position: ExpanderPosition.start,
      color: Color(0xFFB2B2B2),
      size: 28.0,
    ),
    labelStyle: TextStyle(
      fontSize: 16.0,
      color: Colors.white,
    ),
    parentLabelStyle: TextStyle(
      fontSize: 16.0,
      color: Colors.white,
    ),
    colorScheme: ColorScheme.dark(),
  );
  _expandNode(String key, bool expanded) {
    {
      String msg = '${expanded ? "Expanded" : "Collapsed"}: $key';
      debugPrint(msg);
      Node node = _treeViewController.getNode(key);
      if (node != null) {
        List<Node> updated;
        updated = _treeViewController.updateNode(
            key, node.copyWith(expanded: expanded));
        setState(() {
          _treeViewController = _treeViewController.copyWith(children: updated);
        });
      }
    }
  }

  _nodeBuilder(BuildContext context, Node<dynamic> node) {
    return Container(
      margin: EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        color: Color(0x4D21629D),
      ),
      child: ListTile(
          onTap: () {
            setState(() {
              _selection = node.label;
            });
          },
          onLongPress: () {},
          selected: _selection == node.label,
          tileColor: Color(0xFF1C1C1C),
          selectedTileColor: Colors.transparent,
          leading: node.key == "ROOT"
              ? Padding(
                  padding: const EdgeInsets.only(left: 2.0, right: 6.0),
                  child: Icon(
                    CustomIcons.mdiFolderHome,
                    color: Color(node.data["folderColour"]),
                    size: 20.0,
                  ),
                )
              : Icon(
                  Icons.folder_rounded,
                  color: Color(node.data["folderColour"]),
                  size: 28.0,
                ),
          minLeadingWidth: 0.0,
          horizontalTitleGap: 10.0,
          title: Text(node.label,
              style: TextStyle(fontSize: 16.0, color: Colors.white)),
          trailing: Text("${node.data["itemCount"]}",
              style: TextStyle(fontSize: 14.0, color: Color(0xFFB2B2B2))),
          contentPadding: EdgeInsets.only(left: 8.0, right: 16.0),
          visualDensity: VisualDensity(vertical: -3.0)),
    );
  }

  @override
  void initState() {
    super.initState();
    final List<Map<String, dynamic>> folderStruct = userLibrary['folderModel'];
    _treeViewController = _treeViewController.loadMap(list: folderStruct);
  }

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
                  child: Column(
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
                      // TODO: Implement onTap routing to library sections
                      // TODO: Implement onLongPress menu & logic for folders sections
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
                            trailing: Text("${libraryItemCount["All Papers"]}",
                                style: TextStyle(
                                    fontSize: 14.0, color: Color(0xFFB2B2B2))),
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
                              if (user.isAnonymous == false) {
                                setState(() {
                                  _selection = 'Favourites';
                                });
                              } else {
                                customToast(context,
                                    "Please sign in with Google to view this page");
                              }
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
                            trailing: Text("${libraryItemCount["Favourites"]}",
                                style: TextStyle(
                                    fontSize: 14.0, color: Color(0xFFB2B2B2))),
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
                              if (user.isAnonymous == false) {
                                setState(() {
                                  _selection = 'Archive';
                                });
                              } else {
                                customToast(context,
                                    "Please sign in with Google to view this page");
                              }
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
                            trailing: Text("${libraryItemCount["Archive"]}",
                                style: TextStyle(
                                    fontSize: 14.0, color: Color(0xFFB2B2B2))),
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
                              if (user.isAnonymous == false) {
                                setState(() {
                                  _selection = 'Recycle Bin';
                                });
                              } else {
                                customToast(context,
                                    "Please sign in with Google to view this page");
                              }
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
                            trailing: Text("${libraryItemCount["Recycle Bin"]}",
                                style: TextStyle(
                                    fontSize: 14.0, color: Color(0xFFB2B2B2))),
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
                        child: TreeView(
                          controller: _treeViewController,
                          allowParentSelect: false,
                          onExpansionChanged: _expandNode,
                          theme: _treeViewTheme,
                          nodeBuilder: _nodeBuilder,
                        ),
                      )
                    ],
                  )))),
    );
  }
}
