import 'package:flutter/material.dart';

import 'package:rescholar/services/re_search_engine.dart';
import 'package:rescholar/models/papers_list.dart';

class ReSearch extends StatefulWidget {
  ReSearch({Key key}) : super(key: key);

  @override
  _ReSearchState createState() => _ReSearchState();
}

class _ReSearchState extends State<ReSearch> {
  String _query = "";
  String _itemCount = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("ReSearch Screen"),
          SizedBox(height: 15.0),
          ElevatedButton(
            onPressed: () async {
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
          )
        ],
      )),
    );
  }
}
