import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/HttpServices.dart';
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
  @override
  void initState() {
    initial();
    super.initState();
  }
  SharedPreferences loginData;
  String tailorName  = "Tailor Name";
  String studioName  = "Tailor Studio";
  String tailorEmail = "Tailor Email";
  String username    = "username";
  String userID      = "userID";
  final access = CharacterApi();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: Stack(
        children: [
          FutureBuilder(
            future: access.fetchUserOrders(userID),
            builder: (BuildContext context,
                AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return LoadingCircle();
              } else if(snapshot.hasData && snapshot.data.isEmpty){
                return Env.emptyBox();
              }else if (snapshot.hasError){
                return Text('Error');
              } else{
                List<MyOrders> posts = snapshot.data;
                return ListView(
                  padding: EdgeInsets.only(top:120),
                  children: posts.map((MyOrders post) =>
                      Env.card('#C' + post.customerId + 'ORD' + post.orderId, post.firstName + ' ' + post.lastName, post.orderState,
                          Icons.pending_actions_rounded, UserOrderDetails(post), (0xFFFFFFFF), context)).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

}