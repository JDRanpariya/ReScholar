import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:rescholar/models/rescholar_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create User object based on Firebase User
  ReScholarUser _firebaseUser(User user) {
    if (user != null) {
      return user.isAnonymous == false
          ? ReScholarUser(user.uid, user.displayName, user.email)
          : ReScholarUser(user.uid, null, null);
    } else {
      return null;
    }
  }

  // Return changes in Auth State
  Stream<ReScholarUser> get user {
    return _auth
        .authStateChanges()
        .map(_firebaseUser); // (User user) => _firebaseUser(user) [Tear-off]
  }

  // Signing out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  ////// ACCOUNTS //////

  // -- Guest Account
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User guestUser = result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // -- Google Account
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    try {
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      User googleUser = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        print("An account exists with a different credential!");
        return null;
      } else if (e.code == 'invalid-credential') {
        print("Invalid Credentials!");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
