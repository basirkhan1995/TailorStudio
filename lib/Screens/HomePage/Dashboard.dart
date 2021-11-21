import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/Statistics.dart';

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

  //GET DATA
  Future<List<Statistics>> statistics(String userID) async {
    var response = await get(Uri.parse(Env.url + "myStatistics.php?id=" + user)).timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      //print(response.body);
      List<dynamic> body = jsonDecode(response.body);
      List<Statistics> posts = body.map((dynamic item) => Statistics.fromJson(item)).toList();
      //print(posts);
      return posts;
    } else {
      throw "Error";
    }
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
                child: Text('Statistics',style: Env.style(28, BlackColor.withOpacity(.5)),),
              ),
              Divider(endIndent: 30,indent: 30,height: 0),
              Env.dashboard('user.png', 'Customers', "0", context),
              Env.dashboard('clipboard.png', 'Orders', '0', context),
              Env.dashboard('accept.png', 'Pending', '0', context),
              Env.dashboard('compliant.png', 'Complete', '0', context),
              Env.dashboard('bill2.png', 'Cash Paid', '0.00', context),
              Env.dashboard('invoice2.png', 'Account Receivable', '0.00', context),
              SizedBox(height: 10)
            ],
          )
        )
    );
  }
}




