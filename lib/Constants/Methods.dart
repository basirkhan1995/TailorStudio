import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Components/RoundedMeasure.dart';
import 'package:tailor/Components/RoundedOrderField.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Screens/HomePage/Home.dart';


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
  static bool checkYesNoLogin;
  static bool check;

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

  //Custom style
  //Static TextStyle
  static txtStyle(double size) {
    return PersianFonts.Samim.copyWith(
      fontSize: size,
      letterSpacing: 1,
      wordSpacing: 1,
      fontWeight: FontWeight.w600,
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
  static confirmDialog(String title, String msg, DialogType dialogType, BuildContext context, voidCallBack ) {
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
        loginData.setBool('login', false);
        voidCallBack(() {
          checkYesNoLogin = true;
        });
      },
      btnCancelOnPress: () {
        voidCallBack(() {
          checkYesNoLogin = false;
        });
      },
      btnCancelColor: Colors.red.shade900,
    ).show();
  }

  //Confirm Delete Dialog
//Confirm Dialog
  static confirmDelete(String title, String msg, DialogType dialogType, BuildContext context, voidCallBack ) {
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
        voidCallBack(() {
          checkYesNoLogin = true;
        });
      },
      btnCancelOnPress: () {
        voidCallBack(() {
          checkYesNoLogin = false;
        });
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
  static Widget myOrder(title,subtitle,controller,hint){
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
          subtitle: Text(subtitle),
          trailing: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: 48),
            child: IntrinsicWidth(
              child: MeasureField(
                controller: controller,
                hintText: hint,
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Measurement Method
  static Widget myTXTOrder(title,subtitle,controller,hint){
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
          subtitle: Text(subtitle),
          trailing: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: 48),
            child: IntrinsicWidth(
              child: OrderField(
                controller: controller,
                hintText: hint,
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

  static popMenu(Color paint, String title,IconData icon, VoidCallback press){
    return PopupMenuButton(
      icon: Icon(Icons.more_vert,
          color: PurpleColor),
      elevation: 20,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: PurpleColor, width: 2)),
      itemBuilder: (context) => [
        PopupMenuItem(
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                InkWell(child: Text('Create order'),onTap: press,
                ),
                Spacer(),
                Icon(Icons.shopping_cart,color: PurpleColor),
                Divider(height: 1),
              ],
            )),
        PopupMenuItem(
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                InkWell(child: Text('Edit'),onTap: press),
                Icon(Icons.edit,color: PurpleColor)
              ],
            )),
        PopupMenuItem(
            child: Row(
              children: [
                InkWell(
                  child: Text('Delete',style: Env.style(16, Colors.red.shade900)),
                  onTap: press,
                ),
                Spacer(),
                Icon(Icons.delete,color:Colors.red.shade900)],
            )),

      ],
    );
  }

  //Dashboard Widgets
 static Widget card(String title, String subtitle, IconData icon, Widget route, paint,context,animation1, animation2) {
    double _w = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: animation1.value,
      child: Transform.translate(
        offset: Offset(0, animation2.value),
        child: Container(
          height: _w / 2.3,
          width: _w,
          padding: EdgeInsets.fromLTRB(_w / 20, 0, _w / 20, _w / 20),
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => route));
            },
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: LightColor,
                      offset: Offset(0,3), //(x,y)
                      blurRadius: 80.0,
                    ),
                  ],
                  color: Color(paint),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  border: Border.all(
                      color: Colors.white.withOpacity(.1), width: 1)),
              child: Padding(
                padding: EdgeInsets.all(_w / 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: _w / 3,
                      width: _w / 3,
                      decoration: BoxDecoration(
                          color: WhiteColor.withOpacity(.2),
                          borderRadius: BorderRadius.circular(30)),
                      child: Icon(
                        icon,
                        color: WhiteColor,
                        size: _w / 7,
                      ),
                    ),
                    SizedBox(width: _w / 40),
                    SizedBox(
                      width: _w / 2.05,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: PersianFonts.Samim.copyWith(
                              fontSize: _w / 20,
                              letterSpacing: 1,
                              wordSpacing: 1,
                              color: WhiteColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            subtitle,
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: PersianFonts.Samim.copyWith(
                              fontSize: _w / 30,
                              letterSpacing: 1,
                              wordSpacing: 1,
                              color: WhiteColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            'Tap to know more',
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: _w / 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Custom ListTile
 static Widget myTile(String title, IconData icon, Widget route,context){
    return ListTile(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
      },
      title: Text(title, style:Env.style(16,BlackColor.withOpacity(.7))),
      leading: Icon(icon,size: 30,color:PurpleColor),
    );
  }

  // Custom Full ListTile
  static Widget tile(title,subtitle, IconData icon, voidCallback,context){
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      onTap: () {
        HapticFeedback.lightImpact();
        voidCallback();
      },
      leading: Icon(icon,size: 30,color:PurpleColor),
      title: Text(title, style:Env.style(17,PurpleColor)),
      subtitle: Text(subtitle,style: style(16, BlackColor.withOpacity(.5)),),
    );

  }

  static Widget customTile(title, subtitle, voidCallback,context){
    return Card(
      margin: EdgeInsets.only(left:10, right:10, bottom:3,top:3),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)),
      elevation: 15,
      child: ListTile(
        horizontalTitleGap: 20,
          minVerticalPadding: 5,
        onTap: () {
          HapticFeedback.lightImpact();
          voidCallback();
        },
        leading: Icon(Icons.article,size: 50,color: PurpleColor,),
        title: Text(title , style:Env.style(18,PurpleColor)),
        subtitle: Text(subtitle,style:Env.style(18,BlackColor.withOpacity(.6))),
        trailing: Icon(Icons.edit,color: PurpleColor,size: 28),
      ),
    );
  }

  static Widget setting(IconData icon,title, subtitle, Widget route ,context){
    return ListTile(
      horizontalTitleGap: 5,
      minVerticalPadding: 0,
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
        ///route
      },
      leading: Icon(icon,size: 50,color: PurpleColor),
      title: Text(title , style:Env.style(18,PurpleColor)),
      subtitle: Text(subtitle,style: TextStyle(fontSize: 23),),
      trailing: Icon(Icons.edit,color: PurpleColor,size: 28),
    );
  }

  //My Appbar
  static Widget myBar(title, IconData icon, voidCallback, context) {
    double _w = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: Size(double.infinity, kToolbarHeight),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        child: AppBar(
          actions: [
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(icon, color: Colors.black.withOpacity(.7)),
              onPressed: () {
                HapticFeedback.lightImpact();
                voidCallback();
              },
            ),
          ],
          centerTitle: true,
          brightness: Brightness.light,
          backgroundColor: LightColor,
          elevation: 0,
          title: Text(
            title,
            style: TextStyle(
              fontSize: _w / 17,
              color: Colors.black.withOpacity(.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: IconButton(
            tooltip: 'navigation',
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black.withOpacity(.7)),
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  static Widget bar(title, IconData icon, voidCallback, context,bottom) {
    double _w = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: Size(double.infinity, kToolbarHeight),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        child: AppBar(
          bottom: bottom,
          actions: [
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(icon, color: Colors.black.withOpacity(.7)),
              onPressed: () {
                HapticFeedback.lightImpact();
                voidCallback();
              },
            ),
          ],
          centerTitle: true,
          brightness: Brightness.light,
          backgroundColor: LightColor,
          elevation: 0,
          title: Text(
            title,
            style: TextStyle(
              fontSize: _w / 17,
              color: Colors.black.withOpacity(.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: IconButton(
            tooltip: 'navigation',
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black.withOpacity(.7)),
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  static bottomSheet(context) {
     showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new TextFormField(),
                ],
              ),
            ),
          );
        }
    );
  }

}//class Env
