import 'package:art_gallery/app/common/color_constants.dart';
import 'package:art_gallery/app/common/image_constants.dart';
import 'package:art_gallery/app/screens/dashboard/product/product_details/controller/product_details_controller.dart';
import 'package:art_gallery/app/services/firebase_services.dart';
import 'package:art_gallery/app/utils/content_properties.dart';
import 'package:art_gallery/app/utils/loading_widget.dart';
import 'package:art_gallery/app/utils/text_styles.dart';
import 'package:art_gallery/app/widgets/common_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          Row(
            children: [
              Text('${controller.productData.value.productName ?? ''} : '),
              Text('${controller.productData.value.productCategory ?? ''} :'),
              Text('${controller.productData.value.productPrice ?? ''} '),
            ],
          )
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
        return Container(
          height: Get.height / 5,
          margin: EdgeInsets.only(top: 16, left: 16),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data?.docs.length,
            itemExtent: Get.height / 6.5,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                  child: CachedNetworkImage(
                    imageUrl: snapshot.data?.docs[index]['image_url'] ?? '',
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
          ),
        );
      },
    );
  }
}
