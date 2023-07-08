import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/common/color_constants.dart';
import 'package:art_gallery/app/utils/content_properties.dart';
import 'package:art_gallery/app/utils/loading_widget.dart';
import 'package:art_gallery/app/utils/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'primary_button.dart';

deleteConfirmDialog({
  required String titleText,
  String? subTitleText,
  String? productImage,
  required String positiveButtonText,
  required String negativeButtonText,
  required Function positiveTap,
  required Function negativeTap,
}) {
  return Dialog(
    backgroundColor: kColorBlack,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius)),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            Visibility(
              visible: (productImage ?? '').isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                  child: CachedNetworkImage(
                    imageUrl: productImage ?? '',
                    height: 250,
                    fit: BoxFit.fill,
                    width: Get.width,
                    progressIndicatorBuilder: (context, url, progress) {
                      return showLoader(bgColor: Colors.transparent);
                    },
                    errorWidget: (context, url, error) {
                      return showLoader(bgColor: Colors.transparent);
                      // return SvgPicture.asset(kImgDefaultProduct);
                    },
                  ),
                ),
              ),
            ),
            Text(titleText, style: TextStyles.kH16WhiteBold700),
            Visibility(
                visible: (subTitleText ?? '').isNotEmpty,
                child:
                    Text(subTitleText ?? '', style: TextStyles.kH18WhiteBold)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 26),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              primaryButton(
                  onPress: () {
                    negativeTap();
                  },
                  buttonTxt: negativeButtonText,
                  width: Get.width * .26,
                  height: 40,
                  bgColor: kColorWhite,
                  borderColor: kColorBlack,
                  textStyles: TextStyles.kH14BlackBold700,
                  borderRadius: kBorderRadius),
              primaryButton(
                  onPress: () {
                    positiveTap();
                  },
                  buttonTxt: positiveButtonText,
                  width: Get.width * .26,
                  height: 40,
                  borderColor: kColorWhite,
                  textStyles: TextStyles.kH14WhiteBold700,
                  borderRadius: kBorderRadius)
            ],
          ),
        )
      ],
    ),
  );
}
