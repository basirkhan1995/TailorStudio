import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';

class BaseDetails extends StatelessWidget {
   final Customer post;
   BaseDetails(this.post);
   File imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
        body: DefaultTabController(
            length: 3,
            child: Column(
              children: <Widget>[
                Material(
                    color: WhiteColor,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TabBar(
                          unselectedLabelColor: PurpleColor,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: PurpleColor),
                          tabs: [
                            Tab(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: PurpleColor, width: 1)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("شهرت",style: Env.txtStyle(15)),
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: PurpleColor, width: 1)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("اندازه",style: Env.txtStyle(15)),
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: PurpleColor, width: 1)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("فرمایش",style: Env.txtStyle(15)),
                                ),
                              ),
                            ),
                          ]),
                    )),
                Expanded(
                  flex: 1,
                  child: TabBarView(
                    children: [
                     CustomerFame(post),
                      CustomerMeasure(),
                      CustomerOrder(),
                    ],
                  ),
                )
              ],
            ))
    );
  }
}

class CustomerFame extends StatefulWidget {
  final Customer post;
  CustomerFame(this.post);
  @override
  _CustomerFameState createState() => _CustomerFameState();
}
class _CustomerFameState extends State<CustomerFame> {
  File imageFile;


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
                  padding: const EdgeInsets.only(top: 30),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: PurpleColor,
                    child: imageFile != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: Image.file(
                        imageFile,
                        width: 155,
                        height: 155,
                        fit: BoxFit.cover,
                      ),
                    )
                        :Container(
                        width: 155,
                        height: 155,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(Env.urlPhoto + '${widget.post.fileName}'),
                          fit: BoxFit.cover
                        ),
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(80)),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Env.tile('اسم', widget.post.firstName??'اسم درج نشده',Icons.person, VoidCallback, context),
              Divider(height: 2,indent: 10,endIndent: 10),
              Env.tile('تخلص', widget.post.lastName??'تخلص درج نشده',Icons.people_rounded, VoidCallback, context),
              Divider(height: 1,indent: 10,endIndent: 10),
              Env.tile('شماره تماس', widget.post.phone??'شماره درج نشده',Icons.call, VoidCallback, context),
              Divider(height: 1,indent: 10,endIndent: 10),
              Env.tile('ایمل', widget.post.email??'ایمل درج نشده',Icons.email_rounded, VoidCallback, context),
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
}

class CustomerMeasure extends StatelessWidget {
  const CustomerMeasure({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Center(child: Text('اندازه مشتری',style:Env.style(40, PurpleColor)))
    );
  }
}

class CustomerOrder extends StatelessWidget {
  const CustomerOrder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child:Center(child: Text('فرمایش مشتری',style:Env.style(40, PurpleColor))));
  }
}



