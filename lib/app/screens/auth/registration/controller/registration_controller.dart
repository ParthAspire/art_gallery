import 'dart:io';

import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/common/route_constants.dart';
import 'package:art_gallery/app/model/user_data.dart';
import 'package:art_gallery/app/services/firebase_services.dart';
import 'package:art_gallery/app/widgets/snack_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Rx<File> selectedImages = File('').obs;

  Future<void> selectImageFromGallery() async {
    ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then(
      (value) {
        selectedImages.value = File(value?.path ?? '');
      },
    );
  }

  navigateToLoginScreen() {
    Get.offAllNamed(kRouteLoginScreen);
  }

  void clearSelectedImageData() {
    selectedImages.value = File('');
  }

  Future<void> registerDataIntoFirebase({bool isAdmin = false}) async {
    // if ( != null) {
    bool isExist = await FirebaseServices().isUserExist(
      isSocialLogin: false,
      mobileNo: mobileNumberController.text.trim(),
    );
    if (isExist == true) {
      snackBarWidget(Get.overlayContext!, kErrorUserAlreadyExist);
    } else {
      String? deviceToken = await FirebaseMessaging.instance.getToken();
      UserData userData = UserData(
        mobileNo: mobileNumberController.text.trim(),
        isAdmin: false,
        deviceToken: deviceToken,
        email: emailController.text.trim(),
        name: nameController.text.trim(),
        photoUrl: '',
      );
      await FirebaseServices()
          .createAccount(
              name: userData.name ?? 'user',
              email: userData.email ?? 'user@gmail.com',
              password: passwordController.text.trim(),
              photoUrl: userData.photoUrl ?? '',
              isAdmin: isAdmin,
              mobileNo: userData.mobileNo?.replaceAll('-',''))
          .then((userData) {
        if (userData != null) {
          navigateToLoginScreen();
        } else {}
      });
    }
    // }
  }
}
