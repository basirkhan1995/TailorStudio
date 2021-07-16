import 'package:flutter/material.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:tailor/Constants/ConstantColors.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = PurpleColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _w = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      width: size.width * 0.95,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: PersianFonts.Samim.copyWith(
              fontSize: _w /25,
              letterSpacing: 1,
              wordSpacing: 1,
              color: WhiteColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
