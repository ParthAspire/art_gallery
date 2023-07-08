import 'package:art_gallery/app/model/product_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  Rx<ProductData> productData = ProductData().obs;

  setIntentData({required dynamic intentData}) {
    try {
      productData.value = (intentData[0] as ProductData);
    } catch (e) {
      debugPrint('product details setIntentData ::: $e');
    }
  }
}
