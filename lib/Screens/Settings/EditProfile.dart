import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:tailor/Constants/ConstantColors.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        backgroundColor: PurpleColor,
        title: Text('تغـــــــییر پروفایل'),
      ),

      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('photos/pictures/me.jpg'),
                      radius: 80,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 205,top: 135,right: 100),
                  child: CircleAvatar(
                      radius: 22,
                      backgroundColor: PurpleColor,
                      child: Center(
                        child: TextButton(
                            onPressed: null,
                            child: Icon(
                              Icons.camera_alt,color: WhiteColor,size: 25,)),
                      )),
                ),
              ],
            ),
          ),

          //Form
          SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Form(
                child: Column(
                  children: [
                    Container(
                      width: size.width * 0.9,
                      child: TextFormField(
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          enabled: true,
                          hintText: '  ایمل آدرس',
                          prefix: Icon(Icons.email,size: 25,color: PurpleColor,),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                           color: PurpleColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(height: 8,),
                    Container(
                      width: size.width * 0.9,
                      child: TextFormField(
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          enabled: true,
                          hintText: '  اسم خیاطی',
                          prefix: Icon(Icons.shop,size: 25,color: PurpleColor,),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: PurpleColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(height: 8,),
                    Container(
                      width: size.width * 0.9,
                      child: TextFormField(
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          enabled: true,
                          hintText: '  شماره تماس',
                          prefix: Icon(Icons.phone,size: 25,color: PurpleColor,),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: PurpleColor,
                            ),
                          ),
                        ),
                      ),
                    ),
               Divider(height: 8,),
                    Container(
                      width: size.width * 0.9,
                      child: TextFormField(
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          enabled: true,
                          hintText: '    آدرس',
                          prefix: Icon(Icons.location_on,size: 25,color: PurpleColor,),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: PurpleColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(height: 15,),


                    //Button Save
                    Container(
                      width: size.width * 0.95,
                      height: 40,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(PurpleColor),
                        ),
                          onPressed: null,
                          child: Text('ثبت',
                            style: TextStyle(color: WhiteColor,fontSize: 20,fontWeight: FontWeight.bold,
                                ))),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
