import 'dart:convert';
import 'package:http/http.dart' as http;

/// The search engine that makes HTTP requests to the Google Cloud backend to
/// retrieve search results from a variety of sources supported by ReScholar.
class ReSearchEngine {
  /// Retrieves search results from the GoogleScholar Google Cloud Function.
  static Future fetchSearchResults(
      String source, String service, String query, int paperCount) async {
    final response = await http.get(Uri.https(
        'europe-west1-rescholar-ltwk.cloudfunctions.net',
        '$source',
        {"svc": service, "q": query, "paper_count": "$paperCount"}));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("ERROR: Failed to fetch search results");
    }
  }
}
