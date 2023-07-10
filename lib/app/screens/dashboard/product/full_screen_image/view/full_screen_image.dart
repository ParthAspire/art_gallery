import 'package:art_gallery/app/common/image_constants.dart';
import 'package:art_gallery/app/screens/dashboard/product/full_screen_image/controller/full_screen_image_controller.dart';
import 'package:art_gallery/app/services/firebase_services.dart';
import 'package:art_gallery/app/utils/content_properties.dart';
import 'package:art_gallery/app/utils/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:zoom_widget/zoom_widget.dart';

class FullScreenImage extends GetView<FullScreenImageController> {
  FullScreenImage({super.key}) {
    final intentData = Get.arguments;
    controller.setIntentData(intentData: intentData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.imageUrlList.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 100,
            height: 140,
            child: InstaImageViewer(
              child: CachedNetworkImage(
                imageUrl: controller.imageUrlList[index],
                height: 500,
                width: 300,
                progressIndicatorBuilder: (context, url, progress) {
                  return showLoader(bgColor: Colors.transparent);
                },
                errorWidget: (context, url, error) {
                  return SvgPicture.asset(kImgDefaultProduct);
                },
              ),
            ),
          );
          //   SizedBox(
          //   height: 250,
          //   width: 350,
          //   child: Zoom(
          //       initTotalZoomOut: true,
          //       doubleTapZoom: true,
          //       centerOnScale: true,
          //       initScale: 40,
          //       backgroundColor: Colors.transparent,
          //       child: ClipRRect(
          //         borderRadius: BorderRadius.circular(kBorderRadius),
          //         child: CachedNetworkImage(
          //           imageUrl: controller.imageUrlList[index],
          //           height: 500,
          //           width: 300,
          //           progressIndicatorBuilder: (context, url, progress) {
          //             return showLoader(bgColor: Colors.transparent);
          //           },
          //           errorWidget: (context, url, error) {
          //             return SvgPicture.asset(kImgDefaultProduct);
          //           },
          //         ),
          //       )),
          // );
        },
      ),
    );
  }
}
