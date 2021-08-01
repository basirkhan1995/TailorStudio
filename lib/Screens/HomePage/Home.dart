import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';
import 'package:tailor/HttpServices/RegisterModel.dart';
import 'package:tailor/Screens/Individuals/ShowCustomer.dart';
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

class Dashboard extends StatefulWidget {
  final Register post;
  final Future<List<Customer>> customer;
  Dashboard({this.customer,this.post});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  SharedPreferences loginData;
  String tailorName  = "Tailor Name";
  String studioName  = "Tailor Studio";
  String tailorEmail = "Tailor Email";
  String username    = "username";
  String userID      = "userID";
  bool checkLogin;
  int currentIndex = 0;

  AnimationController _controller;
  AnimationController _controller2;
  Animation<double> _animation;
  Animation<double> _animation2;

  @override
  void initState() {
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
              HapticFeedback.lightImpact();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Settings(widget.post);
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
        BackgroundColor(),
        Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              SizedBox(height: _w / 5.5),
              Env.card('ثبت مشتری جدید ', 'شهرت و قد اندام مشتری',
                  Icons.person_add_alt_1, NewClient(), 0xff6666ff, context, _animation,_animation2),
              Env.card('لیست مشتریان', 'اندازه و فرمایش مشتری',
                  Icons.people_alt_rounded, Individual(), 0xff3366cc, context, _animation,_animation2),
              Env.card('لیست فرمایشات', 'فرمایش مشتریان', Icons.shopping_cart,
                  Orders(), 0xFF6F35A5, context, _animation,_animation2),
              Env.card('طرح دوخت هــا', 'نمایشگاه', Icons.photo_size_select_actual,
                  Album(), 0xFFac3973, context, _animation,_animation2),
              Env.card('تنظیمات', 'تنظیم حساب', Icons.settings, Settings(widget.post),
                  0xFF3385ff, context, _animation,_animation2),
            ],
          ),
        ),
      ],
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
                  color: Colors.white38
                 // image: DecorationImage(fit: BoxFit.cover,
                 // image: AssetImage('photos/background/drawer1.jpg')
                 //    )
                ),
                accountName: InkWell(
                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(widget.post)));},
                child: Text("$tailorName", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color:BlackColor.withOpacity(.7)),)),
                accountEmail: Text("$tailorEmail",style: TextStyle(color: BlackColor.withOpacity(.6),fontWeight: FontWeight.w500)),
                currentAccountPicture: CircleAvatar(radius: 77,
                  backgroundImage: AssetImage('photos/background/no_user.jpg'),
                  foregroundImage: NetworkImage(Env.urlPhoto + "mypic.jpg"),
                ),),

              // Drawer List of Objects
              SizedBox(height: 10),
              Env.myTile('ثبت مشتری جدید', Icons.person_add_alt_1_rounded, NewClient(),context),
              Env.myTile('فرمایش ها', Icons.shopping_cart, Orders(),context),
              Env.myTile('مشتریان', Icons.people_alt_rounded, Individual(),context),
              Env.myTile('نمایشگاه', Icons.photo, Album(),context),
              Env.myTile('تنظیمات', Icons.settings, Settings(widget.post),context),
              Divider(height: 10,indent: 20,endIndent: 20),
              Env. myTile('امتیاز دادن', Icons.star,AboutTailor(),context),
              Env.myTile('درباره ما', Icons.info, AboutTailor(),context),
              //myTile('تماس با ما', Icons.call, NewClient()),
              //Logout
              ListTile(
                leading: Icon(
                  Icons.transit_enterexit_rounded, size: 35, color: Colors.red.shade900),
                title: Text('خـــروج',style: Env.style(17,Colors.red.shade900)),
                onTap: () async {
                  ///TODO Confirm Dialog is not working
                  await Env.confirmDialog('WARNING', Env.confirmMessage, DialogType.WARNING, context, setState);
                  if(Env.checkYesNoLogin == true){
                    print("It returns in if "+ Env.checkYesNoLogin.toString());
                    _logout();
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  }else{
                    print("It returns in Else "+Env.checkYesNoLogin.toString());
                    Navigator.pop(context);
                  }

                    //HapticFeedback.lightImpact();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return LoginScreen();
                    //     },
                    //   ),
                    // );

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
