import 'package:flutter/material.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/RegisterModel.dart';
import 'Profile.dart';

class Settings extends StatelessWidget {
  final Register data;
  Settings(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Env.appBar(context,'تنظیمات'),

      body: SettinDetails(data),
    );
  }
}


class SettinDetails extends StatelessWidget {
  final Register data;
  SettinDetails(this.data);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile(data)));
            },
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('photos/pictures/me.jpg'),
            ),
            title: Text('Mohammad Basir',style: TextStyle(fontSize: 20),),
            subtitle: Text('basirkhan.hashemi@gmail.com'),
          ),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.account_circle,color: GreyColor,size: 30),
          title: Text('Account'),
          subtitle: Text('Change number, Delete account'),
        ),
        ListTile(
          leading: Icon(Icons.notification_important,color: GreyColor,size: 30),
          title: Text('Notifications'),
          subtitle: Text('Delivery message'),
        ),
        ListTile(
          leading: Icon(Icons.help,color: GreyColor,size: 30,),
          title: Text('Help'),
          subtitle: Text('Contact us, Help center'),
        ),



      ],
    );
  }
}


