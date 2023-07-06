import 'dart:io';

import 'package:art_gallery/app/model/product_data.dart';
import 'package:art_gallery/app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddProductController extends GetxController {
  RxList<File> selectedImages = RxList<File>.empty(growable: true);

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
          uploadImage(File(iData.path));
        }
      },
    );
  }

  Future uploadImage(imageFile) async {
    String fileName = const Uuid().v1();
    int status = 1;

    await checkProductExistOrNot(fileName);

    await FirebaseServices()
        .fireStore
        .collection('products')
        .doc('Glass Art')
        .collection('images')
        .doc(fileName)
        .set({'image_url': '', 'time': ''});

    var ref =
        FirebaseStorage.instance.ref().child('image').child('$fileName.jpg');

    var uploadImage = await ref.putFile(imageFile!).catchError((error) async {
      await FirebaseServices()
          .fireStore
          .collection('products')
          .doc('Glass Art')
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
          .doc('Glass Art')
          .collection('images')
          .doc(fileName)
          .update({'image_url': imageUrl});

      await FirebaseServices()
          .fireStore
          .collection('products')
          .doc('Glass Art')
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
            .doc('Glass Art')
            .set(
              ProductData(
                      productCategory: 'Art',
                      productName: 'Glass Art',
                      productDesc: '',
                      productPrice: '20.59',
                      sellerName:
                          FirebaseServices().auth.currentUser?.displayName,
                      productImage: selectedImages[0].path,
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
}
