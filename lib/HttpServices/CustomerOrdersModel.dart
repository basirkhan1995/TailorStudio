// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

List<Orders> ordersFromJson(String str) => List<Orders>.from(json.decode(str).map((x) => Orders.fromJson(x)));

String ordersToJson(List<Orders> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Orders {
  Orders({
    this.orderId,
    this.orderType,
    this.quantity,
    this.customer,
    this.remarks,
    this.orderState,
    this.designType,
    this.sleeveDesign,
    this.collarDesign,
    this.textTileMeter,
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
  String customer;
  String remarks;
  String orderState;
  String designType;
  String sleeveDesign;
  String collarDesign;
  String textTileMeter;
  String orderDate;
  String deliveryDate;
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

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
    orderId: json["orderID"],
    orderType: json["orderType"],
    quantity: json["quantity"],
    customer: json["customer"],
    remarks: json["remarks"],
    orderState: json["orderState"],
    designType: json["designType"],
    sleeveDesign: json["sleeve_design"],
    collarDesign: json["collar_design"],
    textTileMeter: json["textTile_Meter"],
    orderDate: json["orderDate"],
    deliveryDate: json["deliveryDate"],
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
    "customer": customer,
    "remarks": remarks,
    "orderState": orderState,
    "designType": designType,
    "sleeve_design": sleeveDesign,
    "collar_design": collarDesign,
    "textTile_Meter": textTileMeter,
    "orderDate": orderDate,
    "deliveryDate": deliveryDate,
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
