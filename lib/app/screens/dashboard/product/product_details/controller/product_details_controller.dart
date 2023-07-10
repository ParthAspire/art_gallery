import 'package:art_gallery/app/common/route_constants.dart';
import 'package:art_gallery/app/model/product_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  TextEditingController catNameController = TextEditingController();
  TextEditingController sellerNameController = TextEditingController();

  Rx<ProductData> productData = ProductData().obs;

  RxInt currentIndex = 0.obs;

  setIntentData({required dynamic intentData}) {
    try {
      productData.value = (intentData[0] as ProductData);
      productNameController.text  = productData.value.productName ?? '';
      productPriceController.text  = productData.value.productPrice ?? '';
      productDescController.text  = productData.value.productDesc ?? '';
      catNameController.text  = productData.value.productCategory ?? '';
      sellerNameController.text  = productData.value.sellerName ?? '';
    } catch (e) {
      debugPrint('product details setIntentData ::: $e');
    }
  }

  navigateToFullScreenImage({required var imageUrlList ,required int lenght}) {
    List<String> imageList = [];

    for(int i=0;i<lenght;i++){
      imageList.add(imageUrlList[i]['image_url']);
    }
    Get.toNamed(kRouteFullScreenImage,arguments: [productData.value.productName ?? '',imageList]);
  }
}
