import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Components/Button.dart';
import 'package:tailor/Components/RoundedBorderedField.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'dart:io';
import 'package:tailor/HttpServices/HttpServices.dart';

import '../../wait.dart';


class NewClient extends StatefulWidget {
  @override
  _NewClientState createState() => _NewClientState();
}

class _NewClientState extends State<NewClient> {
  final _formKey = GlobalKey <FormState>();
  SharedPreferences loginData;
  String user ="";
  File imageFile;
  final controller = CharacterApi();

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

  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Env.loader
        ? LoadingCircle()
        : Scaffold(
      backgroundColor: WhiteColor,
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
                   //Measurements
                  RoundedBorderedField(
                    hintText: 'اسم مشتری',
                    controller: controller.firstName,
                    inputType: TextInputType.name,
                    icon: Icons.person,
                    onChanged: (value){
                    },
                    message: 'لطفا اسم مشتری را وارید نمایید!',
                  ),
                  RoundedBorderedField(
                    hintText: 'تخلص',
                    controller: controller.lastName,
                    inputType: TextInputType.name,
                    icon: Icons.people_alt_rounded,
                    onChanged: (value){
                    },
                    message: 'لطفا تخلص مشتری را وارید نمایید!',
                  ),
                  RoundedBorderedField(
                    hintText: 'شماره تماس',
                    controller: controller.phone,
                    inputType: TextInputType.number,
                    icon: Icons.call,
                    onChanged: (value){
                    },
                    message: 'لطفا شماره تماس مشتری را وارید نمایید!',
                  ),
                     SizedBox(height: 10),
                  Text('اندازه مشـــــــتری',style: Env.style(20, PurpleColor)),
                  SizedBox(height: 10),

                  //Customer Measurements
                  Env.myMeasure('شــــانه', 'photos/Measure/shana.jpg',controller.shoulder),
                  Env.myMeasure('یخن', 'photos/Measure/gardan.jpg',controller.collar),
                  Env.myMeasure('آستین', 'photos/Measure/astin.jpg',controller.sleeve),
                  Env.myMeasure('بغل', 'photos/Measure/baghal.jpg',controller.waist),
                  Env.myMeasure('قـــــــد', 'photos/Measure/qad_peran.jpg',controller.height),
                  Env.myMeasure('دامـــــن', 'photos/Measure/bar_daman.jpg',controller.skirt),
                  Env.myMeasure('قد تنبان', 'photos/Measure/qad_tonban.jpg',controller.pantHeight),
                  Env.myMeasure('پــــاچه', 'photos/Measure/pacha.jpg',controller.legWidth),
                  SizedBox(height: 10),

                 //Action Buttons for Post and Cancel
                 Row(
                   children: [
                     Button(text: 'Cancel',paint: WhiteColor,textColor: PurpleColor,press: (){
                         Navigator.pop(context);
                     }),
                     Button(text: 'Save', paint: WhiteColor,textColor: PurpleColor,press: ()async{
                         if(_formKey.currentState.validate()){
                           setState(() {
                             Env.loader = true;
                           });
                           ///checking internet connectivity
                           Env.checkConnection(context,setState);

                           /// Function Send Data
                           controller.sendData(user,context);
                         }else{
                           Env.errorDialog('Empty', 'لطفا معلومات مشتری را وارد نمایید', DialogType.WARNING, context, () { });
                         }
                     }),
                   ],
                 ),
                  SizedBox(height: 10)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
