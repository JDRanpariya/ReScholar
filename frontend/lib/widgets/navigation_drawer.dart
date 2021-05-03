import 'package:flutter_treeview/tree_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:rescholar/data/user_library.dart';
import 'package:rescholar/widgets/custom_toast.dart';
import 'package:rescholar/models/rescholar_user.dart';
import 'package:rescholar/widgets/library_builder.dart';
import 'package:rescholar/widgets/header.dart';
import 'package:rescholar/widgets/folder_bar.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  String _selection = 'Papers';
  Map<String, int> libraryPaperCount = userLibrary['libraryPaperCount'];
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
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LibraryBuilder(
                          header: Header(
                              Icon(
                                node.key == "ROOT/"
                                    ? MdiIcons.folderHome
                                    : Icons.folder_rounded,
                                size: 54.0,
                              ),
                              [
                                const Color(0xFF3D6BB8),
                                const Color(0xFF738EBC),
                              ],
                              "${node.label.toLowerCase()}",
                              [
                                const Color(0xFF738EBC),
                                const Color(0xFFE2EDFF),
                              ],
                              true,
                              [
                                const Color(0xFF9DD0FF),
                                const Color(0xFF4880DE),
                              ]),
                          folderBar: FolderBar(selectedFolderKey: node.key),
                          papers: [])));
            });
          },
          onLongPress: () {},
          selected: _selection == node.label,
          tileColor: Color(0xFF1C1C1C),
          selectedTileColor: Colors.transparent,
          leading: node.key == "ROOT/"
              ? Icon(
                  MdiIcons.folderHome,
                  color: Color(node.data["folderColour"]),
                  size: 28.0,
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
          trailing: Text("${node.data["paperCount"]}",
              style: TextStyle(fontSize: 14.0, color: Color(0xFFB2B2B2))),
          contentPadding: EdgeInsets.only(left: 8.0, right: 16.0),
          visualDensity: VisualDensity(vertical: -3.0)),
    );
  }

  @override
  void initState() {
    super.initState();
    _treeViewController =
        _treeViewController.loadMap(list: userLibrary["folderTree"]);
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
                      // TODO: Write logic for getting the paper count inside each library sub-sections
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
                                _selection = 'Papers';
                              });
                            },
                            selected: _selection == 'Papers',
                            tileColor: Color(0xFF1C1C1C),
                            selectedTileColor: Colors.transparent,
                            leading: Icon(
                              Icons.article_rounded,
                              color: Colors.white,
                              size: 28.0,
                            ),
                            minLeadingWidth: 0.0,
                            horizontalTitleGap: 10.0,
                            title: Text("Papers",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.white)),
                            trailing: Text("${libraryPaperCount["Papers"]}",
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
                            trailing: Text("${libraryPaperCount["Favourites"]}",
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
                            trailing: Text("${libraryPaperCount["Archive"]}",
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
                            trailing: Text(
                                "${libraryPaperCount["Recycle Bin"]}",
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
