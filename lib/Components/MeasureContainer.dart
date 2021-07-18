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
      decoration: BoxDecoration(
        border:Border.all(color: PurpleColor),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 1.0),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      width: size.width * 0.3,
      height: 100,
      child: child,
    );
  }
}
