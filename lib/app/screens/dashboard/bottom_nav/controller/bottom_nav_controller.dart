import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  RxInt selectedIndex = 0.obs;
  Rx<PageController>? pageController;

  @override
  void onInit() {
    pageController?.value = PageController(initialPage: selectedIndex.value);
    super.onInit();
  }
}
