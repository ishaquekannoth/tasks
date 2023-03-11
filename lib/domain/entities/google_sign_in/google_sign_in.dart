import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInRepo {
  final _googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInWithGoogleAccount() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      } else {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        OAuthCredential credentials = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credentials);

        log(userCredential.user!.toString());
        return userCredential;
      }
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      return null;
    }on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
