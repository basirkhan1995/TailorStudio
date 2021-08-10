import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Components/Button.dart';
import 'package:tailor/Components/RoundedBorderedField.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  // final Register post;
  // Profile(this.post);
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  TextEditingController newValue = new TextEditingController();
  SharedPreferences loginData;
  String tailorName = "ندارد";
  String studioName = "ندارد";
  String email ="ندارد";
  String phone = "ندارد";
  String address = "ندارد";
  String userID ="";
  String fileName ="";
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
      fileName = loginData.getString('fileName');
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
      backgroundColor: WhiteColor,
      appBar: Env.myBar('Profile Settings', Icons.check, ()=>uploadProfile(), context),
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
                    ) : CircleAvatar(radius: 77,
                      backgroundImage: AssetImage('photos/background/no_user.jpg'),
                      foregroundImage: NetworkImage(Env.urlPhoto + fileName),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  Env.tile('اسم', tailorName??'', Icons.person_rounded, ()=>_updateData(context,tailorName??"", 1), context),
                  Divider(height: 0,indent: 20,endIndent: 20),
                  Env.tile('خیاطی', studioName??'', Icons.home, ()=>_updateData(context,studioName??"", 2), context),
                  Divider(height: 0,indent: 20,endIndent: 20),
                  Env.tile('شماره تماس', phone??'', Icons.call, ()=>_updateData(context,phone??"", 3), context),
                  Divider(height: 0,indent: 20,endIndent: 20),
                  Env.tile('ایمل آدرس', email??'', Icons.email_rounded, ()=>_updateData(context,email??"", 4), context),
                  Divider(height: 0,indent: 20,endIndent: 20),
                  Env.tile('آدرس', address??'', Icons.location_on, ()=>_updateData(context,address??"", 5), context),
                ],
              ),
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

  _updateData(context, value, int fieldNo) {
    value == null ? newValue.text = "N/A" : newValue.text = value;
    var myData;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: WhiteColor,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal:18 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text('Do you want update ' + newValue.text + "?", style:Env.style(16, PurpleColor)),
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    RoundedBorderedField(
                        inputType: fieldNo == 3 ? TextInputType.number : TextInputType.text,
                        hintText: '',
                        controller: newValue,
                        icon: Icons.info_outline
                    ),
                    SizedBox(height: 10),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Button(text: 'Save',textColor: PurpleColor,paint: WhiteColor,
                            press: () async {
                              switch(fieldNo){
                                case 1:
                                  myData = {
                                    "tailorName": newValue.text,
                                    "studioName": studioName,
                                    "userPhone": phone,
                                    "userEmail": email,
                                    "userAddress": address,
                                    "userID": userID
                                  };
                                  break;
                                case 2:
                                  myData = {
                                    "tailorName": tailorName,
                                    "studioName": newValue.text,
                                    "userPhone": phone,
                                    "userEmail": email,
                                    "userAddress": address,
                                    "userID": userID

                                  };
                                  break;
                                case 3:
                                  myData = {
                                    "tailorName": tailorName,
                                    "studioName": studioName,
                                    "userPhone": newValue.text,
                                    "userEmail": email,
                                    "userAddress": address,
                                    "userID": userID
                                  };
                                  break;
                                case 4:
                                  myData = {
                                    "tailorName": tailorName,
                                    "studioName": studioName,
                                    "userPhone": phone,
                                    "userEmail": newValue.text,
                                    "userAddress": address,
                                    "userID": userID
                                  };
                                  break;
                                case 5:
                                  myData = {
                                    "tailorName": tailorName,
                                    "studioName": studioName,
                                    "userPhone": phone,
                                    "userEmail": email,
                                    "userAddress": newValue.text,
                                    "userID": userID
                                  };
                                  break;
                                default:
                                  myData = {
                                    "tailorName": tailorName,
                                    "studioName": studioName,
                                    "userPhone": phone,
                                    "userEmail": email,
                                    "userAddress": address,
                                    "userID": userID
                                  };
                              }
                              http.Response res = await http.post(Uri.parse(Env.url+"userUpdate.php"),body: jsonEncode(myData));
                              String result = res.body.toString();
                              if (result == "Success"){
                                print("Update " + result);
                                await Env.responseDialog(Env.successTitle,'موفقانه آپدیت شد',DialogType.SUCCES, context, () { });
                                Navigator.pop(context);
                              }else if (result == "Failed"){
                                await Env.errorDialog(
                                    Env.successTitle,'خطا در آپدیت',DialogType.ERROR, context, () { });
                              }
                            },
                          ),
                          Button(text: 'Cancel',textColor: PurpleColor,paint: WhiteColor,press: (){
                            Navigator.pop(context);
                          },),
                        ]),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ));
  }

}
