import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Components/RoundedMeasure.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/HttpServices/HttpServices.dart';
import 'package:tailor/Screens/HomePage/Home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tailor/Screens/Login/login.dart';
import 'package:tailor/Screens/Settings/Profile.dart';
import 'package:cool_alert/cool_alert.dart';

class Env {

  //Server prefix Link Details
  static String url = "https://tailorstudio.000webhostapp.com/";
  static String urlPhoto = "https://tailorstudio.000webhostapp.com/Images/";

  // Dialog Messages
  static String successTitle = "Done";
  static String errorTitle = "Error";
  static String internetTitle = 'No Internet Connection!';
  static String userExistsMessage = "این حساب موجود است، اسم دیگری را امتحان کنید";
  static String wrongInput = "حساب و رمز اشتباه است، لطفا دوباره امتحان کنید";
  static String successMessage = "حساب کاربری شما موفقانه ایجاد گردید";
  static String confirmMessage = 'آیا میخواهید از حساب خود خارج شوید؟';
  static String noInternet = 'لطفا انترنت خود را بررسی کنید';
  static String inputError = "لطفا حساب و رمز خود را درست وارید نمایید";
  static String successCustomerAcc = "حساب مشتری شما موفقانه ایجاد گردید";

  //Static Variables
  static SharedPreferences loginData;
  static bool isLogin;
  static bool checkYesNoLogin;
  static bool deleteYesNo;
  static bool orderSwitch = false;
  static bool check;
  static bool loader = false;
  final controller = CharacterApi();

  //Timer
  final timer = new Future.delayed(const Duration(microseconds: 1000),()=> (throw new Exception('Callback not invoked!'))).timeout(const Duration(microseconds: 500));

  //Empty Profile Asset
   static noUser (){ return AssetImage('photos/background/no_user.jpg');}

  //To Check Internet Connectivity
  static checkConnection(context,voidCallBack)async{
    try{
      final result = await InternetAddress.lookup('www.google.com').timeout(Duration(seconds: 5));
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
        print('Connected');
      }
    } on SocketException catch (_){
      voidCallBack(() {
        Env.loader = false;
      });
      Env.errorDialog('No Internet Connection','لطفا انترنت خود را بررسی کنید', DialogType.ERROR, context, () { });
      print ('No Connection');
    } on TimeoutException catch (_){
      await Future.delayed(Duration(seconds: 6));
      voidCallBack(() {
        Env.loader = false;
      });
      Env.errorDialog('No internet connection', 'لطفا انترنت خود را بررسی کنید', DialogType.ERROR, context, () { });
      print ('No Connection');
    }
  }

  // Static Navigator.push
  static goto(Widget route,context){
    return Navigator.push(context, MaterialPageRoute(builder: (context)=>route));
  }

  //Page Transition with Animation
  static animatedGoto(Widget route,context){
    return Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: route));
  }

  // Auto login
  static checkIfUserIsLogin(context) async {
    loginData = await SharedPreferences.getInstance();
    isLogin = (loginData.getBool('login')??false);
    if (isLogin == true){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  //Static Persian Font Style
  static style(double size, Color paint) {
    return PersianFonts.Samim.copyWith(
      fontSize: size,
      letterSpacing: 1,
      wordSpacing: 1,
      color: paint,
      fontWeight: FontWeight.w500,
    );
  }

  //Static Persian Font Bold TextStyle
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

  //Error Dialog
  static errorDialog(String title, String msg, DialogType dialogType,BuildContext context, VoidCallback onOkPress) {
    return AwesomeDialog(
      autoHide: Duration(seconds: 6),
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

  // Order Method
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

  // Order Card Widgets
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
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('photos/dashboard/orders.png')
                    ),
                      color: LightColor,
                      borderRadius: BorderRadius.circular(15)),
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
                          fontSize: _w / 30,
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
                          fontSize: _w / 32,
                          letterSpacing: 1,
                          wordSpacing: 1,
                          color: BlackColor.withOpacity(.6),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Chip(
                        labelPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          backgroundColor: PurpleColor,label:
                          Text(trailing, style: style(10, WhiteColor),
                      )),
                      // Text(
                      //   trailing,
                      //   maxLines: 1,
                      //   softWrap: true,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: PersianFonts.Samim.copyWith(
                      //     fontSize: _w / 28,
                      //     letterSpacing: 1,
                      //     wordSpacing: 1,
                      //     color: BlackColor.withOpacity(.7),
                      //     fontWeight: FontWeight.w300,
                      //   ),
                      // ),
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


  //Statistic of Dashboard
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

  //Profile Tab (Fame, Measure, Order)
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

  static order(String title, String end){
     return ListTile(
       visualDensity: VisualDensity(horizontal: 0, vertical: -4),
       contentPadding: EdgeInsets.only(right: 25, left: 25),
       title: Text(title,style: Env.boldStyle(14, GreyColor)),
       trailing: Text(end,style: Env.boldStyle(14, BlackColor.withOpacity(.4))),
     );
  }
  static orderTitle(String title, IconData end){
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListTile(
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        contentPadding: EdgeInsets.only(right: 25, left: 25),
        title: Text(title,style: Env.boldStyle(16, PurpleColor)),
        trailing: Icon(end,color: PurpleColor,size: 22),
      ),
    );
  }

  static customAppBar(String title, String subtitle,context){
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListTile(

        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        contentPadding: EdgeInsets.only(right: 25, left: 25),
         leading: IconButton(
           icon: Icon(Icons.arrow_back_ios,size: 18,color: WhiteColor),
           onPressed: ()=>Navigator.pop(context),
         ),
        title: Text(title,style: TextStyle(color: WhiteColor,fontSize: 23)),
        subtitle: Text(subtitle,style: TextStyle(color: WhiteColor,fontSize: 18)),
      ),
    );
  }

  static image(image, double radSize){
    return CachedNetworkImage(
      imageUrl: Env.urlPhoto + image,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: radSize,
        foregroundImage: imageProvider,
      ),
      placeholder: (context, url) => CircularProgressIndicator(color: PurpleColor,strokeWidth: 1),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  // Static Appbar
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
            onTap: () => animatedGoto(Profile(), context),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CachedNetworkImage(
                imageUrl: urlPhoto + url,
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

  // Custom ListTile
  static Widget myTile(String title, IconData icon, Widget route,context){
    return ListTile(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
      },
      trailing: Icon(Icons.arrow_forward_ios,size: 14,color: PurpleColor),
      title: Text(title, style:Env.style(15,BlackColor.withOpacity(.8))),
      leading: Container(
        width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: BlackColor.withOpacity(.06),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Icon(icon,size: 26,color:PurpleColor)),
    );
  }
  //Drawer Leading Icon Circle Design
  static leadStyle(IconData icon){
   return Container(
       width: 50,
       height: 50,
       decoration: BoxDecoration(
         color: BlackColor.withOpacity(.06),
         borderRadius: BorderRadius.circular(40),
       ),
       child: Icon(icon,size: 26,color:PurpleColor));
  }
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
      title: Text(title, style:Env.style(16,BlackColor.withOpacity(.9))),
      subtitle: Text(subtitle,style: style(14, BlackColor.withOpacity(.5))),
      trailing: Icon(Icons.arrow_forward_ios,size: 15,),
    );
  }
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
        leading: Icon(icon,size: 24,color:BlackColor.withOpacity(.7)),
        title: Text(title, style:Env.style(13,BlackColor.withOpacity(.9))),
        subtitle: Text(subtitle,style: style(12, BlackColor.withOpacity(.7)),),
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
        leading: Image.asset('photos/app_icons/'+image,width: 35,color: PurpleColor),
        title: Text(title , style:Env.boldStyle(14,BlackColor.withOpacity(.8))),
        subtitle: Text(subtitle ,style:Env.style(19,BlackColor.withOpacity(.6))),
        trailing: Icon(Icons.arrow_forward_ios,color: PurpleColor,size: 16),
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

  //No Data Message
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
          SizedBox(height: 10),
          InkWell(
            highlightColor: BGBlue,
            hoverColor: BGBlue,
            focusColor: PurpleColor,
            onTap: (){
            },
              child: Text("Try again",style: boldStyle(16, PurpleColor)))
        ],
      ),
    );
  }

  //Cool Dialog
  static confirmShow(context, title, message){
    return CoolAlert.show(
      animType: CoolAlertAnimType.scale,
      confirmBtnColor: SuccessBG,
      loopAnimation: true,
      context: context,
      backgroundColor: SuccessBG,
      type: CoolAlertType.confirm,
      title: title,
      text: message,
    );
  }
}//class Env
