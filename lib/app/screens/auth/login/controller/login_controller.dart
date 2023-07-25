import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/common/route_constants.dart';
import 'package:art_gallery/app/services/firebase_services.dart';
import 'package:art_gallery/app/services/social_media_services.dart';
import 'package:art_gallery/app/utils/regex_data.dart';
import 'package:art_gallery/app/widgets/snack_bar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  RxBool isMobileNumberValid = false.obs;

  RxString errorMobileNumber = ''.obs;

  Future<void> validateUserInput() async {
    if (isMobileNumberValid.value &&
        mobileNumberController.text.trim().replaceAll('-', '').length == 10) {
      bool isExist = await FirebaseServices().isUserExist(
          isSocialLogin: false,
          mobileNo: mobileNumberController.text.trim().replaceAll('-', ''));
      if (isExist) {
        await FirebaseServices().sendOtpToMobileNumber(
          phoneNumber: mobileNumberController.text.trim(),
        );
        navigateToOtpScreen();
      } else {
        snackBarWidget(Get.overlayContext!, kErrorUserNotExist);
      }
    } else {
      mobileNumberValidation();
    }
  }

  void mobileNumberValidation() {
    isMobileNumberValid.value = false;
    if (mobileNumberController.text.trim().isEmpty) {
      errorMobileNumber.value = kErrorEnterMobileNumber;
    } else if (!RegexData.mobileNumberRegex
        .hasMatch(mobileNumberController.text.trim().replaceAll('-', ''))) {
      errorMobileNumber.value = kErrorMobileNumberDigit;
    } else if (mobileNumberController.text.trim().replaceAll('-', '').length !=
        10) {
      errorMobileNumber.value = kErrorMobileNumberDigit;
    } else {
      errorMobileNumber.value = '';
      isMobileNumberValid.value = true;
      validateUserInput();
    }
  }

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

  navigateToRegistrationScreen() {
    Get.toNamed(kRouteRegistrationScreen);
  }
}
