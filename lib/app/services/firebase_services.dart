import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/model/firebase_auth_model.dart';
import 'package:art_gallery/app/utils/alert_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  static final FirebaseAuthenticationModel _mAuthModel =
      FirebaseAuthenticationModel();

  /// send otp to user mobile number
  Future<FirebaseAuthenticationModel> sendOtpToMobileNumber(
      {required String phoneNumber}) async {
    try {
      var countryCode = '+91';
      await auth.verifyPhoneNumber(
        phoneNumber: '$countryCode$phoneNumber',
        timeout: const Duration(seconds: 120),
        verificationCompleted: (phoneAuthCredential) async {
          // UserCredential userCredential =
          //     await _mFirebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          print('verificationFailed $error');
        },
        codeSent: (String verificationId, forceResendingToken) {
          print('codeSent $verificationId');
          _mAuthModel.otpVerificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );

      return _mAuthModel;
    } catch (e) {
      print('sendOtpToMobileNumber $e');
      return _mAuthModel;
    }
  }

  /// Verify user otp if entered manually
  Future<FirebaseAuthenticationModel> verifyUserOtp(String otp) async {
    try {
      PhoneAuthCredential? phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: _mAuthModel.otpVerificationId, smsCode: otp);

      try {
        // 1. Verify Otp and create user account
        UserCredential? userCredential =
            await auth.signInWithCredential(phoneAuthCredential);

        final idToken = await userCredential.user?.getIdToken();
        _mAuthModel.idToken = idToken ?? '';
        print('idToken ${_mAuthModel.idToken}');
        ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(SnackBar(
          content: Text('OTP verified successfully.'),
        ));
      } catch (ex) {
        print('verifyUserOtp $ex');
      }

      // Get.find<AlertMessageUtils>().hideProgressDialog();
      _mAuthModel.isOtpVerified = true;
      return _mAuthModel;
    } catch (ex) {
      // Get.find<AlertMessageUtils>().hideProgressDialog();
      _mAuthModel.isOtpVerified = false;
      print('otp failed $ex');
      // if (ex is FirebaseAuthException) {
      //   LoggerUtils.logException('verifyUserOtp', ex.message);
      //   if (ex.code == kFcmCodeInvalidVerificationCode ||
      //       ex.code == kFcmCodeInvalidVerificationId ||
      //       ex.code == kFcmCodeSessionExpired) {
      //     Get.toNamed(kRouteVerifyOtpSuccessScreen,
      //         arguments: [false, ex.code, otp]);
      //   }
      // }
      return _mAuthModel;
    }
  }

  /// create account using firebase
  Future<User?> createAccount(
      {required String name,
      required String email,
      required String password,
      required String photoUrl,
      required bool isAdmin,
      String? mobileNo}) async {
    try {
      User? user = (await auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user != null) {
        String? deviceToken = await FirebaseMessaging.instance.getToken();

        print('uid :: ${user.uid}');
        user.updateEmail(email);
        user.updateDisplayName(name);
        user.updatePhotoURL(photoUrl);
        user.updatePassword(password);
        user.updatePassword(mobileNo??'');
        await fireStore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'mobile_no': mobileNo,
          'isAdmin': isAdmin,
          'password': password,
          'photoUrl': photoUrl,
          'deviceToken': deviceToken,
          'uid': user.uid,
        });
        return user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AlertMessages().showErrorToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        AlertMessages()
            .showErrorToast('The account already exists for that email.');
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AlertMessages().showErrorToast('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        AlertMessages().showErrorToast('Wrong password provided.');
      }
    } catch (e) {
      debugPrint('login with firebase ::: $e');
    }
    return null;
  }

  /// check if user exist or not
  Future<bool> isUserExist(
      {bool isSocialLogin = true,
      String? mobileNo,
      GoogleSignIn? gmailData}) async {
    try {
      bool isExist = false;
      await fireStore
          .collection('users')
          .where(isSocialLogin ? 'email' : 'mobile_no',
              isEqualTo:
                  isSocialLogin ? gmailData?.currentUser?.email : mobileNo)
          .get()
          .then((value) {
        value.size > 0 ? isExist = true : isExist = false;
      });
      return isExist;
    } catch (e) {
      return false;
    }
  }

  /// check is product already exist or not
  Future<bool> isProductExist({required String fileName}) async {
    try {
      bool isExist = false;
      await fireStore
          .collection('products')
          .where('email', isEqualTo: fileName)
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
