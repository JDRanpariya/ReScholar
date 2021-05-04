import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:rescholar/data/user_library.dart';
import 'package:rescholar/models/folder_tree.dart';
import 'package:rescholar/models/folder.dart';
import 'package:rescholar/widgets/header.dart';
import 'package:rescholar/screens/library.dart';

/// Builds a [FolderBar] that contains a horizontal list of interactive [Folder]
/// icons that can be used to navigate into the [Folder] children in the [FolderTree].
///
/// In addition to this, an interactible path view is also created to notify the
/// user of their current position in the [FolderTree]
class FolderBar extends StatefulWidget {
  final String selectedFolderKey;

  FolderBar({Key key, @required this.selectedFolderKey}) : super(key: key);

  @override
  _FolderBarState createState() => _FolderBarState();
}

class _FolderBarState extends State<FolderBar> {
  Folder _currentFolder;
  FolderTree _currentFolderTree =
      FolderTree().loadMap(list: userLibrary["folderTree"]);

  List _getParentLabels() {
    List _parentLabels = ["Folders"];
    Folder _tempFolder = _currentFolder;
    while (_tempFolder.key != "ROOT/") {
      _parentLabels.insert(1, _tempFolder.label);
      _tempFolder = _currentFolderTree.getParent(_tempFolder.key);
    }
    return _parentLabels;
  }

  @override
  void initState() {
    super.initState();
    _currentFolder = _currentFolderTree.getFolder(widget.selectedFolderKey);
  }

  @override
  Widget build(BuildContext context) {
    List _parentLabels = _getParentLabels();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_currentFolder.children.length != 0)
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: ListView.builder(
              itemCount: _currentFolder.children.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.topCenter,
                  width: 82.0,
                  padding: EdgeInsets.only(right: 21.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Library(
                                          header: Header(
                                              Icon(
                                                Icons.folder_rounded,
                                                size: 54.0,
                                              ),
                                              [
                                                const Color(0xFF3D6BB8),
                                                const Color(0xFF738EBC),
                                              ],
                                              "${_currentFolder.children[index].label.toLowerCase()}",
                                              [
                                                const Color(0xFF738EBC),
                                                const Color(0xFFE2EDFF),
                                              ],
                                              true,
                                              [
                                                const Color(0xFF9DD0FF),
                                                const Color(0xFF4880DE),
                                              ]),
                                          folderBar: FolderBar(
                                              selectedFolderKey: _currentFolder
                                                  .children[index].key),
                                          papers: [])));
                            },
                            splashRadius: 1.0,
                            padding: EdgeInsets.all(0.0),
                            color: Color(_currentFolder
                                .children[index].data["folderColour"]),
                            iconSize: 58.0,
                            icon: Icon(
                              Icons.folder_rounded,
                            ),
                          ),
                          Positioned(
                              top: 32.0,
                              left: 16.0,
                              right: 10.0,
                              bottom: 10.0,
                              child: Container(
                                child: Text(
                                  "${_currentFolder.children[index].children.length}",
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87),
                                  textAlign: TextAlign.right,
                                  softWrap: false,
                                  maxLines: 1,
                                ),
                              ))
                        ],
                      ),
                      Text(
                        "${_currentFolder.children[index].label}",
                        style: TextStyle(
                            fontSize: 11.0, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 30.0,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView.builder(
            itemCount: _parentLabels.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                onTap: () {
                  /* TODO: Add routing logic to navigate backwards pages */
                },
                child: Row(
                  children: [
                    _parentLabels[index] == "Folders"
                        ? Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              MdiIcons.folderHome,
                              size: 30.0,
                              color: Color(_currentFolderTree
                                  .getFolder("ROOT/")
                                  .data["folderColour"]),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(top: 3.0),
                            child: Icon(
                              Icons.chevron_right_rounded,
                              size: 28.0,
                              color: Color(0xFFB2B2B2),
                            ),
                          ),
                    Text(
                      "${_parentLabels[index]}",
                      style: TextStyle(fontSize: 15.0),
                    ),
                    // )
                  ],
                ),
              ));
            },
          ),
        )
      ],
    );
  }
}
