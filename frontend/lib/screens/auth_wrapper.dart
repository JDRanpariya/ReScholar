import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rescholar/screens/Authentication/authenticate.dart';
import 'package:rescholar/models/user.dart';
import 'package:rescholar/widgets/navigation_bar.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserR>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return NavigationBar();
    }
  }
}
