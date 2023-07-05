import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/utils/alert_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  /// create account using firebase
  Future<User?> createAccount(
      {required String name,
      required String email,
      required String password,
      required String photoUrl,
      required bool isAdmin}) async {
    try {
      User? user = (await auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user != null) {
        String? deviceToken = await FirebaseMessaging.instance.getToken();

        user.updateEmail(email);
        user.updateDisplayName(name);
        user.updatePhotoURL(photoUrl);
        user.updatePassword(password);
        await fireStore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'isAdmin': isAdmin,
          'password': password,
          'photoUrl': photoUrl,
          'deviceToken': deviceToken,
          'uid': user.uid,
        });
        return user;
      }
    } catch (e) {
      debugPrint('signUp with firebase ::: $e');
      return null;
    }
    return null;
  }

  /// login with firebase
  Future<User?> login({required String email, required String password}) async {
    try {
      User? user = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        return user;
      } else {
        AlertMessages().showErrorToast(kErrorGmail);
      }
    } catch (e) {
      debugPrint('login with firebase ::: $e');
    }
    return null;
  }

  /// check if user exist or not
  Future<bool> isUserExist({required GoogleSignIn gmailData}) async {
    try {
      bool isExist = false;
      await fireStore
          .collection('users')
          .where('email', isEqualTo: gmailData.currentUser?.email)
          .get()
          .then((value) {
        value.size > 0 ? isExist = true : isExist = false;
      });
      return isExist;
    } catch (e) {
      return false;
    }
  }
}
