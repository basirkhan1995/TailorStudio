import 'package:flutter/material.dart';
import 'package:tailor/Components/Rounded_Input_Field.dart';
import 'package:tailor/Components/Rounded_Number_Input.dart';
import 'package:tailor/Constants/ConstantColors.dart';

class NewOrder extends StatelessWidget {
  final _formKey = GlobalKey <FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PurpleColor,
        title: Text('Create Order'),
      ),
      body:SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                RoundedPhoneNo(
                  prefix: Icons.vpn_key_rounded,
                  hintText: 'Order ID',
                  message: 'لطفا نمبر فرمایش را وارید نمایید',
                ),
                RoundedPhoneNo(
                  prefix: Icons.vpn_key_rounded,
                  hintText: 'Qty',
                  message: 'لطفا نمبر فرمایش را وارید نمایید',
                ),
                RoundedInputField(

                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
