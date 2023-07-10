import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/common/color_constants.dart';
import 'package:art_gallery/app/common/image_constants.dart';
import 'package:art_gallery/app/model/product_data.dart';
import 'package:art_gallery/app/screens/dashboard/home/base/controller/home_base_controller.dart';
import 'package:art_gallery/app/services/firebase_services.dart';
import 'package:art_gallery/app/utils/content_properties.dart';
import 'package:art_gallery/app/utils/loading_widget.dart';
import 'package:art_gallery/app/utils/text_styles.dart';
import 'package:art_gallery/app/widgets/common_app_bar.dart';
import 'package:art_gallery/app/widgets/common_textfield_widget.dart';
import 'package:art_gallery/app/widgets/delete_confirm_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeBaseScreen extends GetView<HomeBaseController> {
  const HomeBaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(),
        // commonAppBar(
        //     titleStr: 'Home',
        //     onBackTap: () {},
        //     isShowBackArrow: false,
        //     isCenterTitle: false,
        //     actionWidgets: [
        //       Visibility(
        //         visible: controller.userData.value.isAdmin == true,
        //         child: GestureDetector(
        //           onTap: () => controller.navigateToAddProductScreen(),
        //           child: Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: SvgPicture.asset(kImgDefaultProduct, height: 40),
        //           ),
        //         ),
        //       ),
        //     ]),
        body: Stack(
          children: [
            Obx(() {
              return Visibility(
                visible: controller.isShowLoader.value,
                child: Dialog(
                  insetPadding: EdgeInsets.zero,
                  surfaceTintColor: Colors.transparent,
                  child: Container(
                      height: Get.height,
                      width: Get.width,
                      color: kColorBG,
                      child: showLoader()),
                ),
              );
            }),
            // Visibility(
            //     visible: controller.userData.value.isAdmin == true,
            //     child: addProductContainer()),
            productListView(),
          ],
        ),
      ),
    );
  }

  addProductContainer() {
    return Column(
      children: [
        Obx(() {
          return GestureDetector(
            onTap: () => controller.navigateToAddProductScreen(),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(kAddProduct, style: TextStyles.kH18BlackBold),
                  Icon(Icons.add),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  productListView() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      // top: controller.userData.value.isAdmin == true ? 50 : 10),
      child:
         StreamBuilder(
          stream:
              FirebaseServices().fireStore.collection('products').snapshots(),
          builder: (context, snapshot) {
            print('snapshot.hasData ::: ${snapshot.data?.size}');
            if (snapshot.hasData && (snapshot.data?.size ?? 0) > 0) {
              return GridView.builder(
                itemCount: snapshot.data?.docs.length,
                padding: EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .6,
                    crossAxisSpacing: 10),
                itemBuilder: (context, index) {
                  ProductData productData = ProductData.fromJson(
                      snapshot.data?.docs[index].data()
                          as Map<String, dynamic>);
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.navigateToProductDetailsScreen(
                              productData: productData);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: kColorBlack),
                              borderRadius:
                                  BorderRadius.circular(kBorderRadius)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(kBorderRadius),
                                child: CachedNetworkImage(
                                  imageUrl: productData.productImage ?? '',
                                  height: 200,
                                  fit: BoxFit.fill,
                                  width: Get.width,
                                  progressIndicatorBuilder:
                                      (context, url, progress) {
                                    return showLoader(
                                        bgColor: Colors.transparent);
                                  },
                                  errorWidget: (context, url, error) {
                                    return showLoader(
                                        bgColor: Colors.transparent);
                                    // return SvgPicture.asset(kImgDefaultProduct);
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(productData.productName ?? '',
                                        style: TextStyles.kH18BlackBold,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Price: ',
                                              style: TextStyles.kH14RedBold700),
                                          TextSpan(
                                              text:
                                                  'Rs.${productData.productPrice ?? ''}',
                                              style:
                                                  TextStyles.kH14BlackBold700),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: controller.userData.value.isAdmin == true,
                        child: Positioned.fill(
                          child: GestureDetector(
                            onTap: () => showDeleteProductDialog(productData),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                height: 30,
                                width: 30,
                                margin: EdgeInsets.only(top: 14, right: 8),
                                padding: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  color: kColorWhite,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: SvgPicture.asset(
                                  kIconDelete,
                                  height: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else if (snapshot.data?.size == 0) {
              return Column(children: [
                SvgPicture.asset(kImgNoProductFound),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Text(
                    kNoProductFound,
                    style: TextStyles.kH18BlackBold400,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                )
              ]);
            } else {
              return Container();
            }
          },
        ),

    );
  }

  showDeleteProductDialog(ProductData productData) {
    showDialog(
      context: Get.overlayContext!,
      builder: (context) {
        return deleteConfirmDialog(
            titleText: kProductDeleteText,
            subTitleText: productData.productName ?? '',
            productImage: productData.productImage,
            positiveButtonText: kYes,
            negativeButtonText: kNo,
            positiveTap: () {
              controller
                  .deleteProductFromFirebase(productData.productName ?? '');
              Get.back();
            },
            negativeTap: () {
              Get.back();
            });
      },
    );
  }

  getAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 16,
      titleSpacing: 0,
      backgroundColor: kColorBlack,
      centerTitle: true,
      title: Row(
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              decoration: BoxDecoration(
                  color: kColorWhite, borderRadius: BorderRadius.circular(4)),
              child: SvgPicture.asset(kIconApp, height: 28, width: 26)),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text('$appName', style: TextStyles.kH24WhiteBold),
          ),
        ],
      ),
      leading: SizedBox(),
      actions: [
        Obx(() {
          return Visibility(
            visible: controller.userData.value.isAdmin == true,
            child: GestureDetector(
              onTap: () => controller.navigateToAddProductScreen(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(kImgDefaultProduct, height: 40),
              ),
            ),
          );
        }),
      ],
    );
  }
}
