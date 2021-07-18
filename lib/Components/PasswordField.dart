import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'Input_Field_Container.dart';

class PasswordInputField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final IconData prefix;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final String message;
  final TextInputType inputType;
  const PasswordInputField({
    Key key,
    this.inputType,
    this.controller,
    this.prefix,
    this.hintText,
    this.message,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _passwordVisible;

  @override
  void initState(){
    _passwordVisible = false;
  }
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            textInputAction: TextInputAction.next,
            obscureText: !_passwordVisible,
            textAlign: TextAlign.right,
            validator: (value) {
              if(value == null || value.isEmpty){
                return widget.message;
              }if(value.trim().length <4){
                return 'پسورد شما حداقل باید 4 عدد باشد';
              }
              return null;
            },
            keyboardType: widget.inputType,
            controller: widget.controller,
            onChanged: widget.onChanged,
            cursorColor: PurpleColor,
            decoration: InputDecoration(
              prefixIcon: Icon(widget.icon,color: PurpleColor,size: 25),
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: PurpleColor,
                ),
                onPressed: (){
                  setState(() {
                    _passwordVisible = ! _passwordVisible;
                  });
                },
              ),
              hintText: widget.hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

