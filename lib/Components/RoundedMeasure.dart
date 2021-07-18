import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'Input_Field_Container.dart';

class MeasureField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const MeasureField({
    Key key,
    this.controller,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 4),
        child: TextFormField(
          textInputAction: TextInputAction.next,
          cursorColor: PurpleColor,
          cursorHeight: 25,
          cursorWidth: 1,
          textAlign: TextAlign.left,
          keyboardType: TextInputType.number,
          controller: controller,
          decoration: InputDecoration(
            prefixText: hintText,
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
