// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

List<Customer> customerFromJson(String str) => List<Customer>.from(json.decode(str).map((x) => Customer.fromJson(x)));

String customerToJson(List<Customer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Customer {
  Customer({
    this.customerID,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.tailor,
    this.qad,
    this.shana,
    this.astin,
    this.yakhan,
    this.baghal,
    this.daman,
    this.qadTunban,
    this.pacha,
  });
  String customerID;
  String firstName;
  String lastName;
  String phone;
  String email;
  String tailor;
  String qad;
  String shana;
  String astin;
  String yakhan;
  String baghal;
  String daman;
  String qadTunban;
  String pacha;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    customerID: json["customerID"]as String,
    firstName: json["firstName"] as String,
    lastName: json["lastName"]as String,
    phone: json["phone"]as String,
    email: json["email"]as String,
    tailor: json["tailor"]as String,
    qad: json["qad"]as String,
    shana: json["shana"]as String,
    astin: json["astin"]as String,
    yakhan: json["yakhan"]as String,
    baghal: json["baghal"]as String,
    daman: json["daman"]as String,
    qadTunban: json["qadTunban"]as String,
    pacha: json["pacha"]as String,
  );

  Map<String, dynamic> toJson() => {
    "customerID": customerID,
    "firstName": firstName,
    "lastName": lastName,
    "phone": phone,
    "email": email,
    "tailor": tailor,
    "qad": qad,
    "shana": shana,
    "astin": astin,
    "yakhan": yakhan,
    "baghal": baghal,
    "daman": daman,
    "qadTunban": qadTunban,
    "pacha": pacha,
  };
}
