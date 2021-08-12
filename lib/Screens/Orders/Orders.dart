import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/OrderList.dart';
import '../../wait.dart';
import 'OrderDetails.dart';


class Orders extends StatefulWidget {
  final MyOrders orderPost;
  Orders (this.orderPost);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with TickerProviderStateMixin{
  AnimationController _controller;
  AnimationController _controller2;
  Animation<double> _animation;
  Animation<double> _animation2;

  @override
  void initState() {
    initial();
    super.initState();
    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),

    );

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: 0, end: -50).animate(CurvedAnimation(
        parent: _controller2, curve: Curves.fastLinearToSlowEaseIn));

    _controller.forward();
    _controller2.forward();
  }

  SharedPreferences loginData;
  String tailorName  = "Tailor Name";
  String studioName  = "Tailor Studio";
  String tailorEmail = "Tailor Email";
  String username    = "username";
  String userID      = "userID";




  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      username = loginData.getString('username');
      tailorName = loginData.getString('tailorName');
      studioName = loginData.getString('studioName');
      tailorEmail = loginData.getString('userEmail');
      userID = loginData.getString('userID');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  Future<List<MyOrders>> fetchUserOrders() async {
    var response = await get(Uri.parse(Env.url + "userOrders.php?id=$userID"))
        .timeout(Duration(seconds: 10));
    if (response.statusCode == 200) {
      //print(res);
      List<dynamic> body = jsonDecode(response.body);
      List<MyOrders> posts =
      body.map((dynamic item) => MyOrders.fromJson(item)).toList();
      //print(posts);
      return posts;
    } else {
      throw "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      //appBar: Env.appBar(context, 'فرمایش مشتریان'),
      body: Stack(
        children: [
          //BackgroundColor(),
          FutureBuilder(
            future: fetchUserOrders(),
            builder: (BuildContext context,
                AsyncSnapshot<List<MyOrders>> snapshot) {
              if (!snapshot.hasData) {
                return LoadingCircle();
              } else if(snapshot.hasData && snapshot.data.isEmpty){
                return Env.emptyBox();
              }else if (snapshot.hasError){
                return Text('Error');
              } else{
                List<MyOrders> posts = snapshot.data;
                return ListView(
                  padding: EdgeInsets.only(top:160),
                  children: posts.map((MyOrders post) =>
                      Env.card('#C' + post.customerId + 'ORD' + post.orderId, post.firstName + ' ' + post.lastName, post.orderState,
                          Icons.pending_actions_rounded, UserOrderDetails(post), (0xFFFFFFFF), context, _animation, _animation2)).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

}