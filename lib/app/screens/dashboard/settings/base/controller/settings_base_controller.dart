import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/common/image_constants.dart';
import 'package:art_gallery/app/common/route_constants.dart';
import 'package:art_gallery/app/model/user_data.dart';
import 'package:art_gallery/app/screens/dashboard/home/base/controller/home_base_controller.dart';
import 'package:art_gallery/app/services/firebase_services.dart';
import 'package:art_gallery/app/services/social_media_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsBaseController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  UserData userData = UserData();
  RxBool isShowLoader = true.obs;

  RxList<SettingsListClass> settingsList =
      List<SettingsListClass>.empty(growable: true).obs;

  @override
  void onInit() {
    super.onInit();
  }

  addSettingsListData() {
    if (userData.isAdmin == true) {
      settingsList.add(SettingsListClass(
          settingName: kUsers, settingIcon: kIconProfileFilled));
    }
    settingsList.add(SettingsListClass(
        settingName: kPersonalDetails, settingIcon: kIconProfileDetails));
  }

  void logout() {
    FirebaseServices().auth.signOut();
    SocialMediaServices().googleSignIn.signOut();
    Get.offAllNamed(kRouteLoginScreen);
  }

  void getUserInfo() {
    userData = Get.find<HomeBaseController>().userData.value;
    if (userData.email != null) {
      addSettingsListData();
    }
  }

  void navigateToScreen(int index) {
    if (index == 0 && userData.isAdmin == true) {
      navigateToUserListingScreen();
    } else if (index == 0 && userData.isAdmin == false) {
      navigateToPersonalDetailsScreen();
    }
  }

  void navigateToUserListingScreen() {
    Get.toNamed(kRouteUsersListingScreen);
  }

  void navigateToPersonalDetailsScreen() {}
}

class SettingsListClass {
  String settingName;
  String settingIcon;

  SettingsListClass({required this.settingName, required this.settingIcon});
}
