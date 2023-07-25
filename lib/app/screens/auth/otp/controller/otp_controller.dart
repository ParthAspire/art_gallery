import 'package:art_gallery/app/common/route_constants.dart';
import 'package:art_gallery/app/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  TextEditingController otpController = TextEditingController();
  RxString otpText = ''.obs;
  RxString otp = ''.obs;

  RxString mobileNumber = ''.obs;

  setIntentData({required dynamic intentData}) {
    try {
      mobileNumber.value = (intentData[0] as String);
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> verifyOtp() async {
    await FirebaseServices().verifyUserOtp(otpText.value);
    Get.offAllNamed(kRouteBottomNavScreen);
  }

  resendOtp() async {
    await FirebaseServices().sendOtpToMobileNumber(
      phoneNumber: mobileNumber.value,
    );
  }
}
