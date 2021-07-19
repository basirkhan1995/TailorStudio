import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tailor/Screens/Individuals/Individuals.dart';
import 'package:tailor/Screens/NewClient/New_Client_Form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/Screens/Login/login.dart';
import 'package:tailor/Screens/Orders/Orders.dart';
import 'package:tailor/Screens/Settings/Profile.dart';
import 'package:tailor/Screens/Settings/Settings.dart';
import '../About.dart';
import 'package:tailor/Screens/Gallery/Gallery.dart';
import 'package:persian_fonts/persian_fonts.dart';

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
  bool checkLogin;
  int currentIndex = 0;

  // StreamSubscription _connectionChangeStream;
  // bool isOffline = false;

  AnimationController _controller;
  AnimationController _controller2;
  Animation<double> _animation;
  Animation<double> _animation2;

  @override
  void initState() {
    //Check Connection Class Object
    // ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
    // _connectionChangeStream = connectionStatus.connectionChange.listen(connectionChanged);

    super.initState();
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

    _animation2 = Tween<double>(begin: 0, end: -50).animate(CurvedAnimation(
        parent: _controller2, curve: Curves.fastLinearToSlowEaseIn));

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
      checkLogin = loginData.getBool('login');
    });
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      // isOffline = !hasConnection;
    });
  }


  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
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
      btnCancelColor: Colors.red.shade900,
    ).show() ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        endDrawer: drawer(),
        extendBodyBehindAppBar: true,
        appBar: apBar(),
        body: dashboard(),
      ),
    );
  }

  //My Appbar
  Widget apBar() {
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
          title: Text(
            "$studioName",
            style: TextStyle(
              fontSize: _w / 17,
              color: Colors.black.withOpacity(.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: IconButton(
            tooltip: 'Settings',
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Icon(Icons.settings, color: Colors.black.withOpacity(.7)),
            onPressed: () {
              _logout();
              Env.loginData.setBool('login', false);
              HapticFeedback.lightImpact();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  //Home Page Cards
  Widget dashboard() {
    double _w = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        // background color
        BackgroundColor(),

        /// ListView
        Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              SizedBox(height: _w / 5.5),
              card('ثبت مشتری جدید ', 'شهرت و قد اندام مشتری',
                  Icons.person_add_alt_1, NewClient(), 0xff6666ff),
              card('لیست مشتریان', 'اندازه و فرمایش مشتری',
                  Icons.people_alt_rounded, Individual(), 0xff3366cc),
              card('لیست فرمایشات', 'فرمایش مشتریان', Icons.shopping_cart,
                  Orders(), 0xFF6F35A5),
              card('طرح دوخت هــا', 'نمایشگاه', Icons.photo_size_select_actual,
                  Album(), 0xFFac3973),
              card('تنظیمات', 'تنظیم حساب', Icons.settings, Settings(),
                  0xFF3385ff),
            ],
          ),
        ),
      ],
    );
  }

  //Dashboard Widgets
  Widget card(String title, String subtitle, IconData icon, Widget route, paint) {
    double _w = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: _animation.value,
      child: Transform.translate(
        offset: Offset(0, _animation2.value),
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
                              fontSize: _w / 22,
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
  Widget myTile(String title, IconData icon, Widget route){
    return ListTile(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => route));
      },
    title: Text(title, style:Env.style(16,BlackColor.withOpacity(.7))
    ),
    leading: Icon(icon,size: 30,color:PurpleColor),
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
                 image: DecorationImage(fit: BoxFit.cover,
                 image: AssetImage('photos/background/drawer3.jpg')
                    )
                ),
                accountName: InkWell(
                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));},
                child: Text("$tailorName", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color:BlackColor.withOpacity(.7)),)),
                accountEmail: Text("$tailorEmail",style: TextStyle(color: BlackColor.withOpacity(.6),fontWeight: FontWeight.w500)),
                currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.person_rounded, color: Colors.black.withOpacity(.5), size: 50),
                  //backgroundImage: NetworkImage('photos/pictures/pro.jpg'),
                )),

              // Drawer List of Objects
              myTile('ثبت مشتری', Icons.person_add_alt_1_rounded, NewClient()),
              myTile('نمایشگاه', Icons.photo, Album()),
              myTile('فرمایش ها', Icons.shopping_cart, Orders()),
              myTile('تنظیمات', Icons.settings, Settings()),
              Divider(height: 10,indent: 20,endIndent: 20),
              myTile('امتیاز دادن', Icons.star, AboutTailor()),
              myTile('درباره ما', Icons.info, AboutTailor()),
              //myTile('تماس با ما', Icons.call, NewClient()),

              //Logout
              ListTile(
                leading: Icon(
                  Icons.transit_enterexit_rounded, size: 35, color: Colors.red.shade900),
                title: Text('خـــروج',style: Env.style(17,Colors.red.shade900)),
                onTap: () async {
                  ///TODO Confirm Dialog is not working
                  //await Env.confirmDialog('WARNING', Env.confirmMessage, DialogType.WARNING, context, (){});
                    _logout();
                    Env.loginData.setBool('login', false);
                    HapticFeedback.lightImpact();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );

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
