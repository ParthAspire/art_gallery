import 'package:art_gallery/app/common/color_constants.dart';
import 'package:art_gallery/app/utils/content_properties.dart';
import 'package:art_gallery/app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget primaryButton({
  required Function onPress,
  required String buttonTxt,
  double? width,
  double? height,
}) {
  return MaterialButton(
    padding: EdgeInsets.zero,
    onPressed: () {
      onPress();
    },
    child: Container(
      width: width ?? Get.width,
      height: height ?? 58,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kColorPrimary,
        borderRadius: BorderRadius.circular(kButtonBorderRadius),
      ),
      child: Text(
        buttonTxt,
        style: TextStyles.kH14WhiteBold700,
      ),
    ),
  );
}
