import 'package:art_gallery/app/model/product_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDescController = TextEditingController();

  Rx<ProductData> productData = ProductData().obs;

  RxInt currentIndex = 0.obs;

  setIntentData({required dynamic intentData}) {
    try {
      productData.value = (intentData[0] as ProductData);
      productNameController.text  = productData.value.productName ?? '';
      productPriceController.text  = productData.value.productPrice ?? '';
      productDescController.text  = productData.value.productDesc ?? '';
    } catch (e) {
      debugPrint('product details setIntentData ::: $e');
    }
  }
}
