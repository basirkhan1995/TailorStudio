import 'package:flutter/material.dart';
import 'package:tailor/Constants/ConstantColors.dart';

class IndDetails extends StatelessWidget {
  const IndDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       backgroundColor: PurpleColor,
       title: Text(
         'معلومات مشتری'
       ),
     ),
      body: Text(''),
    );
  }
}
