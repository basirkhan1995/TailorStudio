import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/CustomerOrdersModel.dart';
import 'package:tailor/HttpServices/HttpServices.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';
import 'package:tailor/Screens/Individuals/CustomerOrderDetails.dart';
import 'package:tailor/Screens/Orders/CreateOrder.dart';
import 'dart:ui';
import '../../wait.dart';

class CustomerOrder extends StatefulWidget {
  final Customer post;
  CustomerOrder(this.post);
  @override
  _CustomerOrderState createState() => _CustomerOrderState();
}
class _CustomerOrderState extends State<CustomerOrder> with TickerProviderStateMixin{

  ScrollController _scrollController;
  bool showFab = true;
  final access = CharacterApi();
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      floatingActionButton: showFab ? FloatingActionButton(
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>NewOrder(widget.post)));
            if (_scrollController.hasClients) {
              final maxScroll = _scrollController.position.maxScrollExtent;
              final currentScroll = _scrollController.offset;
              return currentScroll >= (maxScroll * 0.9);
            }
          //_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        },
        backgroundColor: PurpleColor,
        child: Icon(Icons.add,color: WhiteColor),
      ):null,
      body: dashboard(),
    );
  }
  //Home Page Cards
  Widget dashboard(){
    //double _w = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        // background color
        /// ListView
        Directionality(
          textDirection: TextDirection.ltr,
          child: FutureBuilder(
            future: access.fetchCustomerOrders(widget.post.customerId),
            builder: (BuildContext context,
                AsyncSnapshot<List<Orders>> snapshot) {
              if (!snapshot.hasData) {
                return LoadingCircle();
              } else if(snapshot.hasData && snapshot.data.isEmpty) {
                return Env.emptyBox();
              }else if (snapshot.hasError){
                return Text('Error');
              } else{
                List<Orders> posts = snapshot.data;
                  return NotificationListener<UserScrollNotification>(
                    onNotification: (notification){
                      setState(() {
                        if(notification.direction == ScrollDirection.forward){
                          showFab = true;
                        }else if(notification.direction == ScrollDirection.reverse){
                          showFab = false;
                        }
                      });
                      return true;
                    },
                    child: ListView(
                      controller: _scrollController,
                      padding: EdgeInsets.only(top:20),
                      children: posts.map((Orders post) =>
                          Env.card('#C'+ post.customerId +'ORD'+ post.orderId, post.firstName + ' ' + post.lastName, post.orderState,
                              Icons.pending_actions_rounded, CustomerOrderDetails(post), (0xFFFFFFFF), context))
                          .toList(),
                    ),
                  );
              }
            },
          ),
        ),
      ],
    );
  }
}