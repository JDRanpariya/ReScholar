import 'dart:convert';

import 'package:rescholar/models/paper.dart';
import 'package:rescholar/models/papers_list.dart';

// Takes JSON string and returns an instance of PapersList() which is a list containing instances of Paper()
PapersList getPapersListFromJSON(String jsonString) {
  final _jsonObject = jsonDecode(jsonString);
  return PapersList.fromJson(_jsonObject);
}

// Takes JSON string and returns an instance of Paper()
Paper getPaperFromJSON(String jsonString) {
  final _jsonObject = jsonDecode(jsonString);
  return Paper.fromJson(_jsonObject);
}

// Merges the data between two instances of Paper()
Paper detailsMerger(Paper selectedResult, Paper pageDetails) {
  selectedResult.title ??= pageDetails.title;
  selectedResult.authors ??= pageDetails.authors;
  selectedResult.journal ??= pageDetails.journal;
  selectedResult.year ??= pageDetails.year;
  selectedResult.snippet ??= pageDetails.snippet;
  selectedResult.citations ??= pageDetails.citations;
  selectedResult.citationsLink ??= pageDetails.citationsLink;
  selectedResult.detailsLink ??= pageDetails.detailsLink;
  selectedResult.doi ??= pageDetails.doi;
  selectedResult.institutions ??= pageDetails.institutions;
  selectedResult.abstractText ??= pageDetails.abstractText;
  selectedResult.links ??= pageDetails.links;
  selectedResult.pdfLinks ??= pageDetails.pdfLinks;
  selectedResult.references ??= pageDetails.references;
  selectedResult.referencesLink ??= pageDetails.referencesLink;
  selectedResult.relatedLink ??= pageDetails.relatedLink;
  selectedResult.versions ??= pageDetails.versions;
  selectedResult.versionsLink ??= pageDetails.versionsLink;
  selectedResult.relatedTopics ??= pageDetails.relatedTopics;

  return selectedResult;
}
