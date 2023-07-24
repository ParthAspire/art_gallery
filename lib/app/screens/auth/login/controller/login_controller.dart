import 'package:art_gallery/app/common/route_constants.dart';
import 'package:art_gallery/app/services/firebase_services.dart';
import 'package:art_gallery/app/services/social_media_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> loginAsViewer({bool isAdmin = false}) async {
    GoogleSignIn? gmailData = await SocialMediaServices().loginWithGmail();

    if (gmailData != null) {
      bool isExist = await FirebaseServices().isUserExist(gmailData: gmailData);
      if (isExist == true) {
        await FirebaseServices()
            .login(
                email: gmailData.currentUser?.email ?? 'user@gmail.com',
                password: gmailData.currentUser?.email ?? 'user@gmail.com')
            .then((userData) {
          if (userData != null) {
            navigateToDashBoardScreen();
          } else {}
        });
      } else {
        await FirebaseServices()
            .createAccount(
                name: gmailData.currentUser?.displayName ?? 'user',
                email: gmailData.currentUser?.email ?? 'user@gmail.com',
                password: gmailData.currentUser?.email ?? 'user@gmail.com',
                photoUrl: gmailData.currentUser?.photoUrl ?? '',
                isAdmin: isAdmin)
            .then((userData) {
          if (userData != null) {
            navigateToDashBoardScreen();
          } else {}
        });
      }
    }
  }

  void navigateToDashBoardScreen() {
    Get.offAllNamed(kRouteBottomNavScreen);
  }

  void navigateToOtpScreen() {
    Get.toNamed(kRouteOtpScreen,
        arguments: [mobileNumberController.text.trim()]);
  }
}
