import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/common/color_constants.dart';
import 'package:art_gallery/app/common/image_constants.dart';
import 'package:art_gallery/app/screens/dashboard/admin/add_product/controller/add_product_controller.dart';
import 'package:art_gallery/app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddProductScreen extends GetView<AddProductController> {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: Column(
        children: [
          selectImageContainer(),
        ],
      ),
    );
  }

  getAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 0,
      titleSpacing: 0,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.all(14.0),
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
          ),
          Padding(
            padding: EdgeInsets.only(left: Get.width / 6),
            child: Text(kAddProduct, style: TextStyles.kH28WhiteBold),
          ),
        ],
      ),
    );
  }

  selectImageContainer() {
    return GestureDetector(
      onTap: () {
        controller.selectImageFromGallery();
      },
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(border: Border.all(color: kColorBlack)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Get.width * .4,
              child: Text(kSelectYourBestPicsEver,
                  style: TextStyles.kH18BlackBold400),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(border: Border.all(color: kColorBlack)),
              child: SvgPicture.asset(kIconUploadImage, height: 40),
            ),
          ],
        ),
      ),
    );
  }
}
