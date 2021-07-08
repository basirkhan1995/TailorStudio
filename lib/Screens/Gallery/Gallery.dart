import 'package:flutter/material.dart';
import 'package:tailor/Screens/Gallery/PhotoUpload.dart';
import 'package:tailor/Constants/ConstantColors.dart';

class Album extends StatelessWidget {
  const Album({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: PurpleColor,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyGallery()));
        },
      ),
      appBar: AppBar(
        backgroundColor: PurpleColor,
        title: Text('آلبوم لـــباس ها'),
      ),
    );
  }
}
