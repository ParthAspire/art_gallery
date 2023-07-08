import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/common/color_constants.dart';
import 'package:art_gallery/app/common/image_constants.dart';
import 'package:art_gallery/app/screens/dashboard/product/product_details/controller/product_details_controller.dart';
import 'package:art_gallery/app/services/firebase_services.dart';
import 'package:art_gallery/app/utils/content_properties.dart';
import 'package:art_gallery/app/utils/loading_widget.dart';
import 'package:art_gallery/app/utils/text_styles.dart';
import 'package:art_gallery/app/widgets/common_app_bar.dart';
import 'package:art_gallery/app/widgets/common_textfield_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends GetView<ProductDetailsController> {
  ProductDetailsScreen({super.key}) {
    final intentData = Get.arguments;
    controller.setIntentData(intentData: intentData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          titleStr: controller.productData.value.productName ?? '',
          onBackTap: () {
            Get.back();
          }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageSliderView(),
          productInfoContainer(),
        ],
      ),
    );
  }

  getAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: kColorBlack,
      leading: GestureDetector(
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
      title: Text(controller.productData.value.productName ?? '',
          style: TextStyles.kH28WhiteBold),
    );
  }

  imageSliderView() {
    return StreamBuilder(
      stream: FirebaseServices()
          .fireStore
          .collection('products')
          .doc(controller.productData.value.productName ?? '')
          .collection('images')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: Get.height / 2.2,
            // margin: EdgeInsets.only(top: 16, left: 16),
            padding: EdgeInsets.only(top: 16, left: 16, bottom: 16),
            decoration: BoxDecoration(
              color: kColorGrayE0,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(kBorderRadius),
                  bottomLeft: Radius.circular(kBorderRadius)),
            ),
            child: Column(
              children: [
                Expanded(
                  child: CarouselSlider.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index, realIndex) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(kBorderRadius),
                          child: CachedNetworkImage(
                            imageUrl:
                                snapshot.data?.docs[index]['image_url'] ?? '',
                            progressIndicatorBuilder: (context, url, progress) {
                              return showLoader(bgColor: Colors.transparent);
                            },
                            errorWidget: (context, url, error) {
                              return SvgPicture.asset(kImgDefaultProduct);
                            },
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: Get.height / 2.8,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      onPageChanged: (index, reason) {
                        controller.currentIndex.value = index;
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(top: 10),
                    itemBuilder: (context, index) {
                      return Obx(() {
                        return Container(
                          height: 10,
                          width: 10,
                          margin:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                          decoration: BoxDecoration(
                            color: controller.currentIndex.value == index
                                ? kColorBlack
                                : kColorGray98,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
            // child: ListView.builder(
            //   shrinkWrap: true,
            //   scrollDirection: Axis.horizontal,
            //   itemCount: snapshot.data?.docs.length,
            //   itemExtent: Get.height / 6.5,
            //   padding: EdgeInsets.zero,
            //   itemBuilder: (context, index) {
            //     return Padding(
            //       padding: const EdgeInsets.only(right: 8),
            //       child: ClipRRect(
            //         borderRadius: BorderRadius.circular(kBorderRadius),
            //         child: CachedNetworkImage(
            //           imageUrl: snapshot.data?.docs[index]['image_url'] ?? '',
            //           progressIndicatorBuilder: (context, url, progress) {
            //             return showLoader(bgColor: Colors.transparent);
            //           },
            //           errorWidget: (context, url, error) {
            //             return SvgPicture.asset(kImgDefaultProduct);
            //           },
            //         ),
            //       ),
            //     );
            //   },
            // ),
          );
        } else {
          return showLoader();
        }
      },
    );
  }

  productInfoContainer() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            // color: kColorGrayE0,
            // borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(kBorderRadius),
            //     topRight: Radius.circular(kBorderRadius)),
            ),
        child: Padding(
          padding: const EdgeInsets.all(kHorizontalPadding),
          child: Column(
            children: [
              IgnorePointer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: commonTextField(
                    controller: controller.productNameController,
                    hintText: kProductHintName,
                    labelText: kProductName,
                  ),
                ),
              ),
              IgnorePointer(
                child: commonTextField(
                  controller: controller.productPriceController,
                  hintText: kProductHintPrice,
                  labelText: kProductPrice,
                  preFixText: kRupee,
                  keyboardType: TextInputType.phone,
                ),
              ),
              Visibility(
                visible:
                    controller.productDescController.text.trim().isNotEmpty,
                child: IgnorePointer(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: commonTextField(
                      controller: controller.productDescController,
                      hintText: kProductHintDesc,
                      labelText: kProductDesc,
                      preFixText: kRupee,
                      maxLines: 3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
