import 'dart:convert';

List<Register> RegisterFromJson(String str) => List<Register>.from(
    json.decode(str).map((x) => Register.fromJson(x)));
String RegisterToJson(List<Register> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Register{
 Register({
    this.usrID,
    this.usrName,
    this.usrPass,
    this.usrRole,
    this.usrTailor,
    this.usrImage,
  });
  String usrID;
  String usrName;
  String usrPass;
  String usrRole;
  String usrTailor;
  String usrImage;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
      usrID: json["usrID"],
      usrName: json["usrName"],
      usrPass: json["usrPass"],
      usrRole: json["usrRole"],
      usrTailor: json["usrTailor"],
      usrImage: json["usrImage"],
      );

  Map<String, dynamic> toJson() => {
    "usrID": usrID,
    "usrName": usrName,
    "usrPass": usrPass,
    "usrRole": usrRole,
    "usrTailor": usrTailor,
    "usrImage": usrImage,
  };
}