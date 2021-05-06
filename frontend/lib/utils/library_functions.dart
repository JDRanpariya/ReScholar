import 'package:rescholar/data/user_library.dart';

/// Utility Class containing functions to perform data retrieval and ammendment
/// to the [userLibrary].
class LibraryFunctions {
  /// Retrieves the papers belonging to a library section.
  static List<Map<String, dynamic>> getPapersInLibrary(String librarySection,
      [String folderKey]) {
    final papers = userLibrary["papers"];
    final List<Map<String, dynamic>> filteredPapers = [];
    Map<String, dynamic> iter = {};

    switch (librarySection) {
      case "Papers":
        for (iter in papers) {
          if (iter["paperProperties"]["folderKey"] == "None" &&
              iter["paperProperties"]["isDeleted"] == false &&
              iter["paperProperties"]["isArchived"] == false)
            filteredPapers.add(iter);
        }
        break;
      case "Favourites":
        for (iter in papers) {
          if (iter["paperProperties"]["isFavourite"] == true &&
              iter["paperProperties"]["isDeleted"] == false)
            filteredPapers.add(iter);
        }
        break;
      case "Archive":
        for (iter in papers) {
          if (iter["paperProperties"]["isArchived"] == true &&
              iter["paperProperties"]["isDeleted"] == false)
            filteredPapers.add(iter);
        }
        break;
      case "Recycle Bin":
        for (iter in papers) {
          if (iter["paperProperties"]["folderKey"] == "None" &&
              iter["paperProperties"]["isDeleted"] == false &&
              iter["paperProperties"]["isArchived"] == false)
            filteredPapers.add(iter);
        }
        break;
      case "Folders":
        for (iter in papers) {
          if (iter["paperProperties"]["folderKey"] != "None" &&
              iter["paperProperties"]["isDeleted"] == false &&
              iter["paperProperties"]["isArchived"] ==
                  false) if (iter["paperProperties"]["folderKey"] == folderKey)
            filteredPapers.add(iter);
        }
        break;
      default:
    }
    return filteredPapers;
  }

  static addToLibrary(String librarySection, Map<String, dynamic> paperToAdd,
      [int indexInUserLibrary, String folderKey]) {
    switch (librarySection) {
      case "Papers":
        userLibrary["papers"].add(paperToAdd);
        break;
      case "Favourites":
        userLibrary["papers"][indexInUserLibrary]["paperProperties"]
            ["isFavourite"] = true;
        break;
      case "Archive":
        userLibrary["papers"][indexInUserLibrary]["paperProperties"]
            ["isArchived"] = true;
        break;
      case "Recycle Bin":
        userLibrary["papers"][indexInUserLibrary]["paperProperties"]
            ["isDeleted"] = true;
        break;
      case "Folders":
        userLibrary["papers"][indexInUserLibrary]["paperProperties"]
            ["folderKey"] = folderKey;
        break;
      default:
    }
  }

  static removeFromLibrary(
      String librarySection, Map<String, dynamic> paperToAdd,
      [int indexInUserLibrary, String folderKey]) {
    switch (librarySection) {
      case "Papers":
        userLibrary["papers"].removeAt(indexInUserLibrary);
        break;
      case "Favourites":
        userLibrary["papers"][indexInUserLibrary]["paperProperties"]
            ["isFavourite"] = false;
        break;
      case "Archive":
        userLibrary["papers"][indexInUserLibrary]["paperProperties"]
            ["isArchived"] = false;
        break;
      case "Recycle Bin":
        userLibrary["papers"][indexInUserLibrary]["paperProperties"]
            ["isDeleted"] = false;
        break;
      case "Folders":
        userLibrary["papers"][indexInUserLibrary]["paperProperties"]
            ["folderKey"] = "None";
        break;
      default:
    }
  }
}
