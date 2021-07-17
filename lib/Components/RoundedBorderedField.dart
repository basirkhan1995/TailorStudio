import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'Input_Field_Container.dart';

class RoundedBorderedField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final IconData prefix;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final String message;
  final TextInputType inputType;
  const RoundedBorderedField({
    Key key,
    this.inputType,
    this.controller,
    this.prefix,
    this.hintText,
    this.message,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 4),
        child: TextFormField(
          validator: (value) {
            if(value == null || value.isEmpty){
              return message;
            }
            return null;
          },
          keyboardType: inputType,
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            errorBorder: OutlineInputBorder(
              gapPadding: 5,
              borderSide: BorderSide(width: 1, color: PurpleColor),
              borderRadius: BorderRadius.circular(15),
            ),
              prefixIcon: Icon(icon,color: PurpleColor,size: 25),
              suffixIcon: Icon(prefix,color: PurpleColor,size: 25),
              labelText: hintText,
              enabledBorder: OutlineInputBorder(
                gapPadding: 5,
                borderSide: BorderSide(width: 1, color: PurpleColor),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                gapPadding: 5,
                borderSide: BorderSide(width: 1.5, color: PurpleColor),
                borderRadius: BorderRadius.circular(15),
              )),
        ),
      ),
    );
  }
}
