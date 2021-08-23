import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Components/Button.dart';
import 'package:tailor/Components/RoundedBorderedField.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/HttpServices.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';

class CustomerFame extends StatefulWidget {
  final Customer post;
  CustomerFame(this.post);
  @override
  _CustomerFameState createState() => _CustomerFameState();
}
class _CustomerFameState extends State<CustomerFame> {
  TextEditingController newValue = new TextEditingController();
  SharedPreferences loginData;
  String image;
  File imageFile;


 //Upload Image to server
  void _uploadFile(filePath) async {
    String fileName = basename(filePath.path);
    print("file name:$fileName");
    try {
      FormData formData = new FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath.path, filename: fileName),
      });
      Response response = await Dio().post(Env.url + "uploadGalleryPhoto.php",data: formData);
      print("File upload response: $response");
    } catch (e) {
      print("expectation Caugch: $e");
    }
  }

  //Upload
  void uploadProfile(customerID, context) async {
    http.Response res = await http.post(Uri.parse(Env.url+"uploadImage.php"),body: jsonEncode({
      "fileName": imageFile.path.split('/').last,
      "customerID": customerID,
    }));
    String result = res.body.toString();
    // print(widget.post.customerID);
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


  final access = CharacterApi();
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: CircleAvatar(
                        radius: 80, backgroundColor: PurpleColor,
                        child: imageFile != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(75),
                          child: Image.file(
                            imageFile, width: 155, height: 155, fit: BoxFit.cover,
                          ),
                        ): Env.image(widget.post.fileName??"no_user.jpg"),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(onTap: (){
                    _uploadFile(imageFile);
                    uploadProfile(widget.post.customerId, context);
                  }, child: Text('Submit',style: Env.style(20, PurpleColor),)),
                  SizedBox(height: 10),
                  Env.tile('اسم', widget.post.firstName??'اسم درج نشده',Icons.person, ()=>_updateData(context,widget.post.firstName, 1), context),
                  Divider(height: 2,indent: 10,endIndent: 10),
                  Env.tile('تخلص', widget.post.lastName??'تخلص درج نشده',Icons.people_rounded, ()=> _updateData(context,widget.post.lastName, 2), context),
                  Divider(height: 1,indent: 10,endIndent: 10),
                  Env.tile('شماره تماس', widget.post.phone??'شماره درج نشده',Icons.call, ()=> _updateData(context,widget.post.phone ,3), context),
                  Divider(height: 1,indent: 10,endIndent: 10),
                  Env.tile('ایمل', widget.post.email??'ایمل درج نشده',Icons.email_rounded, ()=> _updateData(context,widget.post.email, 4), context),
                ],
              )
          ),
        )
    );
  }

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
                                "email": widget.post.email,
                                "firstName": newValue.text,
                                "lastName": widget.post.lastName,
                                "phone": widget.post.phone,
                                "customerID": widget.post.customerId
                              };
                              break;
                            case 2:
                              myData = {
                                "email": widget.post.email,
                                "firstName": widget.post.firstName,
                                "lastName": newValue.text,
                                "phone": widget.post.phone,
                                "customerID": widget.post.customerId
                              };
                              break;
                            case 3:
                              myData = {
                                "email": widget.post.email,
                                "firstName": widget.post.firstName,
                                "lastName": widget.post.lastName,
                                "phone": newValue.text,
                                "customerID": widget.post.customerId
                              };
                              break;
                            case 4:
                              myData = {
                                "email": newValue.text,
                                "firstName": widget.post.firstName,
                                "lastName": widget.post.lastName,
                                "phone": widget.post.phone,
                                "customerID": widget.post.customerId
                              };
                              break;
                            default:
                              myData = {
                                "email": widget.post.email,
                                "firstName": widget.post.firstName,
                                "lastName": widget.post.lastName,
                                "phone": widget.post.phone,
                                "customerID": widget.post.customerId
                              };
                          }
                          http.Response res = await http.post(Uri.parse(Env.url+"customerUpdate.php"),body: jsonEncode(myData));
                          String result = res.body.toString();
                          if (result == "Success"){
                            print("Update Success"+result);
                            await Env.responseDialog(Env.successTitle,'موفقانه آپدیت شد!',DialogType.SUCCES, context, () { });
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