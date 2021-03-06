import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tailor/Components/Button.dart';
import 'package:tailor/Screens/Individuals/ShowCustomer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/Screens/Login/login.dart';
import 'package:tailor/Screens/Orders/Orders.dart';
import 'package:tailor/Screens/Settings/Profile.dart';
import 'package:tailor/Screens/Settings/Settings.dart';
import '../About.dart';
import 'package:tailor/Screens/Gallery/Gallery.dart';
import 'Dashboard.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}
class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  SharedPreferences loginData;
  String tailorName = "";
  String studioName = "";
  String tailorEmail = "";
  String username = "";
  String userID = "";
  String fileName;
  bool checkLogin;
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    initial();
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      username = (loginData.getString('username')??"");
      tailorName = (loginData.getString('tailorName')??"");
      studioName = (loginData.getString('studioName')??"");
      tailorEmail = (loginData.getString('userEmail')??"no email");
      fileName = (loginData.getString('fileName')??"no_user.jpg");
      checkLogin = (loginData.getBool('login')??false);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  //removes navigation path
  void _logout() {
    Navigator.popUntil(context, (ModalRoute.withName('/LoginScreen')));
  }

  //ask for App exit
  Future<bool> _onWillPop() {
    return AwesomeDialog(
        context: context,
        animType: AnimType.TOPSLIDE,
        dialogType: DialogType.QUESTION,
        title: 'Exit',
        desc: "?????? ???? ???????????? ???????????????? ???????? ??????????",
        btnCancelText: '????????',
        btnOkText: '??????',
        btnOkColor: PurpleColor,
        btnOkOnPress: () => exit(0),
        btnCancelOnPress: () {},
        btnCancelColor: Colors.red.shade900).show() ?? false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        endDrawer: myDrawer(tailorName??"", tailorEmail??"",fileName??'no_user.jpg', context),
        extendBodyBehindAppBar: true,
        appBar: Env.appBarr(fileName, studioName??"",tailorName??"",tailorEmail??"", context),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: [
              HomeScreen(),
              Individual(),
              Orders(null),
              Settings(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          containerHeight: 60,
          showElevation: true,
          itemCornerRadius: 20,
          curve: Curves.decelerate,
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                activeColor: PurpleColor,
                inactiveColor: BlackColor.withOpacity(.6),
                title: Text('Dashboard'),
                icon: Icon(Icons.apps)
            ),
            BottomNavyBarItem(
                activeColor: PurpleColor,
                inactiveColor: BlackColor.withOpacity(.6),
                title: Text('Customer'),
                icon: Icon(Icons.person_rounded)
            ),
            BottomNavyBarItem(
                activeColor: PurpleColor,
                inactiveColor: BlackColor.withOpacity(.6),
                title: Text('Orders'),
                icon: Icon(Icons.pending_actions)
            ),
            BottomNavyBarItem(
                activeColor: PurpleColor,
                inactiveColor: BlackColor.withOpacity(.6),
                title: Text('Settings'),
                icon: Icon(Icons.settings)
            ),
          ],
        ),
      ),
    );
  }

  // My Drawer
  myDrawer(username, email, image, context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      elevation: 10,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Container(
                      height: 120,
                      width: 120,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 65),
                            child: CachedNetworkImage(
                              imageUrl: Env.urlPhoto + image,
                              imageBuilder: (context, imageProvider) => CircleAvatar(
                                radius: 50,
                                foregroundImage: imageProvider,
                              ),
                              placeholder: (context, url) => CircularProgressIndicator(color: PurpleColor,strokeWidth: 1),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(username, style: Env.style(21, WhiteColor)),
                          Text(email, style: Env.style(12, WhiteColor.withOpacity(.8))),
                          SizedBox(height: 85),
                          Container(
                            width: 290,
                            height: 45,
                            child: Button(text:'Profile',textColor: PurpleColor,paint: WhiteColor ,press: (){
                              //Animated Page Transition
                              Env.animatedGoto(Profile(), context);
                            },),
                          ),
                          SizedBox(height: 20),
                        ],
                      )
                  ),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: GreyColor.withOpacity(.5),
                          offset: Offset(2, 1), //(x,y)
                          blurRadius: 3.0,
                        ),
                      ],
                      color: PurpleColor,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                  ),
                  width: size.width,
                  height: 390,
                ),
                SizedBox(height: 15),
                Env.myTile('????????', Icons.home, Dashboard(), context),
                SizedBox(height: 5),
                Env.myTile('????????????????', Icons.photo, Album(), context),
                SizedBox(height: 5),
                Env.myTile('???????????? ????', Icons.info, AboutTailor(), context),
                SizedBox(height: 100),
                ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.red.shade900,
                        borderRadius: BorderRadius.circular(40),
                    ),
                    child: Icon(
                        Icons.power_settings_new, size: 22,
                        color: Colors.white),
                  ),
                  title: Text(
                      'Log out', style: Env.style(16, Colors.red.shade900)),
                  onTap: () async {
                    await Env.confirmDialog('Sign out', Env.confirmMessage, DialogType.QUESTION, context, setState);
                    if (Env.checkYesNoLogin == true){
                     // print("returns " + Env.checkYesNoLogin.toString());
                      setState(() {
                        Env.loader = false;
                      });
                      //Clear the navigation.
                      _logout();
                      Env.goto(LoginScreen(), context);
                    } else {
                      print("returns " + Env.checkYesNoLogin.toString());
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            )
        ),
      ),
    );
  }

}



