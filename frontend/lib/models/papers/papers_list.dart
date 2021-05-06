import 'package:rescholar/models/papers/paper.dart';

/// Data Model for a list of research papers (eg. List of JSON objects returned in search results).
class PapersList {
  final List<Paper> papers;

  PapersList({this.papers});

  /// Maps a list of JSON objects to a list of [Paper] objects.
  factory PapersList.fromJson(List<dynamic> _jsonString) {
    List<Paper> papers = [];
    papers = _jsonString.map((i) => Paper.fromJson(i)).toList();

    return PapersList(papers: papers);
  }
}
