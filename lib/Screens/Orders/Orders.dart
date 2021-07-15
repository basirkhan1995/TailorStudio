import 'package:flutter/material.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: PurpleColor,
        foregroundColor: WhiteColor,
        child: Icon(Icons.shopping_cart),
      ),
     appBar: Env.appBar(context,'فرمایشات مشتریان'),
    );
  }
}