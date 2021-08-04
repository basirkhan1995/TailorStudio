// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

List<Customer> customerFromJson(String str) => List<Customer>.from(json.decode(str).map((x) => Customer.fromJson(x)));

String customerToJson(List<Customer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Customer {
  Customer({
    this.customerId,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.measureId,
    this.height,
    this.collar,
    this.sleeve,
    this.skirt,
    this.legWidth,
    this.pantHeight,
    this.shoulder,
    this.waist,
    this.fileName,
    this.tailorName,
  });

  String customerId;
  String firstName;
  String lastName;
  String phone;
  String email;
  String measureId;
  String height;
  String collar;
  String sleeve;
  String skirt;
  String legWidth;
  String pantHeight;
  String shoulder;
  String waist;
  String fileName;
  String tailorName;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    customerId: json["customerID"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phone: json["phone"],
    email: json["email"],
    measureId: json["measureID"],
    height: json["height"],
    collar: json["collar"],
    sleeve: json["sleeve"],
    skirt: json["skirt"],
    legWidth: json["legWidth"],
    pantHeight: json["pantHeight"],
    shoulder: json["shoulder"],
    waist: json["waist"],
    fileName: json["fileName"],
    tailorName: json["tailorName"],
  );

  Map<String, dynamic> toJson() => {
    "customerID": customerId,
    "firstName": firstName,
    "lastName": lastName,
    "phone": phone,
    "email": email,
    "measureID": measureId,
    "height": height,
    "collar": collar,
    "sleeve": sleeve,
    "skirt": skirt,
    "legWidth": legWidth,
    "pantHeight": pantHeight,
    "shoulder": shoulder,
    "waist": waist,
    "fileName": fileName,
    "tailorName": tailorName,
  };
}
