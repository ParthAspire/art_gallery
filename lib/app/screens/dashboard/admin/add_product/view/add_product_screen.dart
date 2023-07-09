import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/common/color_constants.dart';
import 'package:art_gallery/app/common/image_constants.dart';
import 'package:art_gallery/app/screens/dashboard/admin/add_product/controller/add_product_controller.dart';
import 'package:art_gallery/app/utils/content_properties.dart';
import 'package:art_gallery/app/utils/text_styles.dart';
import 'package:art_gallery/app/widgets/common_textfield_widget.dart';
import 'package:art_gallery/app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddProductScreen extends GetView<AddProductController> {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: getAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                selectImageContainer(),
                selectedImageListView(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: commonTextField(
                      controller: controller.productNameController,
                      hintText: kProductHintName,
                      labelText: kProductName),
                ),
                commonTextField(
                    controller: controller.productPriceController,
                    hintText: kProductHintPrice,
                    labelText: kProductPrice,
                    preFixText: kRupee,
                    keyboardType: TextInputType.phone),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: commonTextField(
                      controller: controller.productDescController,
                      hintText: kProductHintDesc,
                      labelText: kProductDesc,
                      maxLines: 3),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: primaryButton(
                      onPress: () {
                        controller.addProductToFirebase();
                      },
                      buttonTxt: kAddProduct),
                ),
              ],
            ),
          ),
        ),
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
        margin: EdgeInsets.only(bottom: 16),
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

  selectedImageListView() {
    return Obx(() {
      return Visibility(
        visible: controller.selectedImages.isNotEmpty,
        child: SizedBox(
          height: 150,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.selectedImages.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kBorderRadius),
                      child: Image.file(controller.selectedImages[index],
                          fit: BoxFit.fill),
                    ),
                  ),
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () => controller.removeImageFromList(index),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                              color: kColorWhite,
                              borderRadius: BorderRadius.circular(50)),
                          child: Icon(Icons.close, size: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }
}
