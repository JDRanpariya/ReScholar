class Paper {
  final String title;
  final String authors;
  final String journal;
  final String year;
  final String snippet;

  Paper({this.title, this.authors, this.journal, this.year, this.snippet});

  factory Paper.fromJson(Map<String, dynamic> json) {
    return Paper(
      title: json['title'],
      authors: json['authors'],
      journal: json['journal'],
      year: json['year'],
      snippet: json['snippet'],
    );
  }
}
