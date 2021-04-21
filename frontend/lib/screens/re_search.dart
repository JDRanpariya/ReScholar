import 'package:flutter/material.dart';
import 'package:rescholar/models/paper.dart';
import 'package:rescholar/services/search.dart';

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
        children: [
          Text("ReSearch Screen"),
          ElevatedButton(
            onPressed: () async {
              FutureBuilder<Paper>(
                future: fetchFromGoogleScholar("osint", 5),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.title);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // To show a spinner while loading
                  return CircularProgressIndicator();
                },
              );
            },
            child: Text("hi"),
          )
        ],
      )),
    );
  }
}
