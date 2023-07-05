import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/common/color_constants.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static const double kH14FontSize = 14;
  static const double kH18FontSize = 18;
  static const double kH20FontSize = 20;
  static const double kH24FontSize = 24;

  static const kH14WhiteBold400 = TextStyle(
    fontSize: kH14FontSize,
    color: kColorWhite,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const kH14PrimaryBold400 = TextStyle(
    fontSize: kH14FontSize,
    color: kColorPrimary,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const kH14PrimaryBold = TextStyle(
    fontSize: kH14FontSize,
    color: kColorPrimary,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );

  static const kH18PrimaryBold = TextStyle(
    fontSize: kH18FontSize,
    color: kColorPrimary,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );
  static const kH18Grey98Bold = TextStyle(
    fontSize: kH18FontSize,
    color: kColorGray98,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );
  static const kH18Grey98Bold400 = TextStyle(
    fontSize: kH18FontSize,
    color: kColorGray98,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const kH18WhiteBold = TextStyle(
    fontSize: kH18FontSize,
    color: kColorWhite,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );
  static const kH18BlackBold400 = TextStyle(
    fontSize: kH18FontSize,
    color: kColorBlack,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  static const kH20WhiteBold700 = TextStyle(
    fontSize: kH20FontSize,
    color: kColorWhite,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const kH20BlackBold = TextStyle(
    fontSize: kH20FontSize,
    color: kColorBlack,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );

  static const kH24WhiteBold = TextStyle(
    fontSize: kH24FontSize,
    color: kColorWhite,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );
  static const kH24PrimaryBold = TextStyle(
    fontSize: kH24FontSize,
    color: kColorPrimary,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );
  static const kH24BlackBold = TextStyle(
    fontSize: kH24FontSize,
    color: kColorBlack,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );
}
