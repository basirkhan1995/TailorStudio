import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tailor/Constants/ConstantColors.dart';

class DescriptionField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final IconData prefix;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final String message;
  final TextInputType inputType;
  const DescriptionField({
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: TextFormField(
          maxLines: 5,
          maxLength: 200,
          textInputAction: TextInputAction.next,
          cursorColor: GreyColor,
          cursorHeight: 25,
          cursorWidth: 1,
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
                borderSide: BorderSide(width: 1, color: GreyColor),
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: Icon(icon,color: GreyColor,size: 25),
              suffixIcon: Icon(prefix,color: GreyColor,size: 25),
              labelText: hintText,
              enabledBorder: OutlineInputBorder(
                gapPadding: 5,
                borderSide: BorderSide(width: 1, color: GreyColor),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                gapPadding: 5,
                borderSide: BorderSide(width: 1.5, color: GreyColor),
                borderRadius: BorderRadius.circular(10),
              )),
        ),
      ),
    );
  }
}
