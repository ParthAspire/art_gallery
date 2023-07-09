import 'package:art_gallery/app/model/user_data.dart';
import 'package:art_gallery/app/screens/dashboard/settings/base/controller/settings_base_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalDetailsController extends GetxController {
  TextEditingController personNameController = TextEditingController();
  TextEditingController personEmailController = TextEditingController();

  Rx<UserData> userData = UserData().obs;

  @override
  void onInit() {
    userData.value = Get.find<SettingsBaseController>().userData;
    personNameController.text = userData.value.name ?? '';
    personEmailController.text = userData.value.email ?? '';
    super.onInit();
  }
}
