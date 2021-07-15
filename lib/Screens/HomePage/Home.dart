import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tailor/Screens/Gallery/PhotoUpload.dart';
import 'package:tailor/Screens/Individuals/Individuals.dart';
import 'package:tailor/Screens/NewClient/New_Client_Form.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/Screens/Login/login.dart';
import 'package:tailor/Screens/Settings/Profile.dart';
import 'package:tailor/Screens/Settings/Settings.dart';
import '../About.dart';
import 'package:tailor/Screens/Gallery/Gallery.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  SharedPreferences loginData;
  String tailorName = "Tailor Name";
  String studioName = "Tailor Studio";
  String tailorEmail= "Tailor Email";
  String username ="username" ;
  bool checkLogin;

  AnimationController _controller;
  AnimationController _controller2;
  Animation<double> _animation;
  Animation<double> _animation2;

  @override
  void initState() {
    initial();
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
  }

  void initial() async{
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

  @override
  Widget build(BuildContext context) {
    // double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      endDrawer: drawer(),
      extendBodyBehindAppBar: true,
      appBar: appBar(),
      body: dashboard(),
    );
  }

  //My Appbar
  Widget appBar() {
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
          title:
          Text(
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
                    return RouteWhereYouGo();
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  //My Drawer
  Widget drawer(){
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Drawer(
        elevation: 20,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //Profile Header
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white60,
                ),

                //Profile Link
                accountName: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
                    },
                    child:Text("$username",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: GreyColor),)),
                accountEmail: Text("$tailorEmail",style: TextStyle(color: GreyColor),),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: Image.asset('photos/background/emptyAcc.png',color:Colors.grey[600]),
                  //backgroundImage: NetworkImage('photos/pictures/pro.jpg'),
                ),
                otherAccountsPictures: [
                  CircleAvatar(
                    child: TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
                        },
                        child: Icon(Icons.edit,color: WhiteColor)
                    ),
                    backgroundColor: PurpleColor,
                  ),
                ],
              ),

              // Drawer List of Objects
              ListTile(
                leading: Icon(Icons.people_alt_rounded,size: 35,color: PurpleColor,),
                title: Text('مشتری جدید',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: GreyColor)),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NewClient()));
                },
              ),

              ListTile(
                leading: Icon(Icons.photo_library,size: 35,color: PurpleColor,),
                title: Text('نمایشگاه',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: GreyColor)),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Album()));
                },
              ),

              ListTile(
                leading: Icon(Icons.settings,size: 35,color: PurpleColor,),
                title: Text('تنظیمات',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: GreyColor)),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings()));
                },
              ),

              Divider(indent: 10, endIndent: 10,thickness: 1,color: LightColor,),
              ListTile(
                leading: Icon(Icons.star,size: 35,color: PurpleColor,),
                title: Text('امتیاز دادن',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: GreyColor)),
                onTap: (){
                },
              ),
              ListTile(
                leading: Icon(Icons.share,size: 35,color: PurpleColor,),
                title: Text('اشتراک گذاری',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: GreyColor)),
                onTap: (){
                },
              ),
              ListTile(
                leading: Icon(Icons.info,size: 35,color: PurpleColor,),
                title: Text('درباره ما',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: GreyColor)),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutTailor()));
                },
              ),
              ListTile(
                leading: Icon(Icons.transit_enterexit_rounded,size: 35,color: Colors.red,),
                title: Text('خـــروج',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.red)),
                onTap:()async{
                  await Env.confirmDialog(
                      'WARNING', Env.confirmMessage
                      ,DialogType.WARNING,
                      context, () {
                    loginData.setBool('login', false);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  });
                },
              ),

            ],
          ),
        ),
      ),
    );

  }

  //Home Page Cards
  Widget dashboard(){
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
              card('ثبت مشــــتری جدید ', 'Customers', Icons.person_add_alt_1,
                  NewClient(),0xff66a3ff),
              card('فرمـــایشات مشــــتری', 'Orders', Icons.shopping_cart,
                  RouteWhereYouGo(),0xFF6F35A5),
              card('طرح دوخت هــا', 'نمایشگاه', Icons.photo_size_select_actual,
                   MyGallery(),0xFF8080ff),
              card('Custmers list', 'Example', Icons.favorite,
                  Individual(),0xff04549c),
              card('Setting', 'setting', Icons.settings,
                  Settings(),0xFF66b3ff),
            ],
          ),
        ),
      ],
    );
  }

  //Dashboard Widgets
  Widget card(String title, String subtitle, IconData icon, Widget route,paint) {
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
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 20.0,
                    ),
                  ],
                  color: Color(paint),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
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
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: _w / 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              wordSpacing: 1,
                            ),
                          ),
                          Text(
                            subtitle,
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white.withOpacity(1),
                              fontSize: _w / 25,
                              fontWeight: FontWeight.w600,
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


class RouteWhereYouGo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 50,
        centerTitle: true,
        shadowColor: Colors.black.withOpacity(.5),
        title: Text(
          'EXAMPLE ',
        ),
      ),
    );
  }
}

