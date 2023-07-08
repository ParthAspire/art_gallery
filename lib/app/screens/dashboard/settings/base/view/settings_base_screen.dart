import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/common/color_constants.dart';
import 'package:art_gallery/app/common/image_constants.dart';
import 'package:art_gallery/app/screens/dashboard/settings/base/controller/settings_base_controller.dart';
import 'package:art_gallery/app/utils/content_properties.dart';
import 'package:art_gallery/app/utils/loading_widget.dart';
import 'package:art_gallery/app/utils/text_styles.dart';
import 'package:art_gallery/app/widgets/divider_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SettingsBaseScreen extends GetView<SettingsBaseController> {
  SettingsBaseScreen({super.key}) {
    if (controller.userData.photoUrl == null) {
      controller.getUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(kMyProfile, style: TextStyles.kH28WhiteBold),
          backgroundColor: kColorBlack,
        ),
        body: Stack(
          children: [
            // Obx(() {
            //   return Visibility(
            //     visible: controller.isShowLoader.value,
            //     child: Dialog(
            //       insetPadding: EdgeInsets.zero,
            //       surfaceTintColor: Colors.transparent,
            //       child: Container(
            //           height: Get.height,
            //           width: Get.width,
            //           color: kColorBG,
            //           child: showLoader()),
            //     ),
            //   );
            // }),
            Column(
              children: [
                userProfileContainer(),
                horizontalDividerWidget(width: Get.width * .9),
                Container(
                  margin:
                      EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kBorderRadius),
                      border: Border.all(color: kColorGrayE0)),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.settingsList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          controller.navigateToScreen(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kHorizontalPadding, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: kColorGrayE0,
                                      borderRadius:
                                          BorderRadius.circular(kBorderRadius),
                                      border: Border.all(color: kColorWhite),
                                    ),
                                    child: SvgPicture.asset(
                                        controller
                                            .settingsList[index].settingIcon,
                                        height: 28),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Text(
                                        controller
                                            .settingsList[index].settingName,
                                        style: TextStyles.kH16BlackBold700),
                                  ),
                                ],
                              ),
                              Icon(Icons.navigate_next_outlined),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Spacer(),
                horizontalDividerWidget(width: Get.width * .9),
                logoutButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  userProfileContainer() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: kHorizontalPadding, vertical: kHorizontalPadding),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        border: Border.all(color: kColorWhite),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(kBorderRadius),
            child: CachedNetworkImage(
              imageUrl: controller.userData.photoUrl ?? '',
              height: 58,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.userData.name ?? 'user',
                    style: TextStyles.kH18BlackBold),
                Text(controller.userData.email ?? 'user@gmail.com',
                    style: TextStyles.kH14Grey6ABold400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  logoutButton() {
    return GestureDetector(
      onTap: () {
        controller.logout();
      },
      child: Padding(
        padding: const EdgeInsets.only(
            bottom: 100, left: kHorizontalPadding, top: 12),
        child: Row(
          children: [
            SvgPicture.asset(kIconLogout),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 2),
              child: Text(kLogout, style: TextStyles.kH18BlackBold),
            ),
          ],
        ),
      ),
    );
  }
}
