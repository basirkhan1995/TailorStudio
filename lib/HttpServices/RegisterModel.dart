import 'dart:convert';

List<Register> registerFromJson(String str) =>
    List<Register>.from(json.decode(str).map((x) => Register.fromJson(x)));
String registerToJson(List<Register> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Register {
  Register({
    this.userID,
    this.tailorName,
    this.studioName,
    this.userEmail,
    this.userPhone,
    this.userAddress,
    this.userName,
    this.password,
    this.fileName,
  });
  String userID;
  String tailorName;
  String studioName;
  String userEmail;
  String userPhone;
  String userAddress;
  String userName;
  String password;
  String fileName;
  factory Register.fromJson(Map<String, dynamic> json) => Register(
    userID: json["userID"],
    tailorName: json['tailorName'],
    studioName: json['studioName'],
    userEmail: json['userEmail'],
    userPhone: json['userPhone'],
    userAddress: json['userAddress'],
    userName: json["userName"],
    password: json["password"],
    fileName: json['fileName'],
  );

  Map<String, dynamic> toJson() => {
    "userID": userID,
    "tailorName": tailorName,
    "studioName": studioName,
    "userEmail": userEmail,
    "userPhone": userPhone,
    "userAddress": userAddress,
    "userName": userName,
    "password": password,
    "fileName": fileName,
  };
}