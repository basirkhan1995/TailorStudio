// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

List<Orders> ordersFromJson(String str) => List<Orders>.from(json.decode(str).map((x) => Orders.fromJson(x)));

String ordersToJson(List<Orders> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Orders {
  Orders({
    this.orderId,
    this.firstName,
    this.lastName,
    this.customerId,
    this.orderType,
    this.quantity,
    this.amount,
    this.receivedAmount,
    this.total,
    this.orderState,
    this.designType,
    this.orderDate,
    this.deliveryDate,
    this.remarks,
  });

  String orderId;
  String firstName;
  String lastName;
  String customerId;
  String orderType;
  String quantity;
  String amount;
  String receivedAmount;
  String total;
  String orderState;
  String designType;
  DateTime orderDate;
  DateTime deliveryDate;
  String remarks;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
    orderId: json["orderID"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    customerId: json["customerID"],
    orderType: json["orderType"],
    quantity: json["quantity"],
    amount: json["amount"],
    receivedAmount: json["receivedAmount"],
    total: json["total"],
    orderState: json["orderState"],
    designType: json["designType"],
    orderDate: DateTime.parse(json["orderDate"]),
    deliveryDate: DateTime.parse(json["deliveryDate"]),
    remarks: json["remarks"],
  );

  Map<String, dynamic> toJson() => {
    "orderID": orderId,
    "firstName": firstName,
    "lastName": lastName,
    "customerID": customerId,
    "orderType": orderType,
    "quantity": quantity,
    "amount": amount,
    "receivedAmount": receivedAmount,
    "total": total,
    "orderState": orderState,
    "designType": designType,
    "orderDate": "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
    "deliveryDate": "${deliveryDate.year.toString().padLeft(4, '0')}-${deliveryDate.month.toString().padLeft(2, '0')}-${deliveryDate.day.toString().padLeft(2, '0')}",
    "remarks": remarks,
  };
}
