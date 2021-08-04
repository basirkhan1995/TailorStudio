// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

List<Orders> ordersFromJson(String str) => List<Orders>.from(json.decode(str).map((x) => Orders.fromJson(x)));

String ordersToJson(List<Orders> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Orders {
  Orders({
    this.userId,
    this.customerId,
    this.lastName,
    this.tailorName,
    this.userName,
    this.orderId,
    this.orderType,
    this.quantity,
    this.firstName,
    this.orderState,
    this.designType,
    this.sleeveDesign,
    this.collarDesign,
    this.remarks,
    this.orderDate,
    this.deliveryDate,
    this.amount,
    this.receivedAmount,
    this.total,
  });

  String userId;
  String customerId;
  String lastName;
  String tailorName;
  String userName;
  String orderId;
  String orderType;
  String quantity;
  String firstName;
  String orderState;
  String designType;
  String sleeveDesign;
  String collarDesign;
  String remarks;
  DateTime orderDate;
  DateTime deliveryDate;
  String amount;
  String receivedAmount;
  String total;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
    userId: json["userID"],
    customerId: json["customerID"],
    lastName: json["lastName"],
    tailorName: json["tailorName"],
    userName: json["userName"],
    orderId: json["orderID"],
    orderType: json["orderType"],
    quantity: json["quantity"],
    firstName: json["firstName"],
    orderState: json["orderState"],
    designType: json["designType"],
    sleeveDesign: json["sleeve_design"],
    collarDesign: json["collar_design"],
    remarks: json["remarks"],
    orderDate: DateTime.parse(json["orderDate"]),
    deliveryDate: DateTime.parse(json["deliveryDate"]),
    amount: json["amount"],
    receivedAmount: json["receivedAmount"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "userID": userId,
    "customerID": customerId,
    "lastName": lastName,
    "tailorName": tailorName,
    "userName": userName,
    "orderID": orderId,
    "orderType": orderType,
    "quantity": quantity,
    "firstName": firstName,
    "orderState": orderState,
    "designType": designType,
    "sleeve_design": sleeveDesign,
    "collar_design": collarDesign,
    "remarks": remarks,
    "orderDate": "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
    "deliveryDate": "${deliveryDate.year.toString().padLeft(4, '0')}-${deliveryDate.month.toString().padLeft(2, '0')}-${deliveryDate.day.toString().padLeft(2, '0')}",
    "amount": amount,
    "receivedAmount": receivedAmount,
    "total": total,
  };
}
