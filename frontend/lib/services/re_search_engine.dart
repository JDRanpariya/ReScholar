import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:rescholar/models/papers_list.dart';
import 'package:rescholar/utils/paper_functions.dart';

/// The search engine that makes HTTP requests to the Google Cloud backend to
/// retrieve search results from a variety of sources supported by ReScholar.
class ReSearchEngine {
  /// Retrieves search results from the GoogleScholar Google Cloud Function.
  Future<PapersList> fetchFromGoogleScholar(query, paperCount) async {
    final response = await http.get(Uri.https(
        'europe-west1-rescholar-ltwk.cloudfunctions.net',
        'GoogleScholar?q=${query}&paper_count=${paperCount}'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      debugPrint("DEBUG: " + response.body);
      return getPapersListFromJSON(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Papers');
    }
  }
}
