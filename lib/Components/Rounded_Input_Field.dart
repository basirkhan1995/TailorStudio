import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'Input_Field_Container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final IconData prefix;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final String message;
  final TextInputType inputType;
  const RoundedInputField({
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
    return TextFieldContainer(
      child: Padding(
        padding: const EdgeInsets.only(right: 10,),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.right,
            validator: (value) {
              if(value == null || value.isEmpty){
                return message;
              }
              return null;
            },
            keyboardType: inputType,
            controller: controller,
            onChanged: onChanged,
            cursorColor: PurpleColor,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left:0.0, right: 5.0, top: 10),
              prefixIcon: Icon(icon,color: PurpleColor,size: 25),
              suffixIcon: Icon(prefix,color: PurpleColor,size: 25),
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

