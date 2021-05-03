import 'dart:convert';

import 'package:rescholar/models/paper.dart';
import 'package:rescholar/models/papers_list.dart';

/// Takes JSON string and returns an instance of [PapersList] which is a list containing instances of [Paper].
PapersList getPapersListFromJSON(String jsonString) {
  final _jsonObject = jsonDecode(jsonString);
  return PapersList.fromJson(_jsonObject);
}

/// Takes JSON string and returns an instance of [Paper].
Paper getPaperFromJSON(String jsonString) {
  final _jsonObject = jsonDecode(jsonString);
  return Paper.fromJson(_jsonObject);
}

/// Merges the data between two instances of [Paper].
Paper detailsMerger(Paper selectedResult, Paper pageDetails) {
  selectedResult
    ..title = selectedResult.title == "None"
        ? pageDetails.title
        : selectedResult.title
    ..authors = selectedResult.authors == ["None"]
        ? pageDetails.authors
        : selectedResult.authors
    ..journal = selectedResult.journal == "None"
        ? pageDetails.journal
        : selectedResult.journal
    ..year =
        selectedResult.year == "None" ? pageDetails.year : selectedResult.year
    ..snippet = selectedResult.snippet == "None"
        ? pageDetails.snippet
        : selectedResult.snippet
    ..citations = selectedResult.citations == "None"
        ? pageDetails.citations
        : selectedResult.citations
    ..citationsLink = selectedResult.citationsLink == "None"
        ? pageDetails.citationsLink
        : selectedResult.citationsLink
    ..detailsLink = selectedResult.detailsLink == "None"
        ? pageDetails.detailsLink
        : selectedResult.detailsLink
    ..doi = selectedResult.doi == "None" ? pageDetails.doi : selectedResult.doi
    ..institutions = selectedResult.institutions == "None"
        ? pageDetails.institutions
        : selectedResult.institutions
    ..abstractText = selectedResult.abstractText == "None"
        ? pageDetails.abstractText
        : selectedResult.abstractText
    ..links = selectedResult.links == ["None"]
        ? pageDetails.links
        : selectedResult.links
    ..pdfLinks = selectedResult.pdfLinks == ["None"]
        ? pageDetails.pdfLinks
        : selectedResult.pdfLinks
    ..references = selectedResult.references == "None"
        ? pageDetails.references
        : selectedResult.references
    ..referencesLink = selectedResult.referencesLink == "None"
        ? pageDetails.referencesLink
        : selectedResult.referencesLink
    ..relatedLink = selectedResult.relatedLink == "None"
        ? pageDetails.relatedLink
        : selectedResult.relatedLink
    ..versions = selectedResult.versions == "None"
        ? pageDetails.versions
        : selectedResult.versions
    ..versionsLink = selectedResult.versionsLink == "None"
        ? pageDetails.versionsLink
        : selectedResult.versionsLink
    ..relatedTopics = selectedResult.relatedTopics == ["None"]
        ? pageDetails.relatedTopics
        : selectedResult.relatedTopics;

  return selectedResult;
}
