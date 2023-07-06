import 'package:art_gallery/app/common/route_constants.dart';
import 'package:art_gallery/app/model/user_data.dart';
import 'package:art_gallery/app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBaseController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  Rx<UserData> userData = UserData().obs;
  RxBool isShowLoader = true.obs;

  @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }

  void getUserInfo() {
    try {
      FirebaseServices()
          .fireStore
          .collection('users')
          .doc(auth.currentUser?.uid)
          .get()
          .then((value) {
        DocumentSnapshot snap = value;
        userData.value = UserData.fromJson(snap.data() as Map<String, dynamic>);
        print('userData ::: ${userData.value.photoUrl}');
      });
      isShowLoader.value = false;
    } catch (e) {
      isShowLoader.value = false;
      debugPrint('getUserInfo ::: $e');
    }
  }

  navigateToAddProductScreen() {
    Get.toNamed(kRouteAddProductScreen);
  }
}
