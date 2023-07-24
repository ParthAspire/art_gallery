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
  static String _verificationId = "";




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





  /// send otp to phone number
  verifyPhoneNumber(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification if the phone number can be automatically verified
          await auth.signInWithCredential(credential);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Phone number automatically verified.'),
          ));
          print('Phone number automatically verified.');
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Phone number verification failed: ${e.message}'),
          ));
          print('Phone number verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to verify phone number: $e'),
      ));
    }
  }

  validateOtp({required String otpCode}) async {
    // PhoneAuthCredential credential = PhoneAuthProvider.credential(
    //     verificationId: FirebaseServices.verify, smsCode: otpCode);
    // await auth.signInWithCredential(credential);
    // try {

    print('FirebaseServices.verify :: ${FirebaseServices._verificationId}');
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: FirebaseServices._verificationId, smsCode: otpCode);
    await auth.signInWithCredential(credential).then((value) {
      print('value ::: ${value}');
    });
    // } catch (e) {
    //   ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
    //       const SnackBar(content: Text("Wrong OTP! Please enter again")));
    //   print("Wrong OTP");
    // }
  }

  Future<void> signInWithOTP(BuildContext context,
      {required String otpCode}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: FirebaseServices._verificationId,
        smsCode: otpCode,
      );
      await auth.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('OTP verification successful.'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to sign in with OTP: $e'),
      ));
      print('Failed to sign in with OTP: $e');
    }
  }

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
