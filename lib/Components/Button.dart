import 'package:flutter/material.dart';
import 'package:persian_fonts/persian_fonts.dart';

class Button extends StatelessWidget {
  final String text;
  final Function press;
  final Color paint;
  final Color textColor;
  const Button({
    Key key,
    this.text,
    this.press,
    this.textColor,
    this.paint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _w = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
      width: size.width * 0.35,
      height: 45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: TextButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(40.0),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                return paint; // Use the component's default.
              },
            ),
          ),
          onPressed: press,
          child: Text(
            text,
            style: PersianFonts.Samim.copyWith(
              fontSize: _w / 25,
              letterSpacing: 1,
              wordSpacing: 1,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
