// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  String? name;
  String? email;
  String? mobileNo;
  bool? isAdmin;
  String? deviceToken;
  String? photoUrl;
  String? uid;

  UserData({
    this.name,
    this.email,
    this.mobileNo,
    this.isAdmin,
    this.deviceToken,
    this.photoUrl,
    this.uid,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    name: json["name"],
    email: json["email"],
    mobileNo: json["mobile_no"],
    isAdmin: json["isAdmin"],
    deviceToken: json["deviceToken"],
    photoUrl: json["photoUrl"],
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "mobile_no": mobileNo,
    "isAdmin": isAdmin,
    "deviceToken": deviceToken,
    "photoUrl": photoUrl,
    "uid": uid,
  };
}
