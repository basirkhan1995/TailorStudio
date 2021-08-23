import 'package:flutter/material.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:tailor/Components/Rounded_Button.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Screens/Login/login.dart';
import 'package:tailor/Screens/SignUp/signup.dart';

import 'Screens/Login/background.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Text('خـــــــوش آمــــدید',
                    style: PersianFonts.Samim.copyWith(
                      fontSize: _w / 10,
                      letterSpacing: 1,
                      wordSpacing: 1,
                      color: PurpleColor,
                      fontWeight: FontWeight.w500,
                    )),
                Text('برنامه خیاطی مدیریت، ثبت فرمایشات و قد اندام مشتریان',
                    style: PersianFonts.Samim.copyWith(
                      fontSize: _w / 30,
                      letterSpacing: 1,
                      wordSpacing: 1,
                      color: Colors.black.withOpacity(.5),
                      fontWeight: FontWeight.w200,
                    )),
                SizedBox(height: 70),
                Container(
                  height: 300,
                  width: size.width * 0.9,
                  child: Image.asset('photos/background/tailor_logo.png'),
                ),
                SizedBox(height: 40),
                RoundedButton(
                  color: PurpleColor,
                  text: 'ورود',
                  textColor: WhiteColor,
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
                RoundedButton(
                  color: PurpleColor,
                  text: 'ایجـاد حساب',
                  textColor: WhiteColor,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
