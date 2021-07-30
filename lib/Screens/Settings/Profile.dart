import 'dart:convert';
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
  String userID ="";
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
      userID = loginData.getString('userID');
    });
  }

  void uploadProfile() async {
    http.Response res = await http.post(Uri.parse(Env.url+"uploadUserProfile.php"),body: jsonEncode({
      "fileName": imageFile.path,
      "userID": userID,
    }));
    String result = res.body.toString();
    print(result);
    if(imageFile.path == null){
      await Env.errorDialog(
          Env.successTitle,'لطفا عکس خود را انتخاب کنید',DialogType.ERROR, context, () { });
    }else if (result == "Success"){
      print(result);
      await Env.responseDialog(Env.successTitle,'عکس شما موفقانه آپلود گردید',DialogType.SUCCES, context, () { });
    }else if (result == "Failed"){
      await Env.errorDialog(
          Env.successTitle,'عکس شما آپلود نگردید لطفا دوباره کوشش کنید',DialogType.ERROR, context, () { });
    }
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: Env.myBar('تنظیمات پروفایل', Icons.check, ()=>uploadProfile(), context),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: PurpleColor,
                    child: imageFile != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: Image.file(
                        imageFile,
                        width: 155,
                        height: 155,
                        fit: BoxFit.cover,
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(80)),
                      width: 155,
                      height: 155,
                      child: Icon(
                        Icons.camera_alt,
                        color: PurpleColor,
                        size: 34,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Env.tile('اسم', tailorName??'', Icons.person_rounded, VoidCallback, context),
                Divider(endIndent: 20,indent: 20),
                Env.tile('خیاطی', studioName??'', Icons.home, VoidCallback, context),
                Divider(endIndent: 20,indent: 20),
                Env.tile('شماره تماس', phone??'', Icons.call, VoidCallback, context),
                Divider(endIndent: 20,indent: 20),
                Env.tile('ایمل آدرس', email??'ایمل ندارید', Icons.email_rounded, VoidCallback, context),
                Divider(endIndent: 20,indent: 20),
                Env.tile('آدرس', address??'', Icons.location_on, VoidCallback, context),
              ],
            )
          ],
        ),
      ),
    );
  }

  //Gallery Float Button
  gallery()async{
        PickedFile pickedFile = await ImagePicker().getImage(
          source: ImageSource.gallery,
          maxWidth: 400,
          maxHeight: 400,
        );
        if (pickedFile != null) {
          setState(() {
            imageFile = File(pickedFile.path);
          });
        }
  }
  camera()async{
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 400,
      maxHeight: 400,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
  //jjj

  void _showPicker(context) {
    showModalBottomSheet(
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.0),
              topLeft: Radius.circular(15.0),
          ),
        ),
    elevation: 10,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(

              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library,color: PurpleColor,size: 30),
                      title: new Text('Photo Library'),
                      onTap: () {
                        gallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera,color: PurpleColor,size: 30),
                    title: new Text('Camera'),
                    onTap: () {
                      camera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

}
