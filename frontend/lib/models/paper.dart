/// Data Model for mapping a research paper from a JSON object to a Dart [Map].
class Paper {
  // Common Attributes (Used in card model)
  String title = "None";
  List authors = ["None"];
  String journal = "None";
  String year = "None";
  String snippet = "None";
  String citations = "None";
  String citationsLink = "None";
  String detailsLink = "None";

  // Extra Atrributes (Used in conjunction with Common Attributes to build the PaperDetails sheet)
  String doi = "None";
  String institutions = "None";
  String abstractText = "None";
  List links = ["None"];
  List pdfLinks = ["None"];
  String references = "None";
  String referencesLink = "None";
  String relatedLink = "None";
  String versions = "None";
  String versionsLink = "None";
  List relatedTopics = ["None"];

  Paper({
    this.title,
    this.authors,
    this.journal,
    this.year,
    this.snippet,
    this.citations,
    this.citationsLink,
    this.detailsLink,
    this.doi,
    this.institutions,
    this.abstractText,
    this.links,
    this.pdfLinks,
    this.references,
    this.referencesLink,
    this.relatedLink,
    this.versions,
    this.versionsLink,
    this.relatedTopics,
  });

  /// Maps a single JSON object to a [Paper] object.
  factory Paper.fromJson(Map<String, dynamic> jsonString) {
    return Paper(
      title: jsonString['title'],
      authors: jsonString['authors'],
      journal: jsonString['journal'],
      year: jsonString['year'],
      snippet: jsonString['snippet'],
      citations: jsonString['citations'],
      citationsLink: jsonString['citationsLink'],
      detailsLink: jsonString['detailsLink'],
      doi: jsonString['doi'],
      institutions: jsonString['institutions'],
      abstractText: jsonString['abstractText'],
      links: jsonString['links'],
      pdfLinks: jsonString['pdfLinks'],
      references: jsonString['references'],
      referencesLink: jsonString['referencesLink'],
      relatedLink: jsonString['relatedLink'],
      versions: jsonString['versions'],
      versionsLink: jsonString['versionsLink'],
      relatedTopics: jsonString['relatedTopics'],
    );
  }
}
