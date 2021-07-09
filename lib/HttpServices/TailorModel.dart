// To parse this JSON data, do
//     final individuals = individualsFromJson(jsonString);

import 'dart:convert';

List<Tailor> tailorFromJson(String str) => List<Tailor>.from(json.decode(str).map((x) => Tailor.fromJson(x)));

String tailorToJson(List<Tailor> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tailor {
  Tailor({
    this.tlrID,
    this.tlrName,
    this.tlrAddress,
    this.tlrEmail,
    this.tlrPhone,
    this.tlrLogo,
  });

  String tlrID;
  String tlrName;
  String tlrAddress;
  String tlrEmail;
  String tlrPhone;
  String tlrLogo;

  factory Tailor.fromJson(Map<String, dynamic> json) => Tailor(
    tlrID: json["tlrID"],
    tlrName: json["tlrName"],
    tlrAddress: json["tlrAddress"],
    tlrEmail: json["tlrEmail"],
    tlrPhone: json["tlrPhone"],
    tlrLogo: json["tlrLogo"],
  );

  Map<String, dynamic> toJson() => {
    "tlrID": tlrID,
    "tlrName": tlrName,
    "tlrAddress": tlrAddress,
    "tlrEmail": tlrEmail,
    "tlrPhone": tlrPhone,
    "tlrLogo": tlrLogo,
  };
}
