import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenImageController extends GetxController {
  RxList<String> imageUrlList = List<String>.empty(growable: true).obs;

  RxString productName = ''.obs;
  RxInt currentIndex = 0.obs;

  setIntentData({required dynamic intentData}) {
    try {
      productName.value = (intentData[0] as String);
      imageUrlList.addAll(intentData[1] as List<String>);
    } catch (e) {
      debugPrint('full screen intentData :: $e');
    }
  }
}
