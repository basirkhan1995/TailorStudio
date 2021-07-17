import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Components/RoundedBorderedField.dart';
import 'package:tailor/Components/Rounded_Button.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/Screens/HomePage/Home.dart';
import 'package:tailor/Components/Rounded_Measure_Input.dart';
import 'dart:io';


class NewClient extends StatefulWidget {
  @override
  _NewClientState createState() => _NewClientState();
}

class _NewClientState extends State<NewClient> {
  //variables
  final _formKey = GlobalKey <FormState>();
  SharedPreferences loginData;
  String user ="";
  File imageFile;

 //TextField Controllers
  TextEditingController controllerFirstName = new TextEditingController();
  TextEditingController controllerLastName = new TextEditingController();
  TextEditingController controllerPhone = new TextEditingController();
  TextEditingController controllerMeasure = new TextEditingController();
  TextEditingController controllerBaghal = new TextEditingController();
  TextEditingController controllerAstin = new TextEditingController();
  TextEditingController controllerShana = new TextEditingController();
  TextEditingController controllerDaman = new TextEditingController();
  TextEditingController controllerQad = new TextEditingController();
  TextEditingController controllerQadTunban = new TextEditingController();
  TextEditingController controllerPacha = new TextEditingController();
  TextEditingController controllerYakhan = new TextEditingController();

//  To Save userID in SharedPreferences
  void getInstance() async{
    loginData = await SharedPreferences.getInstance();
    setState(() {
      user = loginData.getString('userID');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
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
          "firstName": controllerFirstName.text,
          "lastName": controllerLastName.text,
          "phone": controllerPhone.text,
          "tailor": "$user",
          "qad": controllerQad.text,
          "shana":controllerShana.text,
          "astin":controllerAstin.text,
          "yakhan":controllerYakhan.text,
          "baghal":controllerBaghal.text,
          "daman":controllerDaman.text,
          "qadTunban":controllerQadTunban.text,
          "pacha":controllerPacha.text,
        }));
    String result = res.body.toString();
    print(result);
    if(result=="Failed"){
      Env.errorDialog(
          Env.errorTitle,Env.userExistsMessage,
          DialogType.ERROR, context, () { });
    }else {
      //print(result);
      await Env.responseDialog(
          Env.successTitle,Env.successCustomerAcc,
          DialogType.SUCCES, context, () { });
      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }

  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: Env.appBar(context,'ثبت مشتری جدید'),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5 , horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text( 'شهرت مشتری:',textAlign: TextAlign.right, textDirection: TextDirection.rtl,style: PersianFonts.Samim.copyWith(
                  fontSize: 20,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: PurpleColor,
                  fontWeight: FontWeight.w600,
                )),
                SizedBox(height: 10),
                 //Measurements
                RoundedBorderedField(
                  hintText: 'اسم مشتری',
                  controller: controllerFirstName,
                  inputType: TextInputType.name,
                  icon: Icons.person,
                  onChanged: (value){
                  },
                  message: 'لطفا اسم مشتری را وارید نمایید!',
                ),
                RoundedBorderedField(
                  hintText: 'تخلص',
                  controller: controllerLastName,
                  inputType: TextInputType.name,
                  icon: Icons.people_alt_rounded,
                  onChanged: (value){
                  },
                  message: 'لطفا تخلص مشتری را وارید نمایید!',
                ),
                RoundedBorderedField(
                  hintText: 'شماره تماس',
                  controller: controllerPhone,
                  inputType: TextInputType.number,
                  icon: Icons.call,
                  onChanged: (value){
                  },
                  message: 'لطفا شماره تماس مشتری را وارید نمایید!',
                ),
                   SizedBox(height: 10),
                Text('قد اندام مشتری',style: PersianFonts.Samim.copyWith(
                  fontSize: 20,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: PurpleColor,
                  fontWeight: FontWeight.w600,
                )),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: WhiteColor,
                          offset: Offset(2.0, 2.0), //(x,y)
                          blurRadius: 80.0,
                        )],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: PurpleColor)
                  ),

                  child: ListTile(
                      leading: CircleAvatar(
                          radius: 29,
                          backgroundImage: AssetImage('photos/Measure/qad_peran.jpg')),
                      title: Text('قـــــــد'),
                      trailing:  RoundedMeasureField(
                        controller: controllerQad,
                        hintText:'inch',
                        message: 'خــالی',
                      )
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: WhiteColor,
                          offset: Offset(2.0, 2.0), //(x,y)
                          blurRadius: 80.0,
                        )],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: PurpleColor)
                  ),
                  child: ListTile(
                      leading: CircleAvatar(
                          radius: 29,
                          backgroundImage: AssetImage('photos/Measure/shana.jpg')),
                      title: Text('شــــــانه'),
                      trailing:  RoundedMeasureField(
                        controller: controllerShana,
                        hintText:'inch',
                        message: 'خــالی',
                      )
                  ),
                ),
                Divider(height: 10,indent: 10,endIndent: 10),

                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: WhiteColor,
                          offset: Offset(2.0, 2.0), //(x,y)
                          blurRadius: 80.0,
                        )],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: PurpleColor)
                  ),
                  child: ListTile(
                      leading: CircleAvatar(
                          radius: 29,
                          backgroundImage: AssetImage('photos/Measure/astin.jpg')),
                      title: Text('آســتـــــــین'),
                      trailing:  RoundedMeasureField(
                        controller: controllerAstin,
                        hintText:'inch',
                        message: 'خــالی',
                      )
                  ),
                ),
                Divider(height: 10,indent: 10,endIndent: 10),

                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: WhiteColor,
                          offset: Offset(2.0, 2.0), //(x,y)
                          blurRadius: 80.0,
                        )],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: PurpleColor)
                  ),
                  child: ListTile(
                      leading: CircleAvatar(
                          radius: 29,
                          backgroundImage: AssetImage('photos/Measure/gardan.jpg')),
                      title: Text('یــــخن'),
                      trailing:  RoundedMeasureField(
                        controller: controllerYakhan,
                        hintText:'inch',
                        message: 'خــالی',
                      )
                  ),
                ),
                Divider(height: 10,indent: 10,endIndent: 10),

                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: WhiteColor,
                          offset: Offset(2.0, 2.0), //(x,y)
                          blurRadius: 80.0,
                        )],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: PurpleColor)
                  ),
                  child: ListTile(
                      leading: CircleAvatar(
                          radius: 29,
                          backgroundImage: AssetImage('photos/Measure/baghal.jpg')),
                      title: Text('بغـــــل'),
                      trailing:  RoundedMeasureField(
                        controller: controllerBaghal,
                        hintText:'inch',
                        message: 'خــالی',
                      )
                  ),
                ),
                Divider(height: 10,indent: 10,endIndent: 10),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: WhiteColor,
                          offset: Offset(2.0, 2.0), //(x,y)
                          blurRadius: 80.0,
                        )],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: PurpleColor)
                  ),
                  child: ListTile(
                      leading: CircleAvatar(
                          radius: 29,
                          backgroundImage: AssetImage('photos/Measure/bar_daman.jpg')),
                      title: Text('دامــــــن'),
                      trailing:  RoundedMeasureField(
                        controller: controllerDaman,
                        hintText:'inch',
                        message: 'خــالی',
                      )
                  ),
                ),
                Divider(height: 10,indent: 10,endIndent: 10),

                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: WhiteColor,
                          offset: Offset(2.0, 2.0), //(x,y)
                          blurRadius: 80.0,
                        )],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: PurpleColor)
                  ),
                  child: ListTile(
                      leading: CircleAvatar(
                          radius: 29,
                          backgroundImage: AssetImage('photos/Measure/qad_tonban.jpg')),
                      title: Text('قــــد تنبان'),
                      trailing:  RoundedMeasureField(
                        controller: controllerQadTunban,
                        hintText:'inch',
                        message: 'خــالی',
                      )
                  ),
                ),
                Divider(height: 10,indent: 10,endIndent: 10),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: WhiteColor,
                          offset: Offset(2.0, 2.0), //(x,y)
                          blurRadius: 80.0,
                        )],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: PurpleColor)
                  ),
                  child: ListTile(
                      leading: CircleAvatar(
                          radius: 29,
                          backgroundImage: AssetImage('photos/Measure/pacha.jpg')),
                      title: Text('پـــــاچه'),
                      trailing:  RoundedMeasureField(
                        controller: controllerPacha,
                        hintText:'inch',
                        message: 'خــالی',
                      )
                  ),
                ),
                Divider(height: 10,indent: 10,endIndent: 10),

                //btn
                RoundedButton(
                  textColor: WhiteColor,
                  color: PurpleColor,
                  press: (){
                    if(_formKey.currentState.validate()){
                      sendData();
                    }
                  },
                  text: "ثبت",
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }

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
