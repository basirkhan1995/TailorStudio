import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/CustomerOrdersModel.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';
import 'package:tailor/Screens/HomePage/Home.dart';
import 'package:tailor/Screens/Individuals/CustomerOrderDetails.dart';
import 'dart:ui';
import '../../wait.dart';


class CustomerOrder extends StatefulWidget {
  final Customer post;
  CustomerOrder(this.post);


  @override
  _CustomerOrderState createState() => _CustomerOrderState();
}

class _CustomerOrderState extends State<CustomerOrder> with TickerProviderStateMixin{

  AnimationController _controller;
  AnimationController _controller2;
  Animation<double> _animation;
  Animation<double> _animation2;

  @override
  void initState() {
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

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  Future<List<Orders>> fetchCustomerOrders() async {
    var response = await get(Uri.parse(Env.url + "customerOrders.php?id=${widget.post.customerID}"))
        .timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      //print(response.body);
      List<dynamic> body = jsonDecode(response.body);
      List<Orders> posts =
      body.map((dynamic item) => Orders.fromJson(item)).toList();
      //print(posts);
      return posts;
    } else {
      throw "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dashboard(),
    );
  }
  //Home Page Cards
  Widget dashboard(){
    //double _w = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        // background color
       BackgroundColor(),
        /// ListView
        Directionality(
          textDirection: TextDirection.rtl,
          child: FutureBuilder(
            future: fetchCustomerOrders(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Orders>> snapshot) {
              if (snapshot.hasData) {
                List<Orders> posts = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: ListView(
                    children: posts.map((Orders post) =>
                        Env.card('C'+ post.customerId +'ORD'+ post.orderId, post.firstName + ' ' + post.lastName, post.orderState, Icons.shopping_cart_rounded, CustomerOrderDetails(null), (0xFF6F35A5), context, _animation, _animation2))
                        .toList(),
                  ),
                );
              } else if(snapshot.data == null) {
                return LoadingCircle();
              }else if (snapshot.hasError){
                return Text('Error');
              } else{
                  return LoadingCircle();
              }
            },
          ),
        ),
      ],
    );
  }
}