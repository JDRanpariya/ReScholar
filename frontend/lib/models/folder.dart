/// Data Model designed by Kevin Andre (from the Flutter TreeView package)

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';

import 'package:rescholar/utils/folder_functions.dart';

/// Defines the data used to display a Folder.
///
/// Used by FolderTree to display a Folder.
///
/// This object allows the creation of key and label to display
/// a Folder on the FolderTree widget. The key and label properties are
/// required. The key is needed for events that occur on the generated
/// Folder. It should always be unique.
class Folder<T> {
  /// The unique string that identifies this object.
  final String key;

  /// The string value that is displayed on the Folder.
  final String label;

  /// Generic data model that can be assigned to the Folder. This makes
  /// it useful to assign and retrieve data associated with the Folder
  final T data;

  /// The sub Folders of this object.
  final List<Folder> children;

  /// Force the Folder to be a parent so that Folder can show expander without
  /// having children Folder.
  final bool parent;

  const Folder({
    @required this.key,
    @required this.label,
    this.children: const [],
    this.parent: false,
    this.data,
  })  : assert(key != null),
        assert(label != null);

  /// Creates a Folder from a string value. It generates a unique key.
  factory Folder.fromLabel(String label) {
    String _key = FolderFunctions.generateRandom();
    return Folder(
      key: '${_key}_$label',
      label: label,
    );
  }

  /// Creates a Folder from a Map<String, dynamic> map. The map
  /// should contain a "label" value. If the key value is
  /// missing, it generates a unique key.
  factory Folder.fromMap(Map<String, dynamic> map) {
    String _key = map['key'];
    String _label = map['label'];
    var _data = map['data'];
    List<Folder> _children = [];
    if (_key == null) {
      _key = FolderFunctions.generateRandom();
    }
    if (map['children'] != null) {
      List<Map<String, dynamic>> _childrenMap = List.from(map['children']);
      _children = _childrenMap
          .map((Map<String, dynamic> child) => Folder.fromMap(child))
          .toList();
    }
    return Folder(
      key: '$_key',
      label: _label,
      data: _data,
      parent: FolderFunctions.truthful(map['parent']),
      children: _children,
    );
  }

  /// Creates a copy of this object but with the given fields
  /// replaced with the new values.
  Folder copyWith({
    String key,
    String label,
    List<Folder> children,
    bool parent,
    T data,
  }) =>
      Folder(
        key: key ?? this.key,
        label: label ?? this.label,
        parent: parent ?? this.parent,
        children: children ?? this.children,
        data: data ?? this.data,
      );

  /// Whether this object has children Folder.
  bool get isParent => children.isNotEmpty || parent;

  /// Whether this object has data associated with it.
  bool get hasData => data != null;

  /// Map representation of this object
  Map<String, dynamic> get asMap {
    Map<String, dynamic> _map = {
      "key": key,
      "label": label,
      "parent": parent,
      "children": children.map((Folder child) => child.asMap).toList(),
    };
    return _map;
  }

  @override
  String toString() {
    return JsonEncoder().convert(asMap);
  }

  @override
  int get hashCode {
    return hashValues(
      key,
      label,
      parent,
      children,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is Folder &&
        other.key == key &&
        other.label == label &&
        other.parent == parent &&
        other.data.runtimeType == T &&
        other.children.length == children.length;
  }
}
