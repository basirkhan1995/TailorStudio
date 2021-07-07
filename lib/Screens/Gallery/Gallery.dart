import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
    return Scaffold(

        //floatingActionButton: floatButton(context),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.photo_library,color: WhiteColor,size: 30)),
        ],
        backgroundColor: PurpleColor,
        centerTitle: true,
        title: Text(
          'نمایشگاه لباس',style: Env.titleStyle(),
        ),
      ),
      body: Column(
        children: [
      Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: new BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.5)
          ),
        ),
      )


         ],
      ),
    );
  }

  //Gallery Get Function
  galleryPhoto() async {
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
  }


  //Camera Get function
  cameraPhoto() async {
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
  }

// Animated Float Action Button
    Widget floatButton(context){
    return AnimatedFloatingActionButton(
      fabButtons: [
        gallery(),
        camera(),
      ],
      animatedIconData: AnimatedIcons.menu_close,
      colorStartAnimation: PurpleColor,
      colorEndAnimation: Colors.red.shade900,
    );
  }

  // Camera Float Button
   Widget camera(){
    return Container(
      child: FloatingActionButton(
        onPressed: (){
        cameraPhoto();
        },
        tooltip: 'Camera',
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  //Gallery Float Button
  Widget gallery(){
    return Container(
      child: FloatingActionButton(
        onPressed: (){
          galleryPhoto();
        },
        tooltip: 'Gallery',
        child: Icon(Icons.photo_library),
      ),
    );
  }

}
