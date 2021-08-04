import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/Screens/Gallery/PhotoUpload.dart';
import 'package:tailor/Constants/ConstantColors.dart';

class Album extends StatefulWidget {

  @override
  _AlbumState createState() => _AlbumState();
}

class _AlbumState extends State<Album> {
  String user = "";
  SharedPreferences loginData;
  @override
  void initState() {
    initial();
    super.initState();
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      user = loginData.getString('userID');
    });
  }

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
      appBar: Env.appBar(context,'نمایشگاه لباس'),

      body: ListView.builder(
          itemCount: 6,
          itemBuilder: (BuildContext context,int index){
            return Column(
              children: [




              ],
            );
          }
      ),
     
    );
  }
}


