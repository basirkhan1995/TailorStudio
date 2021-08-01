// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

List<Customer> customerFromJson(String str) => List<Customer>.from(json.decode(str).map((x) => Customer.fromJson(x)));

String customerToJson(List<Customer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Customer {
   String customerID;
   String firstName;
   String lastName;
   String phone;
   String email ;
   String tailor;
   String height;
   String shoulder;
   String sleeve;
   String collar;
   String waist;
   String skirt;
   String pantHeight;
   String legWidth;
   String fileName;
   String measureID;

  Customer({
    this.measureID,
     this.customerID,
     this.firstName,
     this.lastName,
     this.phone,
     this.email,
     this.tailor,
     this.height,
     this.shoulder,
     this.sleeve,
     this.collar,
     this.waist,
     this.skirt,
     this.pantHeight,
     this.legWidth,
     this.fileName,
  });


  factory Customer.fromJson(Map<String, dynamic> json) {
   return Customer(
   customerID: json["customerID"]as String,
   firstName: json["firstName"] as String,
   lastName: json["lastName"]as String,
   phone: json["phone"]as String,
   email: json["email"]as String,
   tailor: json["tailor"]as String,
   height: json["height"]as String,
   shoulder: json["shoulder"]as String,
   sleeve: json["sleeve"]as String,
   collar: json["collar"]as String,
   waist: json["waist"]as String,
   skirt: json["skirt"]as String,
   pantHeight: json["pantHeight"]as String,
   legWidth: json["legWidth"]as String,
   fileName: json["fileName"] as String,
   measureID: json["measureID"] as String,
 );

  }

  Map<String, dynamic> toJson() => {
    "customerID": customerID,
    "firstName": firstName,
    "lastName": lastName,
    "phone": phone,
    "email": email,
    "tailor": tailor,
    "height": height,
    "shoulder": shoulder,
    "sleeve": sleeve,
    "collar": collar,
    "Waist": waist,
    "skirt": skirt,
    "pantHeight": pantHeight,
    "legWidth": legWidth,
    "photo": fileName,
    "measureID": measureID,
  };
}
