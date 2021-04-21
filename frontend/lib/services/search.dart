import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rescholar/models/paper.dart';

Future<Paper> fetchFromGoogleScholar(query, itemCount) async {
  final response = await http.get(Uri.https(
      'europe-west1-rescholar-ltwk.cloudfunctions.net',
      'GoogleScholar?q=${query}&item_count=${itemCount}'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return Paper.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Papers');
  }
}
