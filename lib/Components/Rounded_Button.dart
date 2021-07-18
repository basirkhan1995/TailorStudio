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
      margin: EdgeInsets.symmetric(vertical: 1,horizontal: 10),
      width: size.width * 0.95,
      height: 45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: TextButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(40),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                return PurpleColor; // Use the component's default.
              },
            ),
          ),
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
