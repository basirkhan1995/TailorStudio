
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/Screens/Settings/Profile.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}
class _SettingsState extends State<Settings> {
  SharedPreferences loginData;
  String fileName="";
  String tailorName="";
  String email = "";
  bool checkLogin;

  @override
  void initState() {
    initial();
    super.initState();
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      tailorName = loginData.getString('tailorName');
      email = loginData.getString('userEmail');
      fileName = loginData.getString('fileName');
      checkLogin = loginData.getBool('login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Env.appBar(context, 'Setting'),
      body: ListView(
        children: [
          Card(
            color: LightColor,
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              leading: CircleAvatar(
                radius: 30,
                child: fileName == null ?
                CircleAvatar(radius: 60,
                  backgroundImage: AssetImage('photos/background/no_user.jpg'),
                ):CircleAvatar(
                  radius: 30,
                  foregroundImage: NetworkImage(Env.urlPhoto + fileName),
                  backgroundImage: AssetImage('photos/background/no_user.jpg'),
                ),
              ),
              title: Text(tailorName??"",style: Env.style(19, BlackColor.withOpacity(.8))),
              subtitle: Text(email??"",style: Env.style(13, BlackColor.withOpacity(.6))),
              // trailing: Icon(Icons.arrow_back_ios),
            ),
          ),
          Env.settingTile('Account', 'Change name, phone, email', Icons.account_circle, Profile(), context),
          Env.settingTile('Language', 'English, Persian', Icons.language, Profile(), context),
          Env.settingTile('Notifications', 'To send message for delivery', Icons.notifications_active, Profile(), context),
          Env.settingTile('Help', 'Contact us', Icons.help_rounded, Profile(), context),
        ],
      )
    );
  }
}
