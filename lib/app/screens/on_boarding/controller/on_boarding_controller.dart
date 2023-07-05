import 'package:art_gallery/app/common/image_constants.dart';
import 'package:art_gallery/app/common/route_constants.dart';
import 'package:art_gallery/app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        title: "Confused.? What to buy..?",
        body:
            "We have a solution \"Art Gallery\".! Let's take a small tour... ",
        decoration: const PageDecoration(
            bodyPadding: EdgeInsets.symmetric(horizontal: 16),
            bodyTextStyle: TextStyles.kH18BlackBold400,
            titleTextStyle: TextStyles.kH20BlackBold),
        image: Padding(
          padding: EdgeInsets.only(top: 80),
          child: SvgPicture.asset(kImgOnBoardingOne),
        ),
      ),
    );
    pageViewModelList.add(
      PageViewModel(
        title: "Title of introduction page",
        body: "Welcome to the app! This is a description of how it works.",
        decoration: const PageDecoration(
            bodyPadding: EdgeInsets.symmetric(horizontal: 16),
            bodyTextStyle: TextStyles.kH18BlackBold400,
            titleTextStyle: TextStyles.kH20BlackBold),
        image: Container(
          margin: EdgeInsets.only(top: 40),
          height: 500,
          child: SvgPicture.asset(kImgOnBoardingTwo),
        ),
      ),
    );
    pageViewModelList.add(
      PageViewModel(
        title: "Title of introduction page",
        body: "Welcome to the app! This is a description of how it works.",
        decoration: const PageDecoration(
            bodyPadding: EdgeInsets.symmetric(horizontal: 16),
            bodyTextStyle: TextStyles.kH18BlackBold400,
            titleTextStyle: TextStyles.kH20BlackBold),
        image: Center(
          child: SvgPicture.asset(kImgOnBoardingThree),
        ),
      ),
    );
  }

  void navigateToLoginScreen() {
    Get.offAllNamed(kRouteLoginScreen);
  }
}
