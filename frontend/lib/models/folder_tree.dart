import 'dart:convert';

import 'package:rescholar/models/folder.dart';

/// Defines the insertion mode adding a new Folder to the FolderTree.
enum InsertMode {
  prepend,
  append,
  insert,
}

class FolderTree {
  /// The data for the FolderTree.
  final List<Folder> children;

  /// The key of the select Folder in the FolderTree.
  final String selectedKey;

  FolderTree({
    this.children: const [],
    this.selectedKey,
  });

  /// Creates a copy of this controller but with the given fields
  /// replaced with the new values.
  FolderTree copyWith({List<Folder> children, String selectedKey}) {
    return FolderTree(
      children: children ?? this.children,
      selectedKey: selectedKey ?? this.selectedKey,
    );
  }

  /// Loads this controller with data from a Map.
  /// This method expects the user to properly update the state
  ///
  /// ```dart
  /// setState((){
  ///   controller = controller.loadMap(map: dataMap);
  /// });
  /// ```
  FolderTree loadMap({List<Map<String, dynamic>> list: const []}) {
    List<Folder> treeData =
        list.map((Map<String, dynamic> item) => Folder.fromMap(item)).toList();
    return FolderTree(
      children: treeData,
      // ignore: unnecessary_this
      selectedKey: this.selectedKey,
    );
  }

  /// Adds a new Folder to an existing Folder identified by specified key.
  /// It returns a new controller with the new Folder added. This method
  /// expects the user to properly place this call so that the state is
  /// updated.
  ///
  /// See [FolderTree.addFolder] for info on optional parameters.
  ///
  /// ```dart
  /// setState((){
  ///   controller = controller.withAddFolder(key, newFolder);
  /// });
  /// ```
  FolderTree withAddFolder(
    String key,
    Folder newFolder, {
    Folder parent,
    InsertMode mode: InsertMode.append,
    int index,
  }) {
    List<Folder> _data =
        addFolder(key, newFolder, parent: parent, mode: mode, index: index);
    return FolderTree(
      children: _data,
      // ignore: unnecessary_this
      selectedKey: this.selectedKey,
    );
  }

  /// Replaces an existing Folder identified by specified key with a new Folder.
  /// It returns a new controller with the updated Folder replaced. This method
  /// expects the user to properly place this call so that the state is
  /// updated.
  ///
  /// See [FolderTree.updateFolder] for info on optional parameters.
  ///
  /// ```dart
  /// setState((){
  ///   controller = controller.withUpdateFolder(key, newFolder);
  /// });
  /// ```
  FolderTree withUpdateFolder(String key, Folder newFolder, {Folder parent}) {
    List<Folder> _data = updateFolder(key, newFolder, parent: parent);
    return FolderTree(
      children: _data,
      // ignore: unnecessary_this
      selectedKey: this.selectedKey,
    );
  }

  /// Removes an existing Folder identified by specified key.
  /// It returns a new controller with the Folder removed. This method
  /// expects the user to properly place this call so that the state is
  /// updated.
  ///
  /// See [FolderTree.deleteFolder] for info on optional parameters.
  ///
  /// ```dart
  /// setState((){
  ///   controller = controller.withDeleteFolder(key);
  /// });
  /// ```
  FolderTree withDeleteFolder(String key, {Folder parent}) {
    List<Folder> _data = deleteFolder(key, parent: parent);
    return FolderTree(
      children: _data,
      // ignore: unnecessary_this
      selectedKey: this.selectedKey,
    );
  }

  /// Gets the Folder that has a key value equal to the specified key.
  Folder getFolder(String key, {Folder parent}) {
    Folder _found;
    // ignore: unnecessary_this
    List<Folder> _children = parent == null ? this.children : parent.children;
    Iterator iter = _children.iterator;
    while (iter.moveNext()) {
      Folder child = iter.current;
      if (child.key == key) {
        _found = child;
        break;
      } else {
        if (child.isParent) {
          // ignore: unnecessary_this
          _found = this.getFolder(key, parent: child);
          if (_found != null) {
            break;
          }
        }
      }
    }
    return _found;
  }

  /// Gets the parent of the Folder identified by specified key.
  Folder getParent(String key, {Folder parent}) {
    Folder _found;
    // ignore: unnecessary_this
    List<Folder> _children = parent == null ? this.children : parent.children;
    Iterator iter = _children.iterator;
    while (iter.moveNext()) {
      Folder child = iter.current;
      if (child.key == key) {
        _found = parent ?? child;
        break;
      } else {
        if (child.isParent) {
          // ignore: unnecessary_this
          _found = this.getParent(key, parent: child);
          if (_found != null) {
            break;
          }
        }
      }
    }
    return _found;
  }

  /// Adds a new Folder to an existing Folder identified by specified key. It optionally
  /// accepts an [InsertMode] and index. If no [InsertMode] is specified,
  /// it appends the new Folder as a child at the end. This method returns
  /// a new list with the added Folder.
  List<Folder> addFolder(
    String key,
    Folder newFolder, {
    Folder parent,
    InsertMode mode: InsertMode.append,
    int index,
  }) {
    // ignore: unnecessary_this
    List<Folder> _children = parent == null ? this.children : parent.children;
    return _children.map((Folder child) {
      if (child.key == key) {
        List<Folder> _children = child.children.toList(growable: true);
        if (mode == InsertMode.prepend) {
          _children.insert(0, newFolder);
        } else if (mode == InsertMode.insert) {
          _children.insert(index ?? _children.length, newFolder);
        } else {
          _children.add(newFolder);
        }
        return child.copyWith(children: _children);
      } else {
        return child.copyWith(
          children: addFolder(
            key,
            newFolder,
            parent: child,
            mode: mode,
            index: index,
          ),
        );
      }
    }).toList();
  }

  /// Updates an existing Folder identified by specified key. This method
  /// returns a new list with the updated Folder.
  List<Folder> updateFolder(String key, Folder newFolder, {Folder parent}) {
    // ignore: unnecessary_this
    List<Folder> _children = parent == null ? this.children : parent.children;
    return _children.map((Folder child) {
      if (child.key == key) {
        return newFolder;
      } else {
        if (child.isParent) {
          return child.copyWith(
            children: updateFolder(
              key,
              newFolder,
              parent: child,
            ),
          );
        }
        return child;
      }
    }).toList();
  }

  /// Deletes an existing Folder identified by specified key. This method
  /// returns a new list with the specified Folder removed.
  List<Folder> deleteFolder(String key, {Folder parent}) {
    // ignore: unnecessary_this
    List<Folder> _children = parent == null ? this.children : parent.children;
    List<Folder> _filteredChildren = [];
    Iterator iter = _children.iterator;
    while (iter.moveNext()) {
      Folder child = iter.current;
      if (child.key != key) {
        if (child.isParent) {
          _filteredChildren.add(child.copyWith(
            children: deleteFolder(key, parent: child),
          ));
        } else {
          _filteredChildren.add(child);
        }
      }
    }
    return _filteredChildren;
  }

  /// Get the current selected Folder. Returns null if there is no selectedKey
  Folder get selectedFolder {
    // ignore: unnecessary_this
    return this.selectedKey == null || this.selectedKey.isEmpty
        ? null
        // ignore: unnecessary_this
        : getFolder(this.selectedKey);
  }

  /// Map representation of this object
  List<Map<String, dynamic>> get asMap {
    return children.map((Folder child) => child.asMap).toList();
  }

  @override
  String toString() {
    return jsonEncode(asMap);
  }
}
