import 'package:firebase_auth/firebase_auth.dart';
import 'package:rescholar/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on User ( from firebase )
  UserR _useFromFirebasUser(User user) {
    return user != null ? UserR(user.uid, user.uid, user.uid) : null;
  }

  Stream<UserR> get user {
    return _auth.authStateChanges().map(
        _useFromFirebasUser); // (User user) => _useFromFirebasUser(user) it's calledd tear-off
  }

  // sign in anon

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in email pass

  // register with email pass

  // sign in with google

  // register with google

  // sign out
}
