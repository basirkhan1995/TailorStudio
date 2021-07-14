import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Components/Rounded_Button.dart';
import 'package:tailor/Components/Rounded_Input_Field.dart';
import 'package:tailor/Components/Rounded_Number_Input.dart';
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
      appBar: Env.appBar(context),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5 , horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, top: 20),
                        child: imageFile != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.file(
                            imageFile,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(80)),
                          width: 150,
                          height: 150,
                          child: Icon(
                            Icons.person_sharp,
                            color: Colors.grey[700],
                            size: 80,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 180,top: 130),
                      child: CircleAvatar(
                          radius: 20,
                          backgroundColor: PurpleColor,
                          child: Center(
                            child: TextButton(
                                onPressed: () async {
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
                                child: Icon(
                                  Icons.camera_alt,color: WhiteColor,size: 20,)),
                          )),
                    )
                  ],
                ),

                Divider(height: 40,color: Colors.black26,indent: 10,endIndent: 10),
                 //Measurements
                RoundedInputField(
                  onChanged: (value) {},
                  message: "لطفا اسم مشتری را وارید نمایید",
                  hintText: 'اســــم مشــــتری',
                  controller: controllerFirstName,
                ),
                RoundedInputField(
                  onChanged: (value) {},
                  hintText: 'تخلص',
                  icon: Icons.people_alt,
                  message: "لطفا تخلص را وارید نمایید",
                  controller: controllerLastName,
                ),
                RoundedPhoneNo(
                  onChanged: (value) {},
                  hintText: 'شمـــــاره تماس',
                  message: "لطفا شماره تماس را وارید نمایید",
                  prefix: Icons.call_end_rounded,
                  controller: controllerPhone,
                ),
                ListTile(
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
                Divider(height: 10,indent: 10,endIndent: 10),
                ListTile(
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
                Divider(height: 10,indent: 10,endIndent: 10),
                ListTile(
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
                Divider(height: 10,indent: 10,endIndent: 10),
                ListTile(
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
                Divider(height: 10,indent: 10,endIndent: 10),
                ListTile(
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
                Divider(height: 10,indent: 10,endIndent: 10),
                ListTile(
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
                Divider(height: 10,indent: 10,endIndent: 10),

                ListTile(
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
                Divider(height: 10,indent: 10,endIndent: 10),
                ListTile(
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
