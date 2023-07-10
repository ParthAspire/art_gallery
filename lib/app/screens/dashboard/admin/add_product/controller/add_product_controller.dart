import 'dart:io';

import 'package:art_gallery/app/common/app_constants.dart';
import 'package:art_gallery/app/model/product_data.dart';
import 'package:art_gallery/app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddProductController extends GetxController {
  RxList<File> selectedImages = RxList<File>.empty(growable: true);

  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDescController = TextEditingController();

  String productName = 'Painting Seven';

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> selectImageFromGallery() async {
    ImagePicker picker = ImagePicker();
    await picker.pickMultiImage().then(
      (value) {
        for (var iData in value) {
          selectedImages.add(File(iData.path));
          // uploadImage(File(iData.path));
        }
      },
    );
  }

  addProductToFirebase() {
    bool isProductNameExist = false;
    productName = productNameController.text.trim();
    FirebaseServices()
        .fireStore
        .collection('products')
        .where('product_name', isEqualTo: productName)
        .get()
        .then((value) {
      value.size > 0 ? isProductNameExist = true : isProductNameExist = false;
    });
    if (isProductNameExist) {
      for (var iData in selectedImages) {
        uploadImage(File(iData.path));
      }
      Get.back();
    } else {
      Get.snackbar(productName, kProductNameAlreadyExist,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future uploadImage(imageFile) async {
    String fileName = const Uuid().v1();
    int status = 1;

    await checkProductExistOrNot(fileName);

    await FirebaseServices()
        .fireStore
        .collection('products')
        .doc(productName)
        .collection('images')
        .doc(fileName)
        .set({'image_url': '', 'time': '', 'image_name': ''});

    var ref =
        FirebaseStorage.instance.ref().child('image').child('$fileName.jpg');

    var uploadImage = await ref.putFile(imageFile!).catchError((error) async {
      await FirebaseServices()
          .fireStore
          .collection('products')
          .doc(productName)
          .collection('images')
          .doc(fileName)
          .delete();
      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadImage.ref.getDownloadURL();

      await FirebaseServices()
          .fireStore
          .collection('products')
          .doc(productName)
          .collection('images')
          .doc(fileName)
          .update({'image_url': imageUrl, 'image_name': fileName});

      await FirebaseServices()
          .fireStore
          .collection('products')
          .doc(productName)
          .update({'product_image': imageUrl});
    }
  }

  Future<void> checkProductExistOrNot(fileName) async {
    // ProductData productData = ProductData(
    //     productCategory: 'Art',
    //     productName: 'Glass Art',
    //     productDesc: '',
    //     productPrice: '20.59',
    //     sellerName: FirebaseServices().auth.currentUser?.displayName,
    //     time: FieldValue.serverTimestamp());
    await FirebaseServices()
        .isProductExist(fileName: fileName)
        .then((isExist) async {
      if (isExist == false) {
        await FirebaseServices()
            .fireStore
            .collection('products')
            .doc(productName)
            .set(
              ProductData(
                      productCategory: 'Art',
                      productName: productName,
                      productDesc: productDescController.text.trim(),
                      productPrice: productPriceController.text.trim(),
                      sellerName:
                          FirebaseServices().auth.currentUser?.displayName,
                      productImage: selectedImages.last.path,
                      time: FieldValue.serverTimestamp().toString())
                  .toJson(),
              // {

              // 'seller_name': FirebaseServices().auth.currentUser?.displayName,
              // 'product_name': 'Glass Art',
              // 'time': FieldValue.serverTimestamp(),
              // }
            );
      }
    });
  }

  removeImageFromList(int index) {
    selectedImages.removeAt(index);
  }
}
