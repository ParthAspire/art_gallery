import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/common/color_constants.dart';
import 'package:art_gallery/app/common/image_constants.dart';
import 'package:art_gallery/app/screens/on_boarding/controller/on_boarding_controller.dart';
import 'package:art_gallery/app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends GetView<OnBoardingController> {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return IntroductionScreen(
          showDoneButton: true,
          showNextButton: true,
          showSkipButton: true,
          done: Text(kDone),
          next: Container(
              height: 40,
              width: 40,
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: kColorPrimary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset(
                kIconNextArrow,
                color: kColorWhite,
              )),
          skip: Text(kSkip, style: TextStyles.kH14PrimaryBold),
          onDone: () {},
          pages: controller.pageViewModelList,
          dotsDecorator:
              DotsDecorator(color: Colors.grey, activeColor: kColorPrimary),
        );
      }),
    );
  }
}
