import 'package:flutter/material.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';

class NotificationCenter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      appBar: Env.appBar(context, 'Notification Center'),

      body: Center(
          child: Text('بزودی',style: Env.style(30, PurpleColor)),
      ),
    );
  }
}
