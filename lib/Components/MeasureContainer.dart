import 'package:flutter/material.dart';
import 'package:tailor/Constants/ConstantColors.dart';

class MeasureContainer extends StatelessWidget {
  final Widget child;
  const MeasureContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: size.width * 0.3,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
