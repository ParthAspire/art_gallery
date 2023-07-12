// To parse this JSON data, do
//
//     final productData = productDataFromJson(jsonString);

import 'dart:convert';

ProductData productDataFromJson(String str) => ProductData.fromJson(json.decode(str));

String productDataToJson(ProductData data) => json.encode(data.toJson());

class ProductData {
  String? productName;
  String? productPrice;
  String? productDesc;
  String? productCategory;
  String? time;
  String? sellerName;
  String? productImage;
  bool? isFav;
  List<ProductImage>? images;

  ProductData({
    this.productName,
    this.productPrice,
    this.productDesc,
    this.productCategory,
    this.time,
    this.sellerName,
    this.productImage,
    this.isFav,
    this.images,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
    productName: json["product_name"],
    productPrice: json["product_price"],
    productDesc: json["product_desc"],
    productCategory: json["product_category"],
    time: json["time"],
    sellerName: json["seller_name"],
    productImage: json["product_image"],
    isFav: json["isFav"],
    images: List<ProductImage>.from(json["images"].map((x) => ProductImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product_name": productName,
    "product_price": productPrice,
    "product_desc": productDesc,
    "product_category": productCategory,
    "time": time,
    "seller_name": sellerName,
    "product_image": productImage,
    "isFav": isFav,
    "images": List<dynamic>.from((images??[]).map((x) => x.toJson())),
  };
}

class ProductImage {
  String? imageUrl;

  ProductImage({
    this.imageUrl,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "image_url": imageUrl,
  };
}
