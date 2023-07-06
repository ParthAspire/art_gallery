import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/common/color_constants.dart';
import 'package:art_gallery/app/model/product_data.dart';
import 'package:art_gallery/app/screens/dashboard/home/base/controller/home_base_controller.dart';
import 'package:art_gallery/app/services/firebase_services.dart';
import 'package:art_gallery/app/utils/loading_widget.dart';
import 'package:art_gallery/app/utils/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBaseScreen extends GetView<HomeBaseController> {
  const HomeBaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            addProductContainer(),
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
          return Visibility(
            visible: controller.userData.value.isAdmin == true,
            child: GestureDetector(
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
            ),
          );
        }),
      ],
    );
  }

  productListView() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: StreamBuilder(
        stream: FirebaseServices().fireStore.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                ProductData productData = ProductData.fromJson(
                    snapshot.data?.docs[index].data() as Map<String, dynamic>);
                return Row(
                  children: [
                    CachedNetworkImage(
                        imageUrl: productData.productImage ?? '',
                        height: 100),
                    Text(productData.productName ?? ''),
                  ],
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
