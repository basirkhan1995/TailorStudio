import 'package:flutter/material.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      appBar: Env.appBar(context, 'Help Center'),
      body: Center(
        child: Text('contact us: basirkhan.hashemi@gmail.com')
      ),
    );
  }
}
