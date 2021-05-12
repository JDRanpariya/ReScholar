import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import 'package:rescholar/models/folders/folder_tree.dart';
import 'package:rescholar/models/folders/folder.dart';
import 'package:rescholar/widgets/header.dart';
import 'package:rescholar/models/user_library.dart';

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
  FolderTree _currentFolderTree;

  List<Folder> _getParentFolders() {
    List<Folder> _parentFolders = [_currentFolderTree.getFolder("ROOT/")];
    Folder _tempFolder = _currentFolder;
    while (_tempFolder.key != "ROOT/") {
      _parentFolders.insert(1, _tempFolder);
      _tempFolder = _currentFolderTree.getParent(_tempFolder.key);
    }
    return _parentFolders;
  }

  @override
  void initState() {
    super.initState();
    // If folderTree updates are not updating in the state properly, consider moving
    // the declaration for _currentFolderTree out of initState()
    _currentFolderTree =
        FolderTree().loadMap(list: context.read<UserLibrary>().folderTree);
    _currentFolder = _currentFolderTree.getFolder(widget.selectedFolderKey);
  }

  @override
  Widget build(BuildContext context) {
    List<Folder> _parentFolders = _getParentFolders();
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
                              Navigator.pushNamed(context, "/library_folders",
                                  arguments: {
                                    "header": Header(
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
                                    "folderBar": FolderBar(
                                        selectedFolderKey:
                                            _currentFolder.children[index].key),
                                    "papers": context
                                        .read<UserLibrary>()
                                        .getPapersInLibrary("Folders",
                                            _currentFolder.children[index].key)
                                  });
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
                                  "${_currentFolder.children[index].data["paperCount"]}",
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
            itemCount: _parentFolders.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  child: Row(
                children: [
                  _parentFolders[index].label == "Folders"
                      ? Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(
                            MdiIcons.folderHome,
                            size: 30.0,
                            color: Color(
                                _parentFolders[index].data["folderColour"]),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/library_folders",
                          arguments: {
                            "header": Header(
                                Icon(
                                  Icons.folder_rounded,
                                  size: 54.0,
                                ),
                                [
                                  const Color(0xFF3D6BB8),
                                  const Color(0xFF738EBC),
                                ],
                                "${_parentFolders[index].label.toLowerCase()}",
                                [
                                  const Color(0xFF738EBC),
                                  const Color(0xFFE2EDFF),
                                ],
                                true,
                                [
                                  const Color(0xFF9DD0FF),
                                  const Color(0xFF4880DE),
                                ]),
                            "folderBar": FolderBar(
                                selectedFolderKey: _parentFolders[index].key),
                            "papers": context
                                .read<UserLibrary>()
                                .getPapersInLibrary(
                                    "Folders", _parentFolders[index].key)
                          });
                    },
                    child: Text(
                      "${_parentFolders[index].label}",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                ],
              ));
            },
          ),
        )
      ],
    );
  }
}
