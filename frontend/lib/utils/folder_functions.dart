import 'dart:convert';
import 'dart:math';

import 'package:rescholar/models/folder.dart';
import 'package:rescholar/models/folder_tree.dart';

/// Contains functions relevant to the [Folder] model.
class FolderFunctions {
  /// Generates a random string as a key when a key is not available for a [Folder] in the [FolderTree].
  static String generateRandom([int length = 16]) {
    final Random _random = Random.secure();
    var values = List<int>.generate(length, (i) => _random.nextInt(256));
    return base64Url.encode(values).substring(0, length);
  }

  /// Changes all forms of boolean input into a boolean accepted by Dart.
  static bool truthful(value) {
    if (value == null) {
      return false;
    }
    if (value == true ||
        value == 'true' ||
        value == 1 ||
        value == '1' ||
        value.toString().toLowerCase() == 'yes') {
      return true;
    }
    return false;
  }

  /// Generate key for a new [Folder] based on parent key in the form of a folder path.
  String generateKey(FolderTree _folderTree, Folder _newFolder) {
    return _folderTree.getParent(_newFolder.key).key + _newFolder.label + "/";
  }
}
