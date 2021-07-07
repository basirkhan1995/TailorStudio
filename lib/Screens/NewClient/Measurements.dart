import 'package:flutter/material.dart';
import 'package:tailor/Constants/ConstantColors.dart';

class Measure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: PurpleColor,
        title: Text(
          'قد اندام',
          style: TextStyle(color: WhiteColor),
        ),
      ),
      body: MeasureDetails(),
    );
  }
}

class MeasureDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

        ],
      ),
    );
  }
}

