import 'package:flutter/material.dart';
import 'package:tailor/Constants/ConstantColors.dart';

class DefaultContainer extends StatelessWidget {
  final Widget child;
  const DefaultContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      width: size.width * 0.97,
      decoration: BoxDecoration(
        color: LightColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}
