import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:rescholar/models/rescholar_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // FIREBASE USER
  /// Creates a User object based on Firebase User
  ReScholarUser _firebaseUser(User user) {
    if (user != null) {
      return user.isAnonymous == false
          ? ReScholarUser(user.uid, user.photoURL, user.displayName, user.email,
              user.isAnonymous)
          : ReScholarUser(
              user.uid, user.uid, user.uid, user.uid, user.isAnonymous);
    } else {
      return null;
    }
  }

  // AUTH CHANGE HANDLER
  /// Returns changes to the Auth State
  Stream<ReScholarUser> get user {
    return _auth
        .authStateChanges()
        .map(_firebaseUser); // (User user) => _firebaseUser(user) [Tear-off]
  }

  // SIGN OUT HANDLER
  /// Handles a sign out event irrespective of the account type.
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      debugPrint("DEBUG: " + e.toString());
      return null;
    }
  }

  ////// ACCOUNTS //////

  // GUEST USER
  /// Handles a sign in event into a guest account.
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User guestUser = result.user;
      return _firebaseUser(guestUser);
    } catch (e) {
      debugPrint("DEBUG: " + e.toString());
      return null;
    }
  }

  // GOOGLE USER
  /// Handles a sign in event into a Google account.
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
      return _firebaseUser(googleUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        debugPrint("DEBUG: An account exists with a different credential");
        return null;
      } else if (e.code == 'invalid-credential') {
        debugPrint("DEBUG: Invalid Credentials");
        return null;
      }
    } catch (e) {
      debugPrint("DEBUG: " + e.toString());
      return null;
    }
  }
}
