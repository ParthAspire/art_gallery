import 'package:art_gallery/app/common/color_constants.dart';
import 'package:art_gallery/app/common/image_constants.dart';
import 'package:art_gallery/app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppBar commonAppBar(
    {required String titleStr,
    required Function onBackTap,
    bool isShowBackArrow = true,
    bool isCenterTitle = true,
    List<Widget>? actionWidgets}) {
  return AppBar(
    automaticallyImplyLeading: isShowBackArrow ? false : true,
    leadingWidth: isShowBackArrow ? 60 : 16,
    titleSpacing: 0,
    backgroundColor: kColorBlack,
    centerTitle: isCenterTitle,
    title: Text(titleStr, style: TextStyles.kH24WhiteBold),
    // kH28WhiteBold
    leading: isShowBackArrow
        ? GestureDetector(
            onTap: () {
              onBackTap();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: kColorWhite,
                foregroundColor: kColorWhite,
                child: SvgPicture.asset(
                  kIconBackArrow,
                  color: kColorBlack,
                  height: 12,
                ),
              ),
            ),
          )
        : SizedBox(),
    actions: actionWidgets ?? [],
  );
}
