import 'package:flutter/material.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/OrderList.dart';
class OrderUpdate extends StatelessWidget {
  final MyOrders data;
  OrderUpdate(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Env.appBar(context, "Update"),
    );
  }
}
