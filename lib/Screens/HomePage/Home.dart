import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
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
  String tailorName = "Tailor Name";
  String studioName = "Tailor Studio";
  String tailorEmail = "Tailor Email";
  String username = "username";
  String userID= "userID";
  String fileName = "";
  bool checkLogin;
  int currentIndex = 0;
  int _currentIndex = 0;
  PageController _pageController;
  AnimationController _controller;
  AnimationController _controller2;
  Animation<double> _animation;
  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
          ..addListener(() {
            setState(() {});
          });
    _controller.forward();
    _controller2.forward();
    initial();
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      username = loginData.getString('username');
      tailorName = loginData.getString('tailorName');
      studioName = loginData.getString('studioName');
      tailorEmail = loginData.getString('userEmail');
      fileName = loginData.getString('fileName');
      checkLogin = loginData.getBool('login');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    _pageController.dispose();
    super.dispose();
  }

  //removes navigation path
  void _logout(){
    Navigator.popUntil(context, (ModalRoute.withName('/LoginScreen')));
  }

  //ask for App exit
  Future<bool> _onWillPop() {
    return AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: DialogType.QUESTION,
      title: 'Exit',
      desc: "آیا از برنامه میخواهید خارج شوید؟",
      btnCancelText: 'نخیر',
      btnOkText: 'بلی',
      btnOkColor: PurpleColor,
      btnOkOnPress: () => exit(0),
      btnCancelOnPress: () {
        Navigator.pop(context);
      },
      btnCancelColor: Colors.red.shade900).show() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        endDrawer: drawer(),
        extendBodyBehindAppBar: true,
        appBar: Env.appBarr(fileName??"", studioName??"",context),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children:[
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

  //My Drawer
  Widget drawer() {
    return Directionality( textDirection: TextDirection.rtl,
      child: Drawer(
      elevation: 20,
      child: SingleChildScrollView(
      child: Column(
      children: <Widget>[
              //Profile Header
                UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                ),
                accountName: InkWell(
                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));},
                child: Text(tailorName??'', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color:BlackColor.withOpacity(.7)),)),
                accountEmail: Text(tailorEmail??'',style: TextStyle(color: BlackColor.withOpacity(.6),fontWeight: FontWeight.w400)),
                currentAccountPicture: CircleAvatar(radius: 77,
                  backgroundImage: AssetImage('photos/background/no_user.jpg'),
                  //foregroundImage: NetworkImage(Env.urlPhoto + fileName??''),
                )),
              // Drawer List of Objects
              SizedBox(height: 10),
              Env.myTile('نمایشگاه', Icons.photo, Album(),context),
              Env.myTile('درباره ما', Icons.info, AboutTailor(),context),
              Divider(height: 290,indent: 20,endIndent: 20),
              //myTile('تماس با ما', Icons.call, NewClient()),
              //Logout
              ListTile(
                leading: Icon(
                  Icons.power_settings_new, size: 30, color: Colors.red.shade900),
                title: Text('خـــروج',style: Env.style(17,Colors.red.shade900)),
                onTap: () async {
                  await Env.confirmDialog('Sign out', Env.confirmMessage, DialogType.QUESTION, context, setState);
                  if(Env.checkYesNoLogin == true){
                    print("returns "+ Env.checkYesNoLogin.toString());
                    _logout();
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  }else{
                    print("returns "+Env.checkYesNoLogin.toString());
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}

//Custom Scaffold Background Color
class BackgroundColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xffffffff),
            Color(0xffffffff),
            Color(0xffffffff),
            Color(0xffffffff),
            Color(0xffffffff),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
    );
  }
}

