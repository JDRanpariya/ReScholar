import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rescholar/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on User ( from firebase )
  UserR _useFromFirebasUser(User user) {
    if (user != null) {
      return user.isAnonymous == false
          ? UserR(user.uid, user.displayName, user.email)
          : UserR(user.uid, null, null);
    } else {
      return null;
    }
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

  // sign in google

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

      User googleuser = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        print("account-exists-with-different-credential");
        return null;
      } else if (e.code == 'invalid-credential') {
        print("Invalid Credentials");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  //
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
