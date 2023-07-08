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
  Color bgColor = kColorPrimary,
  Color borderColor = kColorPrimary,
  TextStyle textStyles = TextStyles.kH14WhiteBold700,
  double borderRadius  = kButtonBorderRadius,
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
        color:bgColor ,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        buttonTxt,
        style: textStyles,
      ),
    ),
  );
}
