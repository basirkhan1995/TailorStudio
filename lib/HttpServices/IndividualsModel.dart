// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

List<Customer> customerFromJson(String str) => List<Customer>.from(json.decode(str).map((x) => Customer.fromJson(x)));

String customerToJson(List<Customer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Customer {
  Customer({
    this.orderId,
    this.orderType,
    this.quantity,
    this.remarks,
    this.orderState,
    this.designType,
    this.sleeveDesign,
    this.collarDesign,
    this.orderDate,
    this.deliveryDate,
    this.amount,
    this.receivedAmount,
    this.total,
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

  String orderId;
  String orderType;
  String quantity;
  String remarks;
  String orderState;
  String designType;
  String sleeveDesign;
  String collarDesign;
  DateTime orderDate;
  DateTime deliveryDate;
  String amount;
  String receivedAmount;
  String total;
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
    orderId: json["orderID"],
    orderType: json["orderType"],
    quantity: json["quantity"],
    remarks: json["remarks"],
    orderState: json["orderState"],
    designType: json["designType"],
    sleeveDesign: json["sleeve_design"],
    collarDesign: json["collar_design"],
    orderDate: DateTime.parse(json["orderDate"]),
    deliveryDate: DateTime.parse(json["deliveryDate"]),
    amount: json["amount"],
    receivedAmount: json["receivedAmount"],
    total: json["total"],
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
    "orderID": orderId,
    "orderType": orderType,
    "quantity": quantity,
    "remarks": remarks,
    "orderState": orderState,
    "designType": designType,
    "sleeve_design": sleeveDesign,
    "collar_design": collarDesign,
    "orderDate": "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
    "deliveryDate": "${deliveryDate.year.toString().padLeft(4, '0')}-${deliveryDate.month.toString().padLeft(2, '0')}-${deliveryDate.day.toString().padLeft(2, '0')}",
    "amount": amount,
    "receivedAmount": receivedAmount,
    "total": total,
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
