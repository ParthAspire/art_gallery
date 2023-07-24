import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/common/color_constants.dart';
import 'package:art_gallery/app/common/image_constants.dart';
import 'package:art_gallery/app/screens/auth/login/controller/login_controller.dart';
import 'package:art_gallery/app/services/firebase_services.dart';
import 'package:art_gallery/app/utils/content_properties.dart';
import 'package:art_gallery/app/utils/text_styles.dart';
import 'package:art_gallery/app/widgets/common_auth_textfield_widget.dart';
import 'package:art_gallery/app/widgets/common_textfield_widget.dart';
import 'package:art_gallery/app/widgets/divider_widget.dart';
import 'package:art_gallery/app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: kColorWhite,
          // 6495ED (CornflowerBlue ), 00BFFF(DeepSkyBlue), 87CEFA(LightSkyBlue )
          // appBar: AppBar(
          //   title: Text(appName.toUpperCase(), style: TextStyles.kH24WhiteBold),
          //   automaticallyImplyLeading: false,
          //   centerTitle: false,
          //   backgroundColor: kColorPrimary,
          // ),
          body: Padding(
            padding: const EdgeInsets.all(kHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                      decoration: BoxDecoration(
                          color: kColorWhite,
                          borderRadius: BorderRadius.circular(4)),
                      child:
                          SvgPicture.asset(kIconApp, height: 100, width: 100)),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 30),
                    child: Text(kLogin.toUpperCase(),
                        style: TextStyles.kH28BlackBold),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          kMobileNumber,
                          style: TextStyles.kH14BlackBold700,
                        ),
                      ),
                      commonAuthTextField(
                          controller: controller.mobileNumberController,
                          hintText: kHintMobileNumber,
                          preFixIcon: Padding(
                            padding: const EdgeInsets.only(top: 15, left: 16),
                            child: Text('+91'),
                          ),
                          maxLength: 10,
                          keyboardType: TextInputType.phone),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        kPassword,
                        style: TextStyles.kH14BlackBold700,
                      ),
                    ),
                    commonAuthTextField(
                      controller: controller.passwordController,
                      hintText: kHintPassword,
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.height * .06),
                  child: primaryButton(
                      onPress: () async {
                        // String str =
                        await FirebaseServices().sendOtpToMobileNumber(
                          phoneNumber:
                              controller.mobileNumberController.text.trim(),
                        );
                        controller.navigateToOtpScreen();
                      },
                      buttonTxt: kLogin),
                ),

                Row(
                  children: [
                    horizontalDividerWidget(width: Get.width * .35),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(kOr,
                          style: TextStyles.kH16BlackBold400,
                          textAlign: TextAlign.center),
                    ),
                    horizontalDividerWidget(width: Get.width * .35),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    controller.loginAsViewer(isAdmin: false);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 32, right: 32, top: 40),
                    decoration: BoxDecoration(
                      color: kColorWhite,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: kColorPrimary),
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: kColorWhite,
                            borderRadius: BorderRadius.circular(8),
                            // border: Border.all(color: kColorPrimary),
                          ),
                          child: SvgPicture.asset(kIconGoogle),
                          margin: const EdgeInsets.all(8),
                        ),
                        SizedBox(
                          width: Get.width * .55,
                          child: Text(kContinueWithGoogle,
                              style: TextStyles.kH20BlackBold,
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(bottom: 4),
                //       child: Text(
                //         kEmail,
                //         style: TextStyles.kH14BlackBold700,
                //       ),
                //     ),
                //     commonAuthTextField(
                //       controller: controller.emailController,
                //       hintText: kHintEmail,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  tempWidget() {
    Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            height: 450,
            width: 450,
            child: SvgPicture.asset(
              kImgLogin,
              excludeFromSemantics: true,
              fit: BoxFit.fill,
            )),
        SizedBox(
          height: Get.height * .9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 20),
                child: Text(kHelloArtLovers, style: TextStyles.kH24PrimaryBold),
              ),
              Expanded(
                child: Column(
                  children: [
                    /// admin container
                    GestureDetector(
                      onTap: () {
                        controller.loginAsViewer(isAdmin: true);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 32, right: 32, top: Get.height * .5),
                        decoration: BoxDecoration(
                          color: kColorWhite,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: kColorPrimary),
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: kColorWhite,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: kColorPrimary),
                              ),
                              child: SvgPicture.asset(kIconGoogle),
                              margin: const EdgeInsets.all(8),
                            ),
                            SizedBox(
                              width: Get.width * .55,
                              child: Text(kAdmin.toUpperCase(),
                                  style: TextStyles.kH24PrimaryBold,
                                  textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: Get.width * .35,
                            height: .5,
                            margin: EdgeInsets.only(left: 16),
                            color: kColorGray98,
                          ),
                          Text(kOr.toUpperCase(),
                              style: TextStyles.kH18Grey98Bold400),
                          Container(
                            width: Get.width * .35,
                            height: .5,
                            margin: EdgeInsets.only(right: 16),
                            color: kColorGray98,
                          ),
                        ],
                      ),
                    ),

                    /// visitor container
                    GestureDetector(
                      onTap: () {
                        controller.loginAsViewer(isAdmin: false);
                      },
                      child: Container(
                        margin:
                            const EdgeInsets.only(left: 32, right: 32, top: 20),
                        decoration: BoxDecoration(
                          color: kColorPrimary,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: kColorPrimary),
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: kColorWhite,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: kColorPrimary),
                              ),
                              child: SvgPicture.asset(kIconGoogle),
                              margin: const EdgeInsets.all(8),
                            ),
                            SizedBox(
                              width: Get.width * .55,
                              child: Text(kVisitor.toUpperCase(),
                                  style: TextStyles.kH24WhiteBold,
                                  textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
