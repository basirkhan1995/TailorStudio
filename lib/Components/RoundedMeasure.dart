import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tailor/Constants/ConstantColors.dart';

class MeasureField extends StatelessWidget {
  final String hintText;
  final String prefix;
  final TextEditingController controller;
  const MeasureField({
    Key key,
    this.controller,
    this.hintText,
    this.prefix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        child: TextFormField(
          maxLines: 1,
          textInputAction: TextInputAction.next,
          cursorColor: PurpleColor,
          cursorHeight: 25,
          cursorWidth: 1,
          textAlign: TextAlign.right,
          keyboardType: TextInputType.number,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            prefixText: prefix,
            prefixStyle: TextStyle(
              fontSize: 17,
              color: PurpleColor
            ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 1.5, color: PurpleColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 2, color: PurpleColor),
              )),
        ),
      ),
    );
  }
}
