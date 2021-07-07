import 'package:flutter/material.dart';
import 'package:tailor/Constants/ConstantColors.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "ایجــــاد حســـاب   " : "ورود",
            style: TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.bold,
            fontSize: 20,
            ),
          ),
        ),
        Text(
          login ? "حسـاب ندارید؟  " : "  حسـاب دارید؟   ",
          style: TextStyle(color: PurpleColor,fontSize: 17),
        ),

      ],
    );
  }
}
