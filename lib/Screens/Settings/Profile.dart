import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/Screens/Settings/EditProfile.dart';



class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  SharedPreferences loginData;
  String tailorName = "ندارد";
  String studioName = "ندارد";
  String email ="ندارد";
  String phone = "ندارد";
  String address = "ندارد";


  @override
  void initState() {
    initial();
    super.initState();
  }

  void initial() async{
    loginData = await SharedPreferences.getInstance();
    setState(() {
      studioName = loginData.getString('studioName');
      tailorName = loginData.getString('tailorName');
      email = loginData.getString('userEmail');
      phone = loginData.getString('userPhone');
      address = loginData.getString('userAddress');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Env.appBar(context,'تنظیمات پروفایل'),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('photos/pictures/me.jpg'),
                        radius: 80,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,top: 140,right: 110),
                    child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black.withOpacity(.5),
                        child: Center(
                          child: TextButton(
                              onPressed: null,
                              child: Icon(
                                Icons.camera_alt,color: WhiteColor,size: 25,)),
                        )),
                  ),

                ],
              ),
            ),
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.person_rounded,color: GreyColor,size: 28),
                  title: Text('اسم',style: TextStyle(color: GreyColor),),
                  subtitle: Text(tailorName,style: TextStyle(fontSize: 17,color: GreyColor,fontWeight:FontWeight.w500)),
                 trailing: TextButton(
                   onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));
                   },
                   child: Icon(Icons.edit),
                 ),
                ),
                Divider(indent: 70,endIndent: 20),
                ListTile(

                  leading: Icon(Icons.email,color: GreyColor,size: 25,),
                  title: Text('ایمل آدرس',style: TextStyle(color: GreyColor),),
                  subtitle: Text(email??'ایمل ندارید',style: TextStyle(fontSize: 14,color: GreyColor,fontWeight: FontWeight.w500)),
                ),
                Divider( indent: 70,endIndent: 20,),
                ListTile(
                  leading: Icon(Icons.shop_rounded,color:GreyColor,size: 25,),
                  title: Text('خیاطی',style: TextStyle(color: GreyColor)),
                  subtitle: Text('$studioName',style: TextStyle(fontSize: 17,color: GreyColor,fontWeight: FontWeight.w500)),
                ),
                Divider( indent: 70,endIndent: 20),
                ListTile(
                  leading: Icon(Icons.call,color: GreyColor,size: 28,),
                  title: Text('شماره تماس',style: TextStyle(color: GreyColor),),
                  subtitle: Text(phone??'شماره تماس ندارید',style: TextStyle(fontSize: 17,color: GreyColor,fontWeight: FontWeight.w500)),
                ),

                Divider( indent: 70,endIndent: 20),
                ListTile(
                  leading: Icon(Icons.location_on,color: GreyColor,size: 28,),
                  title: Text('آدرس',style: TextStyle(color: GreyColor),),

                  subtitle: Text(address??'آدرس خود را درج کنید',style: TextStyle(fontSize: 17,color: GreyColor,fontWeight: FontWeight.w500)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}