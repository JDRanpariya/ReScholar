import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:rescholar/services/re_search_engine.dart';
import 'package:rescholar/data/user_library.dart';
// import 'package:rescholar/models/papers_list.dart';

/// Screen to interact with the [ReSearchEngine] service.
class ReSearch extends StatefulWidget {
  ReSearch({Key key}) : super(key: key);

  @override
  _ReSearchState createState() => _ReSearchState();
}

class _ReSearchState extends State<ReSearch> {
  // String _query = "";
  // String _paperCount = "";

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection // ref https://firebase.flutter.dev/docs/firestore/usage
    CollectionReference library =
        FirebaseFirestore.instance.collection('library');

    // add userLibrary to firestore TODO: add some hook to trigger library.set after every 5 min
    library.add(userLibrary);

    return Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("ReSearch Screen"),
          SizedBox(height: 15.0),
          ElevatedButton(
            onPressed: () /* async */ {
              // FutureBuilder<PapersList>(
              //   future: fetchFromGoogleScholar("osint", 5),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       return Text(snapshot.data.title);
              //     } else if (snapshot.hasError) {
              //       return Text("${snapshot.error}");
              //     }
              //     // To show a spinner while loading
              //     return CircularProgressIndicator();
              //   },
              // );
            },
            child: Text("Test Button"),
          ),
        ],
      )),
    );
  }
}
