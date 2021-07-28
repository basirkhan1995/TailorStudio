import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Components/RoundedMeasure.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Screens/HomePage/Home.dart';
import 'package:tailor/Screens/Login/login.dart';

class Env {

  ///Server prefix Link Details
  static String url = "https://tailorstudio.000webhostapp.com/";
  static String urlPhoto = "https://tailorstudio.000webhostapp.com/Images/";

  /// Dialog Messages
  static String successTitle = "Done";
  static String errorTitle = "خطــا";
  static String internetTitle = 'No Internet!';
  static String userExistsMessage = "این حساب کاربری تکراری میباشد، لطفا اسم دیگری را امتحان کنید";
  static String wrongInput = "حساب و رمز عبور شما اشتباه میباشد لطفا دوباره کوشش نمایید";
  static String successMessage = "حساب کاربری شما موفقانه ایجاد گردید";
  static String confirmMessage = 'آیا میخواهید از حساب خود خارج شوید؟';
  static String noInternetMessage = 'شما به انترنت وصل نیستید، لطفا انترنت خود را چک کنید و دوباره امتحان کنید';
  static String inputError = "لطفا حساب کاربری و رمز عبور خود را درست وارید نمایید";
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: BlackColor.withOpacity(.7)),
            onPressed: () => Navigator.of(context).pop(),
          ) ,
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
              tooltip: 'Home',
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.home_rounded, color: Colors.black.withOpacity(.7)),
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Dashboard();
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

//auto login
  static checkIfUserIsLogin(context) async {
    loginData = await SharedPreferences.getInstance();
    isLogin = (loginData.getBool('login') ?? false);
    if (isLogin == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }

  //Static TextStyle
  static style(double size, Color paint) {
    return PersianFonts.Samim.copyWith(
      fontSize: size,
      letterSpacing: 1,
      wordSpacing: 1,
      color: paint,
      fontWeight: FontWeight.w500,
    );
  }

  static fontStyle(double size, Color paint) {
    return PersianFonts.Samim.copyWith(
      fontSize: size,
      letterSpacing: 1,
      wordSpacing: 1,
      color: paint,
      fontWeight: FontWeight.w500,
    );
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
  static confirmDialog(String title, String msg, DialogType dialogType, BuildContext context, VoidCallback onOkPress,
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

  //Measurement Method
  static Widget myMeasure(title,image,controller){
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 3),
      child: Container(
        padding: EdgeInsets.only(top: 6, bottom: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: PurpleColor)
        ),
        child: ListTile(
          leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(image)),
          title: Text(title,style:Env.style(17, PurpleColor)),
          trailing: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: 48),
            child: IntrinsicWidth(
              child: MeasureField(
                controller: controller,
                hintText: '0.00 ',
                prefix: 'inch ',
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Measurement Method
  static Widget myOrder(title,controller,hint,prefix){
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 3,left: 10, right: 10),
      child: Container(
        padding: EdgeInsets.only(top: 3, bottom: 6,left: 10,right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: PurpleColor)
        ),
        child: ListTile(
          title: Text(title,style:Env.style(17, PurpleColor)),
          trailing: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: 48),
            child: IntrinsicWidth(
              child: MeasureField(
                controller: controller,
                hintText: hint,
                prefix: prefix,
              ),
            ),
          ),
        ),
      ),
    );
  }


  static dateTimePicker(String label){
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 3,left: 10, right: 10),
      child: Container(
        padding: EdgeInsets.only(top: 3, bottom: 6,left: 10,right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: PurpleColor)
        ),
        child: DateTimePicker(
          timeFieldWidth: 50,
          style: style(18, PurpleColor),
          type: DateTimePickerType.dateTimeSeparate,
          dateMask: 'd MMM, yyyy',
          initialValue: DateTime.now().toString(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          icon: Icon(Icons.event,color: PurpleColor,size: 30),
          dateLabelText: label,
          timeLabelText: "ساعت",
          selectableDayPredicate: (date) {
            // Disable weekend days to select from the calendar
            if (date.weekday == 6 || date.weekday == 7) {
              return false;
            }
            return true;
          },
          onChanged: (val) => print(val),
          validator: (val) {
            print(val);
            return null;
          },
          onSaved: (val) => print(val),
        ),
      ),
    );
  }

}//class Env
