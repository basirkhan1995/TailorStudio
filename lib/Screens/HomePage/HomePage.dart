import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/Screens/Gallery/Gallery.dart';
import 'package:tailor/Screens/Individuals/Individuals.dart';
import 'package:tailor/Screens/Login/login.dart';
import 'package:tailor/Screens/NewClient/New_Client_Form.dart';
import 'package:tailor/Screens/Orders/Orders.dart';
import 'package:tailor/Screens/Settings/Profile.dart';
import 'package:tailor/Screens/Settings/Settings.dart';
import '../About.dart';
import 'package:tailor/Screens/HomePage/Home.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences loginData;
  String username = "";
  String tailorName = "";

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async{
    loginData = await SharedPreferences.getInstance();
    setState(() {
      username = loginData.getString('username');
      tailorName = loginData.getString('tName');
    });
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(

      //Drawer
      endDrawer: Directionality(
        textDirection: TextDirection.rtl,
        child: Drawer(
          elevation: 20,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //Profile Header
                UserAccountsDrawerHeader(
                  arrowColor: PurpleColor,
                  decoration: BoxDecoration(
                    color: Colors.white60,
                  ),

                  //Profile Link
                  accountName: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
                      },
                      child:Text("$username",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: GreyColor),)),
                  accountEmail: Text('basirkhan.hashemi@gmail.com',style: TextStyle(color: GreyColor),),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: ExactAssetImage('photos/pictures/pro.jpg'),
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
                  leading: Icon(Icons.person_rounded,size: 35,color: PurpleColor,),
                  title: Text('مشتری جدید',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: GreyColor)),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NewClient()));
                  },
                ),

                ListTile(
                  leading: Icon(Icons.photo_library,size: 35,color: PurpleColor,),
                  title: Text('نمایشگاه لباس',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: GreyColor)),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyGallery()));
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
                        context, () { });
                    loginData.setBool('login', false);
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      //My AppBar
      appBar: AppBar(
        leading: TextButton(
            onPressed: (){
              showDialog <String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  content: Container(
                    height: 200,
                    child: Column(
                      children: [
                        Container(
                          child: ListTile(
                              title: Text('Account',
                                  style: TextStyle(color:GreyColor,fontSize: 18,fontWeight: FontWeight.bold)),
                              trailing: TextButton(
                                child: Text('خروج',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18)),
                                onPressed: (){
                                  loginData.setBool('login', false);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                                },
                              )),
                        ),
                        Divider(height: 1,color: GreyColor),
                        ListTile(
                          leading: Icon(Icons.person,size: 28,color: PurpleColor,),
                          title: Text(username,style: TextStyle(fontSize:18)),
                        ),

                        //Account Email
                        ListTile(
                          leading: Icon(Icons.account_circle_rounded,size: 28,color: PurpleColor,),
                          title: Text('basirkhan.hashemi@gmail.com',style: TextStyle(fontSize:12)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: Icon(Icons.account_circle,color: WhiteColor,size: 28,)),
        centerTitle: true,
        backgroundColor: PurpleColor,
        title: Text(tailorName,style: TextStyle(color: WhiteColor)),
      ),

      body: BottomNavBar(),
    );
  }
}


// Bottom Navigation Bar
class BottomNavBar extends StatefulWidget {
  BottomNavBar();
  _BottomNavBarState createState() => _BottomNavBarState();
}
class _BottomNavBarState extends State<BottomNavBar > {
  int _currentIndex = 0;
  final List <Widget> _children = [
    Dashboard(),
    Individual(),
    Orders(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],

      //Bottom Navigation Bar Design...
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: WhiteColor,
        itemCornerRadius: 13,
        containerHeight: 60,
        curve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 500),
        selectedIndex: _currentIndex,
        showElevation: true,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: Icon(Icons.home_rounded, size: 33),
            title: Text('خــــــانه',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
            activeColor: PurpleColor,
            inactiveColor: GreyColor,
          ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: Icon(Icons.people, size: 33),
            title: Text('مشــتریان',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
            activeColor: PurpleColor,
            inactiveColor: GreyColor,
          ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: Icon(Icons.shopping_cart, size: 30),
            title: Text('فـرمـایشات',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
            activeColor: PurpleColor,
            inactiveColor: GreyColor,
          ),

        ],
      ),
    );
  }
}
