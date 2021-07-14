import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screens/Login/login.dart';
import 'SplashScreen.dart';
import 'package:tailor/GetStarted.dart';

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
      '/sec': (context) => GetStarted(),
      '/third': (context) => LoginScreen(),
    },

  ));
}



