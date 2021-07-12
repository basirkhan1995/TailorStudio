import 'package:flutter/material.dart';
import 'package:tailor/Components/MeasureContainer.dart';
import 'package:tailor/Constants/ConstantColors.dart';

class RoundedMeasureField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final String message;
  const RoundedMeasureField({
    Key key,
    this.controller,
    this.hintText,
    this.message,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MeasureContainer(
      child: TextFormField(
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: GreyColor
        ),
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.numberWithOptions(
          decimal: true,
          signed: false
        ),
        textAlign: TextAlign.right,
        validator: (value) {
          if(value == null || value.isEmpty){
            return message;
          }
          return null;
        },
        controller: controller,
        onChanged: onChanged,
        cursorColor: PurpleColor,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

