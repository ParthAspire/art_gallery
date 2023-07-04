import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingController extends GetxController {
  RxList<PageViewModel> pageViewModelList =
      List<PageViewModel>.empty(growable: true).obs;

  @override
  void onInit() {
    addPageViewData();
    super.onInit();
  }

  void addPageViewData() {
    pageViewModelList.add(
      PageViewModel(
        title: "Title of introduction page",
        body: "Welcome to the app! This is a description of how it works.",
        image: const Center(
          child: Icon(Icons.waving_hand, size: 50.0),
        ),
      ),
    );
    pageViewModelList.add(
      PageViewModel(
        title: "Title of blue page",
        body:
            "Welcome to the app! This is a description on a page with a blue background.",
        image: Center(
          child: Image.network("https://example.com/image.png", height: 175.0),
        ),
        decoration: const PageDecoration(
          pageColor: Colors.blue,
        ),
      ),
    );
    pageViewModelList.add(
      PageViewModel(
        title: "Title of orange text and bold page",
        body:
            "This is a description on a page with an orange title and bold, big body.",
        image: const Center(
          child: Text("👋", style: TextStyle(fontSize: 100.0)),
        ),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(color: Colors.orange),
          bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
        ),
      ),
    );
  }
}
