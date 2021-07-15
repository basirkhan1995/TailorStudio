import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tailor/Components/Rounded_Button.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'dart:io';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';


class MyGallery extends StatefulWidget {
  const MyGallery({Key key}) : super(key: key);

  @override
  _MyGalleryState createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  File imageFile;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: AnimatedFloatingActionButton(
        fabButtons: [
          gallery(),
          camera(),
        ],
        animatedIconData: AnimatedIcons.menu_close,
        colorStartAnimation: PurpleColor,
        colorEndAnimation: Colors.red.shade900,
      ),
      appBar: Env.appBar(context,'آپلود مدل لباس'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:70.0),
              child: Text('عکس خود را اینجا آپلود کنید',style: TextStyle(fontSize: 18,color: PurpleColor,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: Container(
                height: 300,
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
            Padding(
              padding: const EdgeInsets.only(left:8.0,top: 15),
              child: RoundedButton(
                color: PurpleColor,
                text: 'ثبت کردن',
                press: (){

                },
              ),
            )
          ],

        ),
      ),
    );
  }

  // Camera Float Button
  camera(){
    return FloatingActionButton(
      onPressed: () async {
        PickedFile pickedFile = await ImagePicker().getImage(
          source: ImageSource.camera,
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
      heroTag: 'Camera',
      tooltip: 'Camera',
      child: Icon(Icons.camera_alt),
    );
  }

  //Gallery Float Button
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

