import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Screens/HomePage/Home.dart';
import 'package:tailor/Screens/Login/login.dart';
import 'package:tailor/Screens/Settings/Settings.dart';

class Env {
  //Server Side prefix Link Details
  static String url = "https://tailorstudio.000webhostapp.com/";
  //Method for Dialog Message
  static String successTitle = "Done";
  static String errorTitle = "خطــا";
  static String internetTitle = 'No Internet!';
  static String userExistsMessage =
      "این حساب کاربری تکراری میباشد، لطفا اسم دیگری را امتحان کنید";
  static String wrongInput =
      "حساب و رمز عبور شما اشتباه میباشد لطفا دوباره کوشش نمایید";
  static String successMessage = "حساب کاربری شما موفقانه ایجاد گردید";
  static String confirmMessage = 'آیا میخواهید از حساب خود خارج شوید؟';
  static String noInternetMessage =
      'شما به انترنت وصل نیستید، لطفا انترنت خود را چک کنید و دوباره امتحان کنید';
  static String inputError =
      "لطفا حساب کاربری و رمز عبور خود را درست وارید نمایید";
  static String successCustomerAcc = "حساب مشتری شما موفقانه ایجاد گردید";
  static SharedPreferences loginData;
  static bool isLogin;



  //Static Appbar
  static Widget appBar(context, title) {
    double _w = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: Size(double.infinity, kToolbarHeight),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        child: AppBar(
          centerTitle: true,
          brightness: Brightness.light,
          backgroundColor: LightColor,
          elevation: 0,
          title: Text(title,
              style: PersianFonts.Samim.copyWith(
                fontSize: _w / 20,
                letterSpacing: 1,
                wordSpacing: 1,
                color: Colors.black.withOpacity(.7),
                fontWeight: FontWeight.w400,
              )),
          actions: [
            IconButton(
              tooltip: 'Settings',
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.settings, color: Colors.black.withOpacity(.7)),
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Settings();
                    },
                  ),
                );
              },
            ),
            Text('  '),
          ],
        ),
      ),
    );
  }

  static Widget tile(title, subtitle, trailing, leading) {
    return ListTile(
      title: Text(title,
          style: PersianFonts.Samim.copyWith(
            fontSize: 17,
            letterSpacing: 1,
            wordSpacing: 1,
            color: WhiteColor,
            fontWeight: FontWeight.w600,
          )),
      subtitle: subtitle,
      trailing: trailing,
      leading: leading,
    );
  }

//auto login
  static checkIfUserIsLogin(context) async {
    loginData = await SharedPreferences.getInstance();
    isLogin = (loginData.getBool('login') ?? false);
    if (isLogin == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }

  // Custom Text Style
  static titleStyle() {
    return TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20, color: WhiteColor);
  }

  //General Alert Dialog function
  static responseDialog(
    String title,
    String msg,
    DialogType dialogType,
    BuildContext context,
    VoidCallback onOkPress,
  ) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: dialogType,
      title: title,
      desc: msg,
      btnOkIcon: Icons.check_circle,
      btnOkColor: PurpleColor,
      btnOkOnPress: onOkPress,
    ).show();
  }

  //Exist Account Error Message
  static errorDialog(String title, String msg, DialogType dialogType,
      BuildContext context, VoidCallback onOkPress) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: dialogType,
      title: title,
      desc: msg,
      btnOkColor: PurpleColor,
      btnOkOnPress: onOkPress,
    ).show();
  }

  //Confirm Dialog
  static confirmDialog(
    String title,
    String msg,
    DialogType dialogType,
    BuildContext context,
    VoidCallback onOkPress,
  ) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: dialogType,
      title: title,
      desc: msg,
      btnOkText: 'بلی',
      btnCancelText: 'نخیر',
      btnOkColor: PurpleColor,
      btnOkOnPress: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
      btnCancelOnPress: () {
        Navigator.pop(context);
      },
      btnCancelColor: Colors.red.shade900,
    ).show();
  }
}
