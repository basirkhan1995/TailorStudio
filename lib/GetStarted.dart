import 'package:flutter/material.dart';
import 'package:tailor/Components/Rounded_Button.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Screens/Login/login.dart';
import 'package:tailor/Screens/SignUp/signup.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
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
              Text('خـــــــوش آمــــدید',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: PurpleColor)),
              Text('برنامه خیاطی مدیریت، ثبت فرمایشات و قد اندام مشتریان',
                  style:
                      TextStyle(color: Colors.black38,fontSize: 14,fontWeight: FontWeight.bold)),
              Container(
                height: 350,
                width: size.width * 0.9,
                child: Image.asset('photos/background/tailor_logo.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0,top: 40),
                child: RoundedButton(
                  color: PurpleColor,
                  text: 'ورود',
                  textColor: WhiteColor,
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: RoundedButton(
                  color: PurpleColor,
                  text: 'ایجــــــاد حساب',
                  textColor: WhiteColor,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
