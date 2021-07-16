import 'package:flutter/material.dart';
import 'package:tailor/Constants/ConstantColors.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      width: size.width * 0.95,
      decoration: BoxDecoration(
        color: LightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
