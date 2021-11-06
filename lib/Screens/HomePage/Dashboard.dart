import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  SharedPreferences loginData;
  String user = "";
  @override
  void initState() {
    super.initState();
    initial();
  }
  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      user = loginData.getString('userID');
    });
  }


  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: WhiteColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 5
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text('STATISTICS',style: Env.style(28, BlackColor.withOpacity(.5)),),
              ),
              Divider(endIndent: 30,indent: 30,height: 0),
              Env.dashboard('user.png', 'Customer', '2', context),
              Env.dashboard('clipboard.png', 'Order', '4', context),
              Env.dashboard('accept.png', 'Pending', '3', context),
              Env.dashboard('compliant.png', 'Complete', '1', context),
              Env.dashboard('bill2.png', 'Cash Paid', '500', context),
              Env.dashboard('invoice2.png', 'Account Receivable', '1500', context),
              SizedBox(height: 10)
            ],
          ),
        )
    );
  }
}




