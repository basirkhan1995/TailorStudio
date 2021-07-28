import 'dart:convert';

import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

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
  File imageFile;

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

  void uploadProfile() async {
    http.Response res = await http.post(Uri.parse(Env.url+"customerInsert.php"), body: jsonEncode({
      "fileName": imageFile.path,
    }));
    String result = res.body.toString();
    print(result);
    if(result == "Success"){
      await Env.responseDialog(
          Env.successTitle,Env.successCustomerAcc,DialogType.SUCCES, context, () { });
    }else {
      print(result);
      await Env.errorDialog(
          Env.errorTitle,'مشتری شما ثبت نگردید لطفا دوباره کوشش نمایید!',DialogType.ERROR, context, () { });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: AnimatedFloatingActionButton(
        fabButtons: [
          gallery(),
        ],
        animatedIconData: AnimatedIcons.menu_close,
        colorStartAnimation: PurpleColor,
        colorEndAnimation: Colors.red.shade900,
      ),
      appBar: Env.appBar(context,'تنظیمات پروفایل'),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: Container(
                height: 200,
                width: size.width *0.95,
                child: imageFile != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    imageFile,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fitHeight,
                  ),
                )
                    : Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  width: size.width * 0.9,
                  height: 100,
                  child: Icon(
                    Icons.photo,
                    color: PurpleColor,
                    size: 150,
                  ),
                ),
              ),
            ),

            Column(
              children: [
                InkWell(
                  child: Text('Edit Profile',style: Env.style(20, PurpleColor)),
                ),
                ListTile(
                  leading: Icon(Icons.person_rounded,color: PurpleColor,size: 28),
                  title: Text('اسم',style: TextStyle(color: GreyColor),),
                  subtitle: Text(tailorName,style: TextStyle(fontSize: 17,color: GreyColor,fontWeight:FontWeight.w500)),
                ),
                Divider(indent: 70,endIndent: 20),
                ListTile(

                  leading: Icon(Icons.email,color: PurpleColor,size: 25,),
                  title: Text('ایمل آدرس',style: TextStyle(color: GreyColor),),
                  subtitle: Text(email??'ایمل ندارید',style: TextStyle(fontSize: 14,color: GreyColor,fontWeight: FontWeight.w500)),
                ),
                Divider( indent: 70,endIndent: 20,),
                ListTile(
                  leading: Icon(Icons.shop_rounded,color:PurpleColor,size: 25,),
                  title: Text('خیاطی',style: TextStyle(color: GreyColor)),
                  subtitle: Text('$studioName',style: TextStyle(fontSize: 17,color: GreyColor,fontWeight: FontWeight.w500)),
                ),
                Divider( indent: 70,endIndent: 20),
                ListTile(
                  leading: Icon(Icons.call,color: PurpleColor,size: 28,),
                  title: Text('شماره تماس',style: TextStyle(color: GreyColor),),
                  subtitle: Text(phone??'شماره تماس ندارید',style: TextStyle(fontSize: 17,color: GreyColor,fontWeight: FontWeight.w500)),
                ),

                Divider( indent: 70,endIndent: 20),
                ListTile(
                  leading: Icon(Icons.location_on,color: PurpleColor,size: 28,),
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

  //Gallery Float Button
  gallery(){
    return FloatingActionButton(
      onPressed: ()async{
        PickedFile pickedFile = await ImagePicker().getImage(
          source: ImageSource.gallery,
          maxWidth: 200,
          maxHeight: 200,
        );
        if (pickedFile != null) {
          setState(() {
            imageFile = File(pickedFile.path);
          });
        }
      },
      backgroundColor: PurpleColor,
      heroTag: 'gallery',
      tooltip: 'Gallery',
      child: Icon(Icons.photo_library),
    );
  }

}