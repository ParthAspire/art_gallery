import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/common/color_constants.dart';
import 'package:art_gallery/app/common/image_constants.dart';
import 'package:art_gallery/app/screens/auth/otp/controller/otp_controller.dart';
import 'package:art_gallery/app/utils/content_properties.dart';
import 'package:art_gallery/app/utils/text_styles.dart';
import 'package:art_gallery/app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends GetView<OtpController> {
  OtpScreen({super.key}) {
    final intentData = Get.arguments;
    controller.setIntentData(intentData: intentData);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kColorWhite,
        appBar: AppBar(
          backgroundColor: kColorBlack,
          centerTitle: true,
          title:
              Text(kEnterCode.toUpperCase(), style: TextStyles.kH24WhiteBold),
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: SvgPicture.asset(kIconBackArrow, color: kColorWhite),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(kHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center(
              //   child: Container(
              //       padding: EdgeInsets.symmetric(vertical: 0, horizontal: 6),
              //       decoration: BoxDecoration(
              //           color: kColorWhite,
              //           borderRadius: BorderRadius.circular(4)),
              //       child: SvgPicture.asset(kIconApp, height: 100, width: 100)),
              // ),
              // Center(
              //   child: Padding(
              //     padding: const EdgeInsets.only(bottom: 20, top: 30),
              //     child: Text(kEnterCode.toUpperCase(),
              //         style: TextStyles.kH28BlackBold),
              //   ),
              // ),
              Obx(() {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(kOtpTextOne, style: TextStyles.kH16BlackBold400),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: kOtpTextTwo,
                                  style: TextStyles.kH16BlackBold400),
                              TextSpan(
                                  text: ' +91 ${controller.mobileNumber.value}',
                                  style: TextStyles.kH16BlackBold700)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              otpTextFields(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: kOtpTextThree,
                            style: TextStyles.kH14BlackBold400),
                        TextSpan(
                            text: '  ${kResend}',
                            style: TextStyles.kH14BlackBold700),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * .08),
                child: primaryButton(
                    onPress: () {
                      controller.verifyOtp();
                    },
                    buttonTxt: kVerify,
                    textStyles: TextStyles.kH18WhiteBold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget otpTextFields() {
    return Padding(
      padding: const EdgeInsets.only(
          left: kHorizontalPadding, right: kHorizontalPadding, top: 58),
      child: PinCodeTextField(
        appContext: Get.context!,
        controller: controller.otpController,
        length: 6,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (String value) {},
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(8),
          fieldHeight: 50,
          fieldWidth: 42,
          activeFillColor: kColorWhite,
          inactiveFillColor: kColorWhite,
          inactiveColor: kColorBlack,
          disabledColor: Colors.black,
          activeColor: kColorPrimary,
          selectedFillColor: kColorPrimary,
          selectedColor: kColorPrimary,
        ),
        cursorColor: Colors.black,
        onCompleted: (v) {
          // controller.isOtpEntered.value = true;
          controller.otpText.value = v;
        },
        validator: (v) {
          if (v!.length < 3) {
            return "";
          } else {
            return null;
          }
        },
      ),
    );
  }
}
