import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rescholar/screens/authentication/authenticate.dart';
import 'package:rescholar/models/rescholar_user.dart';
import 'package:rescholar/widgets/navigation_bar.dart';
import 'package:rescholar/models/user_library.dart';

/// Checks for user authentication and decides whether user is directed to the
/// home page or the authentication page.
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ReScholarUser>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return ChangeNotifierProvider<UserLibrary>(
        create: (context) => UserLibrary(),
        child: NavigationBar(),
      );
    }
  }
}
