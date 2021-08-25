// To parse this JSON data, do
//
//     final statistics = statisticsFromJson(jsonString);

import 'dart:convert';

List<Statistics> statisticsFromJson(String str) =>
    List<Statistics>.from(json.decode(str).map((x) => Statistics.fromJson(x)));

String statisticsToJson(List<Statistics> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Statistics {
  Statistics({
    this.pendingCount,
    this.completeCount,
    this.customerCount,
    this.ordersCount,
    this.totalPaid,
    this.totalUnPaid,
  });

  String pendingCount;
  String completeCount;
  String customerCount;
  String ordersCount;
  String totalPaid;
  String totalUnPaid;

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        pendingCount: json["Pending_count"],
        completeCount: json["Complete_count"],
        customerCount: json["Customer_count"],
        ordersCount: json["Orders_Count"],
        totalPaid: json["Total_Paid"],
        totalUnPaid: json["Total_UnPaid"],
      );

  Map<String, dynamic> toJson() => {
        "Pending_count": pendingCount,
        "Complete_count": completeCount,
        "Customer_count": customerCount,
        "Orders_Count": ordersCount,
        "Total_Paid": totalPaid,
        "Total_UnPaid": totalUnPaid,
      };
}
