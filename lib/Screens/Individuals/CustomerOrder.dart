import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';
import 'package:tailor/Screens/HomePage/Home.dart';
import 'dart:ui';
import 'package:tailor/Screens/Orders/OrderDetails.dart';

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dashboard(),
    );
  }
  //Home Page Cards
  Widget dashboard(){
    double _w = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        // background color
       BackgroundColor(),
        /// ListView
        Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            physics:
            BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              SizedBox(height: _w / 5.5),
              card('#50002', 'پیراهن تنبان کرزیی', Icons.insert_chart_rounded, OrderDetails(),'Pending'),
              card('#50005', 'واسکت پاکستانی', Icons.insert_chart_rounded, OrderDetails(),'Pending'),
              card('#50009', 'پیراهن تنبان قاسمی', Icons.insert_chart_rounded, OrderDetails(),'Pending'),
              card('#50005', 'پیراهن تنبان قاسمی', Icons.insert_chart_rounded, OrderDetails(),'Pending'),
              card('#50009', 'پیراهن تنبان قاسمی', Icons.insert_chart_rounded, OrderDetails(),'Completed'),
            ],
          ),
        ),
      ],
    );
  }

  Widget card(String title, String subtitle, IconData icon, Widget route,orderState) {
    double _w = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: _animation.value,
      child: Transform.translate(
        offset: Offset(0, _animation2.value),
        child: Container(
          height: _w / 2.3,
          width: _w,
          padding: EdgeInsets.fromLTRB(_w / 20, 0, _w / 20, _w / 20),
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => route));
            },
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: WhiteColor.withOpacity(.5),
                      offset: Offset(2.0, 2.0), //(x,y)
                      blurRadius: 40.0,
                    ),
                  ],
                  color: PurpleColor,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  border: Border.all(color: Colors.white.withOpacity(.1), width: 1)),
              child: Padding(
                padding: EdgeInsets.all(_w / 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: _w / 3,
                      width: _w / 3,
                      decoration: BoxDecoration(
                          color: WhiteColor.withOpacity(.2),
                          borderRadius: BorderRadius.circular(30)),
                      child: Icon(
                        icon,
                        color: WhiteColor,
                        size: _w / 4,
                      ),
                    ),
                    SizedBox(width: _w / 40),
                    SizedBox(
                      width: _w / 2.05,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: PersianFonts.Samim.copyWith(
                              fontSize: _w /18,
                              letterSpacing: 1,
                              wordSpacing: 1,
                              color: WhiteColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            subtitle,
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: PersianFonts.Samim.copyWith(
                              fontSize: _w /30,
                              letterSpacing: 1,
                              wordSpacing: 1,
                              color: WhiteColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            orderState,
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: _w / 30,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}