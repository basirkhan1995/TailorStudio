// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

List<Profile> profileFromJson(String str) => List<Profile>.from(json.decode(str).map((x) => Profile.fromJson(x)));

String profileToJson(List<Profile> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Profile {
  Profile({
    this.userId,
    this.tailorName,
    this.studioName,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.userAddress,
    this.fileName,
  });

  String userId;
  String tailorName;
  String studioName;
  String userName;
  String userEmail;
  String userPhone;
  String userAddress;
  String fileName;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    userId: json["userID"]as String,
    tailorName: json["tailorName"]as String,
    studioName: json["studioName"]as String,
    userName: json["userName"]as String,
    userEmail: json["userEmail"]as String,
    userPhone: json["userPhone"]as String,
    userAddress: json["userAddress"]as String,
    fileName: json["fileName"]as String,
  );

  Map<String, dynamic> toJson() => {
    "userID": userId,
    "tailorName": tailorName,
    "studioName": studioName,
    "userName": userName,
    "userEmail": userEmail,
    "userPhone": userPhone,
    "userAddress": userAddress,
    "fileName": fileName,
  };
}
