import 'package:rescholar/models/paper.dart';

// Model for a list of research papers (eg. List of JSON objects returned in search results)
class PapersList {
  final List<Paper> papers;

  PapersList({this.papers});

  factory PapersList.fromJson(List<dynamic> _jsonString) {
    List<Paper> papers = [];
    papers = _jsonString.map((i) => Paper.fromJson(i)).toList();

    return PapersList(papers: papers);
  }
}
