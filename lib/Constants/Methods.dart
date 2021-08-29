import 'dart:io';
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
import 'package:tailor/HttpServices/HttpServices.dart';
import 'package:tailor/Screens/HomePage/Home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tailor/Screens/Settings/Profile.dart';


class Env {

  ///Server prefix Link Details
  static String url = "https://tailorstudio.000webhostapp.com/";
  static String urlPhoto = "https://tailorstudio.000webhostapp.com/Images/";
  String myImage;
  static File imageFile;
  /// Dialog Messages
  static String successTitle = "Done";
  static String errorTitle = "خطــا";
  static String internetTitle = 'No Internet Connection!';
  static String userExistsMessage = "این حساب کاربری تکراری میباشد، لطفا اسم دیگری را امتحان کنید";
  static String wrongInput = "حساب و رمز عبور شما اشتباه میباشد لطفا دوباره کوشش نمایید";
  static String successMessage = "حساب کاربری شما موفقانه ایجاد گردید";
  static String confirmMessage = 'آیا میخواهید از حساب خود خارج شوید؟';
  static String noInternetMessage = 'لطفا انترنت خود را بررسی کنید و دوباره امتحان کنید';
  static String inputError = "لطفا حساب کاربری و رمز عبور خود را درست وارید نمایید";
  static String successCustomerAcc = "حساب مشتری شما موفقانه ایجاد گردید";
  static String noInternetMsg = 'لطفا ارتباط انترنت خود را بررسی کنید و دوباره امتحان کنید';
  static String timeOut = 'لطفا انترنت خود را بررسی کرده دوباره کوشش نمایید';
  static SharedPreferences loginData;
  static bool isLogin;
  static bool checkYesNoLogin;
  static bool deleteYesNo;
  static bool check;
  final controller = CharacterApi();

  //Static Appbar
  static Widget appBar(context, title) {
    double _w = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: Size(double.infinity, kToolbarHeight),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded,size: 20 ,color: PurpleColor),
            onPressed: () => Navigator.of(context).pop(),
          ) ,
          centerTitle: true,
          brightness: Brightness.light,
          backgroundColor: WhiteColor,
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
    isLogin = (loginData.getBool('login')??false);
    if (isLogin == true){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
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

  //Static Bold TextStyle
  static boldStyle(double size, Color paint) {
    return PersianFonts.Samim.copyWith(
      fontSize: size,
      letterSpacing: 1,
      wordSpacing: 1,
      color: paint,
      fontWeight: FontWeight.w600,
    );
  }

  //General Alert Dialog function
  static responseDialog(String title, String msg, DialogType dialogType, BuildContext context, VoidCallback onOkPress) {
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
  static httpError(String title, String msg, DialogType dialogType,BuildContext context, Widget route) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: dialogType,
      title: title,
      desc: msg,
      btnOkColor: PurpleColor,
      btnOkOnPress: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>route));
      },
    ).show();
  }


  //Exist Account Error Message
  static errorDialog(String title, String msg, DialogType dialogType,BuildContext context, VoidCallback onOkPress) {
    return AwesomeDialog(
      autoHide: Duration(seconds: 5),
      buttonsBorderRadius: BorderRadius.circular(5),
      dialogBorderRadius: BorderRadius.circular(15),
      context: context,
      animType: AnimType.BOTTOMSLIDE,
      dialogType: dialogType,
      title: title,
      desc: msg,
      btnOkColor: PurpleColor,
      btnOkOnPress: onOkPress,
    ).show();
  }

  //Confirm Dialog
  static confirmExit(String title, String msg, DialogType dialogType, BuildContext context, voidCallBack ) {
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
          deleteYesNo = true;
        });
      },
      btnCancelOnPress: () {
        voidCallBack(() {
          deleteYesNo = false;
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
  static Widget myOrder(title,subtitle,controller,hintText,prefix,inputType){
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 3,left: 10, right: 10),
      child: Container(
        padding: EdgeInsets.only(top: 3, bottom: 6,left: 10,right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: GreyColor)
        ),
        child: ListTile(
          title: Text(title,style:Env.style(17, GreyColor)),
          subtitle: Text(subtitle),
          trailing: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: 48),
            child: IntrinsicWidth(
              child:TextFormField(
                maxLines: 1,
                textInputAction: TextInputAction.next,
                cursorColor: PurpleColor,
                cursorHeight: 25,
                cursorWidth: 1,
                textAlign: TextAlign.right,
                keyboardType: inputType,
                controller: controller,
                decoration: InputDecoration(
                    hintText: hintText,
                    prefixText: prefix,
                    prefixStyle: TextStyle(
                        fontSize: 17,
                        color: GreyColor
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1.5, color: GreyColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 2, color: GreyColor),
                    )),
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

  static dateTimePicker(String label,controller){
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 3,left: 10, right: 10),
      child: Container(
        padding: EdgeInsets.only(top: 3, bottom: 6,left: 10,right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: PurpleColor)
        ),
        child: DateTimePicker(
          controller: controller,
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

  //statistic Home Widget function
  static Widget statistic(String title, String subtitle, IconData icon, Widget route, paint,context,animation1, animation2) {
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
                      color: GreyColor,
                      offset: Offset(0,3), //(x,y)
                      blurRadius: 10.0,
                    ),
                  ],
                  color: Color(paint),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  border: Border.all(color: Colors.white.withOpacity(.1), width: 1)),
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
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(80),topRight:Radius.circular(10),bottomRight: Radius.circular(10) )),
                      child: Icon(
                        icon,
                        color: WhiteColor,
                        size: _w / 8,
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
                              fontSize: _w / 14,
                              letterSpacing: 1,
                              wordSpacing: 1,
                              color: WhiteColor,
                              fontWeight: FontWeight.w300,
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

  //Dashboard Widgets
 static Widget card(String title, String subtitle, trailing, IconData icon, Widget route, paint,context){
    double _w = MediaQuery.of(context).size.width;
    return Container(
      height: _w / 3,
      width: _w,
      padding: EdgeInsets.fromLTRB(_w / 20, 0, _w / 20, _w / 40),
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
                  color: GreyColor.withOpacity(.4),
                  offset: Offset(1,1), //(x,y)
                  blurRadius: 5.0,
                ),
              ],
              color: Color(paint),
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(color: Colors.white.withOpacity(.1), width: 1)),
          child: Padding(
            padding: EdgeInsets.all(_w / 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: _w / 4,
                  width: _w / 3,
                  decoration: BoxDecoration(
                      color: LightColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Icon(
                    icon,
                    color: GreyColor,
                    size: _w / 8,
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
                          color: BlackColor.withOpacity(.7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        subtitle,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: PersianFonts.Samim.copyWith(
                          fontSize: _w / 25,
                          letterSpacing: 1,
                          wordSpacing: 1,
                          color: BlackColor.withOpacity(.6),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        trailing,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: PersianFonts.Samim.copyWith(
                          fontSize: _w / 25,
                          letterSpacing: 1,
                          wordSpacing: 1,
                          color: BlackColor.withOpacity(.7),
                          fontWeight: FontWeight.w300,
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
    );
  }

  static dashboard(leading,title, subtitle,context){
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Container(
        //padding: EdgeInsets.only(top: 5),
        child: Column(
          children: [
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                    width: 40,
                    height: 40,
                    child: Image.asset('photos/app_icons/'+leading,width: 40,color: PurpleColor)),
              ),
              subtitle: Text(title),
              title: Text(subtitle,style: TextStyle(fontSize: 20,color: BlackColor.withOpacity(.8),fontWeight: FontWeight.w700),),
              trailing: Icon(Icons.info_outline),
            ),
          ],
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: GreyColor.withOpacity(.4),
              offset: Offset(1,1), //(x,y)
              blurRadius: 2.0,
            ),
          ],
          color: WhiteColor,
          borderRadius: BorderRadius.circular(15),
        ),
        height: 75,
        width: size.width * .98,
      ),
    );
  }


  //
  static tab(title){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: PurpleColor, width: 1.5)),
      child: Align(
        alignment: Alignment.center,
        child: Text(title,style: Env.style(14,null)),
      ),
    );
  }

  static cachedImage(image){
    return CachedNetworkImage(
      imageUrl: Env.urlPhoto + image,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: 30,
        foregroundImage: imageProvider,
      ),
      placeholder: (context, url) => CircularProgressIndicator(color: PurpleColor,strokeWidth: 1),
      errorWidget: (context, url, error) => CircleAvatar(
          radius: 30,
          child: Image.asset('photos/background/no_user.jpg')),
    );
  }

  static image(image){
    return CachedNetworkImage(
      imageUrl: Env.urlPhoto + image,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: 78,
        foregroundImage: imageProvider,
      ),
      placeholder: (context, url) => CircularProgressIndicator(color: PurpleColor,strokeWidth: 1),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }


  //My Appbar
  static Widget appBarr(url,title,user,email, context) {
    double _w = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: Size(double.infinity, kToolbarHeight),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        child: AppBar(
          centerTitle: true,
          brightness: Brightness.light,
          backgroundColor: WhiteColor,
          elevation: 10,
          title: Text(
            title,
            style: TextStyle(
              fontSize: _w / 20,
              color: Colors.black.withOpacity(.7),
              fontWeight: FontWeight.w500,
            ),
          ),

          leading: GestureDetector(
            onTap: (){
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => SimpleDialog(
                  titlePadding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Row(
                    children: [
                      Text('Account'), Spacer(), IconButton(
                      icon: Icon(Icons.edit,color: PurpleColor),
                      onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
                    }),
                  ],),
                  children: <Widget>[
                    ListTile(
                      leading:  Icon(Icons.account_circle,color: PurpleColor),
                      title:  Text(user,style:TextStyle(fontSize:18)),
                      onTap: () => Navigator.pop(context, user),
                    ),
                    ListTile(
                      leading:  Icon(Icons.email,color: PurpleColor),
                      title:  Text(email,style:TextStyle(fontSize:12)),
                      onTap: () => Navigator.pop(context, email),
                    ),
                  ],
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CachedNetworkImage(
                imageUrl: Env.urlPhoto + url,
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  foregroundImage: imageProvider,
                ),
                placeholder: (context, url) => CircularProgressIndicator(color: PurpleColor,strokeWidth: 1),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          )
        ),
      ),
    );
  }

  //Dashboard Widgets
  static Widget myCard(String title, String subtitle, trailing, IconData icon, Widget route, paint,context,animation1, animation2) {
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
                      color: GreyColor,
                      offset: Offset(0,3), //(x,y)
                      blurRadius: 10.0,
                    ),
                  ],
                  color: Color(paint),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  border: Border.all(color: Colors.white.withOpacity(.1), width: 1)),
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
                        size: _w / 8,
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
                              fontSize: _w / 25,
                              letterSpacing: 1,
                              wordSpacing: 1,
                              color: WhiteColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Row(
                            children: [

                              Text(
                                trailing,
                                maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: _w / 26,
                                ),
                              ),
                            ],
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
      trailing: Icon(Icons.arrow_forward_ios,size: 20,color: PurpleColor),
      title: Text(title, style:Env.style(15,BlackColor.withOpacity(.8))),
      leading: Container(
        width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: BlackColor.withOpacity(.06),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Icon(icon,size: 30,color:PurpleColor)),
    );
  }

  // Custom Full ListTile
  static Widget tile(title,subtitle, IconData icon, voidCallback,context){
    return ListTile(
      horizontalTitleGap: 10,
      minVerticalPadding: 5,
      contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      onTap: () {
        HapticFeedback.lightImpact();
        voidCallback();
      },
      leading: Icon(icon,size: 27,color:BlackColor.withOpacity(.7)),
      title: Text(title, style:Env.style(17,BlackColor.withOpacity(.9))),
      subtitle: Text(subtitle,style: style(16, BlackColor.withOpacity(.5))),
      trailing: Icon(Icons.arrow_forward_ios,size: 18,),
    );
  }

  //My Setting
  static Widget settingTile(title,subtitle, IconData icon, Widget route ,context){
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        onTap: () {
          HapticFeedback.lightImpact();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>route));
        },
        leading: Icon(icon,size: 28,color:BlackColor.withOpacity(.7)),
        title: Text(title, style:Env.style(14,BlackColor.withOpacity(.9))),
        subtitle: Text(subtitle,style: style(13, BlackColor.withOpacity(.7)),),
      ),
    );

  }

  static Widget orderTile(title, subtitle, voidCallback,context){
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
        leading: Icon(Icons.edit,size: 45,color: BlackColor.withOpacity(.7)),
        title: Text(title , style:Env.style(16,BlackColor.withOpacity(.8))),
        subtitle: Text(subtitle,style:Env.style(20,BlackColor.withOpacity(.6))),
        trailing: Icon(Icons.edit,color: PurpleColor,size: 28),
      ),
    );
  }

  static Widget customTile(title, subtitle, image, voidCallback,context){
    final shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0));
    return Card(
      margin: EdgeInsets.only(left:10, right:10, bottom:3,top:3),
        shape: shape,
      elevation: 2,
      child: ListTile(
        shape:shape,
        horizontalTitleGap: 20,
          minVerticalPadding: 5,
        onTap: () {
          HapticFeedback.lightImpact();
          voidCallback();
        },
        leading: Image.asset('photos/app_icons/'+image,width: 40,color: PurpleColor),
        title: Text(title , style:Env.boldStyle(15,BlackColor.withOpacity(.8))),
        subtitle: Text(subtitle,style:Env.style(18,BlackColor.withOpacity(.6))),
        trailing: Icon(Icons.info_outline,color: PurpleColor,size: 28),
      ),
    );
  }

  static Widget emptyBox(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('photos/app_icons/empty.png',width: 80,color:PurpleColor),
          SizedBox(height: 10),
          Text('NO DATA',style:Env.boldStyle(20, BlackColor.withOpacity(.6))),
          SizedBox(height: 5),
          Text('هیج مورد دریافت نشد، لطفا دوباره کوشش نمایید',style:Env.style(14, BlackColor.withOpacity(.4))),

        ],
      ),
    );
  }

  static Widget orderDetails(title, subtitle, trailing,image,voidCallback,context){
    final shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0));
    return Card(
      margin: EdgeInsets.only(left:10, right:10, bottom:3,top:3),
      shape: shape,
      elevation: 1,
      child: ListTile(
        shape:shape,
        horizontalTitleGap: 20,
        minVerticalPadding: 5,
        onTap: () {
          HapticFeedback.lightImpact();
          voidCallback();
        },
        leading: Image.asset('photos/app_icons/'+image,width:40,color: PurpleColor,),
        title: Text(title , style:Env.boldStyle(14,BlackColor.withOpacity(.8))),
        subtitle: Text(subtitle,style:Env.style(18,BlackColor.withOpacity(.6))),
        trailing: Icon(trailing,color: PurpleColor,size: 28),
      ),
    );
  }

  //My Appbar
  static Widget myBar(title, IconData icon, image, voidCallback, context) {
    double _w = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: Size(double.infinity, kToolbarHeight),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        child: AppBar(
          actions: [
            image == null ?
            IconButton(
              icon: Icon(Icons.home,color: GreyColor),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
              },
            ):IconButton(
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
          backgroundColor: WhiteColor,
          elevation: 0,
          title: Text(
            title,
            style: TextStyle(
              fontSize: _w / 20,
              color: Colors.black.withOpacity(.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: IconButton(
            tooltip: 'navigation',
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Icon(Icons.arrow_back_ios_rounded,size:20, color: PurpleColor),
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  static Widget horizontalList(IconData title, subtitle){
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 5),
      height: 100,
      decoration: BoxDecoration(color: WhiteColor, borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(title,size: 35,),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 0),
              child: Text(
                subtitle,
                style: TextStyle(fontSize: 16, color: BlackColor.withOpacity(.5)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget rowBar(IconData title, subtitle, trailing){
    return  Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(title,color: BlackColor.withOpacity(.6),size: 24),
          Text(subtitle,style: style(22, BlackColor.withOpacity(.7))),
          Text(trailing,style: style(12, BlackColor.withOpacity(.7))),
        ],
      ),
      width: 80.0,
      height: 50,
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
          backgroundColor: WhiteColor,
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
