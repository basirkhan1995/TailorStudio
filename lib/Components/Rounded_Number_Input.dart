import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'Input_Field_Container.dart';

class RoundedPhoneNo extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final IconData prefix;
  final String message;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const RoundedPhoneNo({
    Key key,
    this.controller,
    this.message,
    this.prefix,
    this.hintText,
    this.icon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            textAlign: TextAlign.right,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter> [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: (value) {
              if(value == null || value.isEmpty){
                return message;
              }if(value.trim().length <10){
                return 'شماره تماس درست نیست، حد اقل 10 عدد باید باشد';
              }
              return null;
            },
            controller: controller,
            onChanged: onChanged,
            cursorColor: PurpleColor,
            decoration: InputDecoration(
              suffixIcon: Icon(icon,color: PurpleColor,size: 30),
              prefixIcon: Icon(prefix,color: PurpleColor,size: 30),
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
