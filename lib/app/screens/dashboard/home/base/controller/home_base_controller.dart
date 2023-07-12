import 'package:art_gallery/app/common/route_constants.dart';
import 'package:art_gallery/app/model/product_data.dart';
import 'package:art_gallery/app/model/user_data.dart';
import 'package:art_gallery/app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBaseController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  Rx<UserData> userData = UserData().obs;
  RxBool isShowLoader = true.obs;

  TextEditingController searchController = TextEditingController();
  RxString searchText = ''.obs;
  RxBool isSearchEnable = false.obs;

  @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }

  void getUserInfo() {
    try {
      FirebaseServices()
          .fireStore
          .collection('users')
          .doc(auth.currentUser?.uid)
          .get()
          .then((value) {
        DocumentSnapshot snap = value;
        userData.value = UserData.fromJson(snap.data() as Map<String, dynamic>);
      });
      isShowLoader.value = false;
    } catch (e) {
      isShowLoader.value = false;
      debugPrint('getUserInfo ::: $e');
    }
  }

  navigateToAddProductScreen() {
    Get.toNamed(kRouteAddProductScreen);
  }

  void navigateToProductDetailsScreen({required ProductData productData}) {
    Get.toNamed(kRouteProductDetailsScreen, arguments: [productData]);
  }

  deleteProductFromFirebase(String productName) async {
    await FirebaseServices()
        .fireStore
        .collection('products')
        .doc(productName)
        .collection('images')
        .get()
        .then((value) {
      for (DocumentSnapshot iData in value.docs) {
        FirebaseServices()
            .firebaseStorage
            .ref('image')
            .child('${iData['image_name']}.jpg')
            .delete();
        iData.reference.delete();
      }
    });
    FirebaseServices()
        .fireStore
        .collection('products')
        .doc(productName)
        .delete();
  }

  Future<void> addOrRemoveFavProduct(ProductData productData) async {
    await FirebaseServices()
        .fireStore
        .collection('favourites')
        .doc(auth.currentUser?.uid)
        .collection('products')
        .doc(productData.productName ?? '')
        .set(
          ProductData(
                  productCategory: productData.productCategory ?? '',
                  productName: productData.productName ?? '',
                  productDesc: productData.productDesc ?? '',
                  productPrice: productData.productPrice ?? '',
                  sellerName: productData.sellerName ?? '',
                  productImage: productData.productImage ?? '',
                  isFav: false,
                  time: FieldValue.serverTimestamp().toString())
              .toJson(),
          // {

          // 'seller_name': FirebaseServices().auth.currentUser?.displayName,
          // 'product_name': 'Glass Art',
          // 'time': FieldValue.serverTimestamp(),
          // }
        );

    await uploadImageToFavouritesCollection(productData.productName ?? '');
  }

  Future<void> uploadImageToFavouritesCollection(String productName) async {
    int count = 0;
    List<QueryDocumentSnapshot<Map<String, dynamic>>> fileName = [];
    await FirebaseServices()
        .fireStore
        .collection('products')
        .doc(productName)
        .collection('images')
        .get()
        .then((value) {
      count = value.size;
      fileName.addAll(value.docs);
    });

    for (int i = 0; i < count; i++) {
      await FirebaseServices()
          .fireStore
          .collection('favourites')
          .doc(auth.currentUser?.uid)
          .collection('products')
          .doc(productName)
          .collection('images')
          .doc(fileName[i].data()['image_name'])
          .set({
        'image_url': fileName[i].data()['image_url'],
        'image_name': fileName[i].data()['image_name'],
        'time': FieldValue.serverTimestamp()
      });
    }
  }

  bool isProductExistInFavourites(ProductData productData) {
    bool isProductExist = false;
    FirebaseServices()
        .fireStore
        .collection('favourites')
        .doc(auth.currentUser?.uid)
        .collection('products')
        .where('product_name', isEqualTo: productData.productName ?? '')
        .get()
        .then((value) {
      value.size > 0 ? isProductExist = true : isProductExist = false;
      return isProductExist;
    });

    return isProductExist;
  }
}
