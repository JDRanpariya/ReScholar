import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rescholar/widgets/card_list_builder.dart';
import 'package:rescholar/widgets/header.dart';
import 'package:rescholar/widgets/navigation_drawer.dart';
import 'package:rescholar/widgets/option_bar.dart';
import 'package:rescholar/models/rescholar_user.dart';
import 'package:rescholar/services/auth.dart';
import 'package:rescholar/widgets/folder_bar.dart';

/// Builds a Library page that displays a [Header], (optional) Greeting,
/// (optional) [FolderBar], (optional) [OptionBar], and the list of papers present
/// in the current library section.
class Library extends StatefulWidget {
  final Header header;
  final bool renderGreeting;
  final FolderBar folderBar;
  final OptionBar optionBar;
  final List<Map<String, dynamic>> papers;

  Library(
      {Key key,
      @required this.header,
      this.renderGreeting = false,
      this.folderBar,
      this.optionBar,
      @required this.papers})
      : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ReScholarUser>(context);
    final AuthService _auth = AuthService();

    return Scaffold(
      backgroundColor: Colors.black87,
      drawer: NavigationDrawer(),
      appBar: widget.header,
      body: user.isAnonymous == false
          ? Column(
              children: [
                if (widget.renderGreeting == true)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                    child: Text(
                      "What would you like to read about today, ${user.username}? ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFFC27A)),
                    ),
                  ),
                if (widget.folderBar != null) widget.folderBar,
                if (widget.optionBar != null) widget.optionBar,
                Expanded(child: CardListBuilder(papers: widget.papers)),
              ],
            )
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  onTap: () async {
                    dynamic user = await _auth.signInWithGoogle();
                    if (user == null) {
                      debugPrint("DEBUG: Error signing in with Google");
                    } else {
                      debugPrint(
                          "DEBUG: Google user has signed in successfully");
                      debugPrint("DEBUG: $user");
                    }
                  },
                  child: Container(
                      height: 50,
                      width: 215,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          color: Color(0x404880DE)),
                      alignment: Alignment.center,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image(
                              image: AssetImage("assets/icons/google_logo.png"),
                              height: 25.0,
                              width: 25.0,
                            ),
                            Text("Sign in using Google",
                                style: TextStyle(fontSize: 16))
                          ])),
                ),
                SizedBox(height: 20.0),
                Text("Sign in with Google to add papers to library"),
              ],
            )),
    );
  }
}
