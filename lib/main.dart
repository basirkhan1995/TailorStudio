import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:get/get.dart';
import 'Screens/Login/login.dart';
import 'SplashScreen.dart';

void main() {

  //StatusBar
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ));
  runApp(MaterialApp(
    title: 'TailorStudio',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      //AppBar Icon Color
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black.withOpacity(.7)),
      ),
    ),

    initialRoute: '/',
    routes: {

      '/': (context) => MyCustomSplashScreen(),
      '/sec': (context) => LoginScreen(),
    },

  ));
}



