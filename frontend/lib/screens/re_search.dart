import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:rescholar/services/re_search_engine.dart';
import 'package:rescholar/widgets/card_list_builder.dart';
// import 'package:rescholar/models/user_library.dart';

/// Screen to interact with the [ReSearchEngine] service.
class ReSearch extends StatefulWidget {
  ReSearch({Key key}) : super(key: key);

  @override
  _ReSearchState createState() => _ReSearchState();
}

class _ReSearchState extends State<ReSearch> {
  var _body;
  Widget _displaySearchResults() {
    return _body;
  }

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    // Reference: https://firebase.flutter.dev/docs/firestore/usage
    // CollectionReference library =
    //     FirebaseFirestore.instance.collection('library');

    // TODO: Sync the file present in AppData folder and not /rescholar/data/
    // TODO: Add hook to trigger library.set every 5 minutes
    // Add userLibrary to Firestore
    // library.add(userLibrary);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text("ReSearch",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                )),
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _body = FutureBuilder(
                      future: ReSearchEngine.fetchSearchResults("GoogleScholar",
                          "search_results", "residual learning", 10),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                            child: CardListBuilder(
                              papers: snapshot.data,
                              inLibrary: false,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text("ERROR: ${snapshot.error}");
                        }
                        return CircularProgressIndicator();
                      },
                    );
                  });
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(125, 40)),
                    backgroundColor:
                        MaterialStateProperty.all(Color(0x404880DE)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))))),
                child: Text(
                  "Search Google Scholar",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF4880DE),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (_body != null) SizedBox(width: 15.0),
              if (_body != null)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _body = null;
                    });
                  },
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(125, 40)),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0x40EB5757)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(30))))),
                  child: Text(
                    "Clear Results",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFEB5757),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 5.0),
          ElevatedButton(
            onPressed: () {
              /* vvvvvvvvvvvvvvvvvvvvvvvvv */
              /* vv Test Functions Here vv */
              /* vvvvvvvvvvvvvvvvvvvvvvvvv */
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(125, 40)),
                backgroundColor: MaterialStateProperty.all(Color(0x40B2B2B2)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))))),
            child: Text(
              "Test Button",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFB2B2B2),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          if (_body != null) _displaySearchResults(),
        ],
      ),
    );
  }
}
