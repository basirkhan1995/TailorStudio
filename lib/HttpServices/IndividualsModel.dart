// To parse this JSON data, do
//     final individuals = individualsFromJson(jsonString);

import 'dart:convert';

List<Individuals> individualsFromJson(String str) => List<Individuals>.from(json.decode(str).map((x) => Individuals.fromJson(x)));

String individualsToJson(List<Individuals> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Individuals {
  Individuals({
    this.indId,
    this.indFirstName,
    this.indLastName,
    this.indPhone,
    this.indEmail,
    this.indPhoto,
  });

  String indId;
  String indFirstName;
  String indLastName;
  String indPhone;
  String indEmail;
  String indPhoto;

  factory Individuals.fromJson(Map<String, dynamic> json) => Individuals(
    indId: json["indID"],
    indFirstName: json["indFirstName"],
    indLastName: json["indLastName"],
    indPhone: json["indPhone"],
    indEmail: json["indEmail"],
    indPhoto: json["indPhoto"],
  );

  Map<String, dynamic> toJson() => {
    "indID": indId,
    "indFirstName": indFirstName,
    "indLastName": indLastName,
    "indPhone": indPhone,
    "indEmail": indEmail,
    "indPhoto": indPhoto,
  };
}
