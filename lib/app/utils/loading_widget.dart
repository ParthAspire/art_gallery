import 'package:art_gallery/app/common/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

showLoader({Color bgColor = kColorBG }) {
  return Center(
    child: SizedBox(
      height: 50,
      child: LoadingIndicator(
          indicatorType: Indicator.ballRotateChase,

          /// Required, The loading type of the widget
          colors: const [kColorBlack],

          /// Optional, The color collections
          strokeWidth: 2,

          /// Optional, The stroke of the line, only applicable to widget which contains line
          backgroundColor: bgColor,

          /// Optional, Background of the widget
          pathBackgroundColor: kColorBlack

          /// Optional, the stroke backgroundColor

          ),
    ),
  );
}

hideLoader() {
  Navigator.of(Get.context!).pop();
}
