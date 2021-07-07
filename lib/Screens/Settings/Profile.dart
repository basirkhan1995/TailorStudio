import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Components/Rounded_Button.dart';
import 'package:tailor/Components/Rounded_Input_Field.dart';
import 'package:tailor/Constants/ConstantColors.dart';

import 'EditProfile.dart';


class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  SharedPreferences loginData;
  String username = "";
  String tailorName = "";


  void initial() async{
    loginData = await SharedPreferences.getInstance();
    setState(() {
      username = loginData.getString('username');
      tailorName = loginData.getString('tName');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: Icon(Icons.edit,color: WhiteColor,),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));
            },
          )
        ],
        elevation: 0,
        backgroundColor: PurpleColor,
        centerTitle: true,
        title: Text(
          'حســــاب',style: TextStyle(color: WhiteColor,fontWeight: FontWeight.bold),
        ),
      ),
      body: ProfileDetails(),
    );
  }
}


class ProfileDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
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
                      radius: 22,
                      backgroundColor: PurpleColor,
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
                leading: Icon(Icons.person_rounded,color: PurpleColor,size: 28),
                title: Text('اسم کاربری',style: TextStyle(color: GreyColor),),
                subtitle: Text("Basir",style: TextStyle(fontSize: 17,color: GreyColor,fontWeight: FontWeight.bold)),
              ),

              Divider(indent: 70,thickness: 1,endIndent: 20),

              ListTile(
                leading: Icon(Icons.email,color: PurpleColor,size: 25,),
                title: Text('ایمل آدرس',style: TextStyle(color: GreyColor),),
                subtitle: Text('basirkhan.hashemi@gmail.com',style: TextStyle(fontSize: 14,color: GreyColor,fontWeight: FontWeight.bold)),
              ),
              Divider( indent: 70,thickness: 1,endIndent: 20,),
              ListTile(
                leading: Icon(Icons.shop_rounded,color:PurpleColor,size: 25,),
                title: Text('خیاطی',style: TextStyle(color: GreyColor),),
                subtitle: Text('احمد الله خان',style: TextStyle(fontSize: 18,color: GreyColor,fontWeight: FontWeight.bold)),
              ),
              Divider( indent: 70,thickness: 1,endIndent: 20),
              ListTile(
                leading: Icon(Icons.call,color: PurpleColor,size: 28,),
                title: Text('شماره تماس',style: TextStyle(color: GreyColor),),
                subtitle: Text('0787130301',style: TextStyle(fontSize: 18,color: GreyColor,fontWeight: FontWeight.bold)),
              ),

              Divider( indent: 70,thickness: 1,endIndent: 20),
              ListTile(
                leading: Icon(Icons.location_on,color: PurpleColor,size: 28,),
                title: Text('آدرس',style: TextStyle(color: GreyColor),),
                subtitle: Text('چوک ذبیح الله',style: TextStyle(fontSize: 18,color: GreyColor,fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
