import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Components/RoundedBorderedField.dart';
import 'package:tailor/Components/Rounded_Button.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'dart:io';
import 'dart:convert';

import 'package:tailor/Screens/Individuals/ShowCustomer.dart';

class NewClient extends StatefulWidget {
  @override
  _NewClientState createState() => _NewClientState();
}

class _NewClientState extends State<NewClient> {
  final _formKey = GlobalKey <FormState>();
  SharedPreferences loginData;
  String user ="";
  File imageFile;

 //TextField Controllers
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController waist = new TextEditingController();
  TextEditingController sleeve = new TextEditingController();
  TextEditingController shoulder = new TextEditingController();
  TextEditingController skirt = new TextEditingController();
  TextEditingController height = new TextEditingController();
  TextEditingController pantHeight = new TextEditingController();
  TextEditingController legWidth = new TextEditingController();
  TextEditingController collar = new TextEditingController();

//  To Save userID in SharedPreferences
  void getInstance() async{
    loginData = await SharedPreferences.getInstance();
    setState(() {
      user = loginData.getString('userID');
    });
  }

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async{
    loginData = await SharedPreferences.getInstance();
    setState(() {
      user = loginData.getString('userID');
    });
  }

  void sendData() async {
     http.Response res = await http.post(Uri.parse(Env.url+"customerInsert.php"), body: jsonEncode({
          "firstName": firstName.text,
          "lastName": lastName.text,
          "phone": phone.text,
          "tailor": "$user",
          "height": height.text,
          "shoulder":shoulder.text,
          "sleeve":sleeve.text,
          "collar":collar.text,
          "waist":waist.text,
          "skirt":skirt.text,
          "pantHeight":pantHeight.text,
          "legWidth":legWidth.text,
        }));
    String result = res.body.toString();
    print(result);
    if(result == "Success"){
      await Env.responseDialog(
      Env.successTitle,Env.successCustomerAcc,DialogType.SUCCES, context, () { });
      Navigator.push(context, MaterialPageRoute(builder: (context) => Individual()));
    }else {
      print(result);
      await Env.errorDialog(
          Env.errorTitle,'مشتری شما ثبت نگردید لطفا دوباره کوشش نمایید!',DialogType.ERROR, context, () { });
    }
  }

  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: Env.appBar(context,'ثبت مشتری جدید'),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection:TextDirection.rtl,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5 , horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                     SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:[
                      Text('شـهرت مشـــــتری',textAlign: TextAlign.right, textDirection: TextDirection.rtl,
                          style: Env.style(20,PurpleColor)),
                    ],
                  ),
                  SizedBox(height: 10),
                   //Measurements
                  RoundedBorderedField(
                    hintText: 'اسم مشتری',
                    controller: firstName,
                    inputType: TextInputType.name,
                    icon: Icons.person,
                    onChanged: (value){
                    },
                    message: 'لطفا اسم مشتری را وارید نمایید!',
                  ),
                  RoundedBorderedField(
                    hintText: 'تخلص',
                    controller: lastName,
                    inputType: TextInputType.name,
                    icon: Icons.people_alt_rounded,
                    onChanged: (value){
                    },
                    message: 'لطفا تخلص مشتری را وارید نمایید!',
                  ),
                  RoundedBorderedField(
                    hintText: 'شماره تماس',
                    controller: phone,
                    inputType: TextInputType.number,
                    icon: Icons.call,
                    onChanged: (value){
                    },
                    message: 'لطفا شماره تماس مشتری را وارید نمایید!',
                  ),

                     SizedBox(height: 10),

                     Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('اندازه مشـــــــتری',style: Env.style(20, PurpleColor)),
                    ],
                  ),

                  SizedBox(height: 10),

                   //Measurements
                  Env.myMeasure('شــــانه', 'photos/Measure/shana.jpg',shoulder),
                  Env.myMeasure('یخن', 'photos/Measure/gardan.jpg',collar),
                  Env.myMeasure('آستین', 'photos/Measure/astin.jpg',sleeve),
                  Env.myMeasure('بغل', 'photos/Measure/baghal.jpg',waist),
                  Env.myMeasure('قـــــــد', 'photos/Measure/qad_peran.jpg',height),
                  Env.myMeasure('دامـــــن', 'photos/Measure/bar_daman.jpg',skirt),
                  Env.myMeasure('قد تنبان', 'photos/Measure/qad_tonban.jpg',pantHeight),
                  Env.myMeasure('پــــاچه', 'photos/Measure/pacha.jpg',legWidth),

                  SizedBox(height: 10),

                  /// Submit Button
                  RoundedButton(
                      textColor: WhiteColor, color: PurpleColor, text: "ثبت کــــــــــردن",
                    press: (){
                      if(_formKey.currentState.validate()){
                  /// Function Send Data
                     sendData();
                      }}),

                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  /// Function, Upload Customer Picture from Gallery
  gallery(){
    return FloatingActionButton(
      onPressed: ()async{
        PickedFile pickedFile = await ImagePicker().getImage(
          source: ImageSource.gallery,
          maxWidth: 1800,
          maxHeight: 1800,
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
