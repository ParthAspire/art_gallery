import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialMediaServices {
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<GoogleSignIn?> loginWithGmail() async {
    try {
      await googleSignIn.signIn();
      return googleSignIn;
    } catch (e) {
      debugPrint('loginWithGmail exception :: $e ');
      return null;
    }
  }
}
