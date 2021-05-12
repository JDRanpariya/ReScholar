import 'package:flutter/material.dart';

import 'package:rescholar/utils/library_storage.dart';

class UserLibrary extends ChangeNotifier {
  ////// INTERNAL PRIVATE STATE OF [UserLibrary] //////
  Map<String, dynamic> _userLibrary;
  Map<String, dynamic> _libraryPaperCount;
  List<Map<String, dynamic>> _folderTree;
  List<Map<String, dynamic>> _papers;

  ////// VARIABLE GETTERS //////
  /// Getter for the [userLibrary] Map.
  Map<String, dynamic> get userLibrary => _userLibrary;

  /// Getter for the [libraryPaperCount] Map.
  Map<String, dynamic> get libraryPaperCount => _libraryPaperCount;

  /// Getter for the [folderTree] List.
  List<Map<String, dynamic>> get folderTree => _folderTree;

  /// Getter for the [papers] List.
  List<Map<String, dynamic>> get papers => _papers;

  /////// I/O - RELATED FUNCTIONS //////
  /// Initialises the value of _userLibrary from the file system. This method is
  /// only meant to be called inside the initState() of the Library widget to prevent
  /// reading outdated data from the file before a write operation.
  Future<int> initRead() async {
    _userLibrary = await LibraryStorage().readUserLibrary();
    _libraryPaperCount = _userLibrary["libraryPaperCount"];
    _folderTree = List<Map<String, dynamic>>.from(_userLibrary["folderTree"]);
    _papers = List<Map<String, dynamic>>.from(_userLibrary["papers"]);
    return 1;
  }

  /// Merges the [libraryPaperCount], [folderTree], and [papers], back into the [userLibrary]
  /// to prep for writing to file.
  void mergeBackUserLibrary() {
    _userLibrary["libraryPaperCount"] = _libraryPaperCount;
    _userLibrary["folderTree"] = _folderTree;
    _papers = _papers;
    notifyListeners();
  }

  ////// LIBRARY FUNCTIONS //////
  /// Returns the papers belonging to the specified library section.
  List<Map<String, dynamic>> getPapersInLibrary(String librarySection,
      [String folderKey]) {
    List<Map<String, dynamic>> _filteredPapers = [];
    Map<String, dynamic> _item;

    // This if-statement is necessary to handle building the Library if the number
    // of papers are null
    if (_papers == null) return null;

    switch (librarySection) {
      case "Papers":
        for (_item in _papers) {
          if (_item["paperProperties"]["folderKey"] == "None" &&
              _item["paperProperties"]["isDeleted"] == false &&
              _item["paperProperties"]["isArchived"] == false)
            _filteredPapers.add(_item);
        }
        break;
      case "Favourites":
        for (_item in _papers) {
          if (_item["paperProperties"]["isFavourite"] == true &&
              _item["paperProperties"]["isDeleted"] == false)
            _filteredPapers.add(_item);
        }
        break;
      case "Archive":
        for (_item in _papers) {
          if (_item["paperProperties"]["isArchived"] == true &&
              _item["paperProperties"]["isDeleted"] == false)
            _filteredPapers.add(_item);
        }
        break;
      case "Recycle Bin":
        for (_item in _papers) {
          if (_item["paperProperties"]["folderKey"] == "None" &&
              _item["paperProperties"]["isDeleted"] == false &&
              _item["paperProperties"]["isArchived"] == false)
            _filteredPapers.add(_item);
        }
        break;
      case "Folders":
        for (_item in _papers) {
          if (_item["paperProperties"]["folderKey"] != "None" &&
              _item["paperProperties"]["isDeleted"] == false &&
              _item["paperProperties"]["isArchived"] ==
                  false) if (_item["paperProperties"]["folderKey"] == folderKey)
            _filteredPapers.add(_item);
        }
        break;
      default:
    }
    return _filteredPapers;
  }

  /// Adds a new paper or an existing paper to a section of the [UserLibrary].
  void addToLibrary(String librarySection,
      [Map<String, dynamic> paperToAdd,
      int indexInUserLibrary,
      String folderKey]) {
    switch (librarySection) {
      case "Papers":
        _papers.add(paperToAdd);
        break;
      case "Favourites":
        _papers[indexInUserLibrary]["paperProperties"]["isFavourite"] = true;
        break;
      case "Archive":
        _papers[indexInUserLibrary]["paperProperties"]["isArchived"] = true;
        break;
      case "Recycle Bin":
        _papers[indexInUserLibrary]["paperProperties"]["isDeleted"] = true;
        break;
      case "Folders":
        _papers[indexInUserLibrary]["paperProperties"]["folderKey"] = folderKey;
        break;
      default:
    }
  }

  /// Removes a paper specified at index from the [UserLibrary].
  void removeFromLibrary(String librarySection, int indexInUserLibrary,
      [String folderKey]) {
    switch (librarySection) {
      case "Papers":
        _papers[indexInUserLibrary]["paperProperties"]["isDeleted"] = true;
        break;
      case "Favourites":
        _papers[indexInUserLibrary]["paperProperties"]["isFavourite"] = false;
        break;
      case "Archive":
        _papers[indexInUserLibrary]["paperProperties"]["isArchived"] = false;
        break;
      case "Recycle Bin":
        _papers.removeAt(indexInUserLibrary);
        break;
      case "Folders":
        _papers[indexInUserLibrary]["paperProperties"]["folderKey"] = "None";
        break;
      default:
    }
  }

  ////// TESTING FUNCTION //////
  /// Used for testing changes.
  void testChange() {
    _papers[0]["title"] = "The title has changed again, bitches!";
    notifyListeners();
  }
}
