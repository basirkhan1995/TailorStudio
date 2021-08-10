import 'package:flutter/material.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';

class Language extends StatelessWidget {
  const Language({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      appBar:Env.appBar(context, 'Select Language'),
      body: Center(
        child: Container(
          child: Text('بزودی',style: Env.style(30, PurpleColor),),
        ),
      ),
    );
  }
}
