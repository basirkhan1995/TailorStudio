import 'package:flutter/material.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';

class CustomerMeasure extends StatelessWidget {
  final Customer post;
  CustomerMeasure(this.post);

  @override
  Widget build(BuildContext context) {
    return Container(
        child:Center(child: Text('اندازه مشتری',style:Env.style(40, PurpleColor)))
    );
  }
}