import 'package:flutter/material.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'Profile.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
         TextButton(
        child: Icon(Icons.settings,color: WhiteColor,size: 25,),
         ),
        ],
        elevation: 0,
        backgroundColor: PurpleColor,
        centerTitle: true,
        title: Text(
          'تنظیمات',style: TextStyle(color: WhiteColor,fontWeight: FontWeight.bold),
        ),
      ),

      body: SettinDetails(),
    );
  }
}


class SettinDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
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
          leading: Icon(Icons.vpn_key_rounded,color: PurpleColor),
          title: Text('Account'),
          subtitle: Text('Change number, Delete account'),
        ),
        ListTile(
          leading: Icon(Icons.notification_important,color: PurpleColor),
          title: Text('Notifications'),
          subtitle: Text('Delivery message'),
        ),
        ListTile(
          leading: Icon(Icons.help_outline,color: PurpleColor,),
          title: Text('Help'),
          subtitle: Text('Contact us, Help center'),
        ),



      ],
    );
  }
}


