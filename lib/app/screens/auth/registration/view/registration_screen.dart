import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/common/color_constants.dart';
import 'package:art_gallery/app/common/image_constants.dart';
import 'package:art_gallery/app/screens/auth/registration/controller/registration_controller.dart';
import 'package:art_gallery/app/utils/content_properties.dart';
import 'package:art_gallery/app/utils/text_styles.dart';
import 'package:art_gallery/app/widgets/common_app_bar.dart';
import 'package:art_gallery/app/widgets/common_auth_textfield_widget.dart';
import 'package:art_gallery/app/widgets/primary_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RegistrationScreen extends GetView<RegistrationController> {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      // resizeToAvoidBottomInset: false,
      appBar: commonAppBar(
          titleStr: kRegistration,
          onBackTap: () {
            Get.back();
          }),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(kHorizontalPadding),
              child: Column(
                children: [
                  profileWidget(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 22, top: 42),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            kUserName,
                            style: TextStyles.kH14BlackBold700,
                          ),
                        ),
                        commonAuthTextField(
                          controller: controller.nameController,
                          hintText: kHintUserName,
                        ),
                      ],
                    ),
                  ),
                  Column(
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
                          inputFormatters: [
                            MaskedInputFormatter('###-###-####')
                          ],
                          preFixIcon: Padding(
                            padding: const EdgeInsets.only(top: 15, left: 16),
                            child: Text('+91'),
                          ),
                          maxLength: 12,
                          keyboardType: TextInputType.phone),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            kEmail,
                            style: TextStyles.kH14BlackBold700,
                          ),
                        ),
                        commonAuthTextField(
                          controller: controller.emailController,
                          hintText: kHintEmail,
                        ),
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
                    padding: const EdgeInsets.only(top: 50),
                    child: primaryButton(
                        onPress: () {
                          controller.registerDataIntoFirebase();
                        },
                        buttonTxt: kRegistration),
                  ),
                ],
              ),
            ),
            // Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 20),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: '$kAlreadyHaveAnAccount ',
                          style: TextStyles.kH14BlackBold400),
                      TextSpan(
                        text: kLogin,
                        style: TextStyles.kH14BlackBold,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => controller.navigateToLoginScreen(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  profileWidget() {
    return Obx(() {
      return Row(
        children: [
          controller.selectedImages.value.path.isEmpty
              ? SvgPicture.asset(kIconDefaultProfile)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                  child: Image.file(controller.selectedImages.value,
                      height: 102, width: 102, fit: BoxFit.fill),
                ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Column(
                children: [
                  controller.selectedImages.value.path.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width * .5,
                              child: Text(
                                  controller.selectedImages.value.path
                                      .split('/')
                                      .last,
                                  style: TextStyles.kH14BlackBold700,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            GestureDetector(
                                onTap: () {
                                  controller.clearSelectedImageData();
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 24,
                                )),
                          ],
                        )
                      : Text(kNoProfileFound),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: primaryButton(
                        onPress: () {
                          controller.selectImageFromGallery();
                        },
                        buttonTxt: kUpload.toUpperCase(),
                        width: Get.width * .3,
                        height: 40,
                        borderColor: kColorPrimary,
                        bgColor: kColorWhite,
                        textStyles: TextStyles.kH14BlackBold),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
