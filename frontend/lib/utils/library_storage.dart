import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class LibraryStorage {
  Future<File> get _localUserLibraryPath async {
    final directory = await getApplicationDocumentsDirectory();
    final localUserLibraryPath = File('${directory.path}/userLibrary.json');
    return localUserLibraryPath;
  }

  Future<File> writeUserLibrary(Map<String, dynamic> _userLibrary) async {
    final file = await _localUserLibraryPath;
    return file.writeAsString(jsonEncode(_userLibrary));
  }

  Future<Map<String, dynamic>> readUserLibrary() async {
    try {
      final file = await _localUserLibraryPath;
      String contents = await file.readAsString();
      return jsonDecode(contents);
    } catch (e) {
      debugPrint("ERROR: $e");
      return {};
    }
  }
}
