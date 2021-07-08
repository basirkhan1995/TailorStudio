import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:tailor/Components/Rounded_Button.dart';
import 'package:tailor/Components/Rounded_Input_Field.dart';
import 'package:tailor/Components/Rounded_Measure_Input.dart';
import 'package:tailor/Components/Rounded_Number_Input.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';
import 'package:tailor/Screens/HomePage/HomePage.dart';
import 'dart:io';

class NewClient extends StatefulWidget {
  @override
  _NewClientState createState() => _NewClientState();
}

class _NewClientState extends State<NewClient> {
  final _formkey = GlobalKey <FormState>();
  File imageFile;

  TextEditingController controllerFirstName = new TextEditingController();
  TextEditingController controllerLastName = new TextEditingController();
  TextEditingController controllerPhone = new TextEditingController();
  TextEditingController controllerEmail = new TextEditingController();
  String message = '';

  bool error, sending, success;
  String phpurl = "https://tailorstudio.000webhostapp.com/addCustomer.php";


  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    super.initState();
  }

  Future<List<Individuals>> sendData() async {
    var res = await http.post(Uri.parse(phpurl), body: {
      "indFirstName": controllerFirstName.text,
      "indLastName": controllerLastName.text,
      "indPhone": controllerPhone.text,
      "indEmail": controllerEmail.text,
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if(data["error"]){
        setState(() { //refresh the UI when error is recieved from server
          sending = false;
          error = true;
        });
      }else{
        controllerFirstName.text = "";
        controllerLastName.text = "";
        controllerPhone.text = "";
        controllerEmail.text = "";
        //after write success, make fields empty

        setState(() {
          sending = false;
          success = true; //mark success and refresh UI with setState
        });
      }
    }else{
      //there is error
      setState(() {
        error = true;
        sending = false;
        //mark error and refresh UI with setState
      });
    }
  }
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: PurpleColor,
        title: Text(
          'مشـــــتری جــــدید',
          style: TextStyle(color: WhiteColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
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
                            Icons.person,
                            color: Colors.grey[800],
                            size: 70,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 190,top: 130),
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
                RoundedInputField(
                  onChanged: (value) {},
                  message: "لطفا اسم مشتری را وارید نمایید",
                  hintText: 'اســـــــم',
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

                Divider(height: 40,color: Colors.black26,indent: 10,endIndent: 10),

                //Measurements
                ListTile(
                    leading: CircleAvatar(
                        radius: 29,
                        backgroundImage: AssetImage('photos/Measure/baghal.jpg')),
                    title: Text('بغـــــل'),
                    trailing:  RoundedMeasureField(
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
                      hintText:'inch',
                      message: 'خــالی',
                    )
                ),
                Divider(height: 10,indent: 10,endIndent: 10),
                ListTile(
                    leading: CircleAvatar(
                        radius: 29,
                        backgroundImage: AssetImage('photos/Measure/qad_peran.jpg')),
                    title: Text('قـــــــد'),
                    trailing:  RoundedMeasureField(
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
                      hintText:'inch',
                      message: 'خــالی',
                    )
                ),
                Divider(height: 10,indent: 10,endIndent: 10),
                RoundedButton(
                  textColor: WhiteColor,
                  color: PurpleColor,
                  press: (){
                    setState(() {
                      sending = true;
                      sendData();
                      if(_formkey.currentState.validate()){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                      }
                    });
                  },
                  text: sending?"در حال ثبت ":"ثبت",
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
