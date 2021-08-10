import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';
import 'CustomerFame.dart';
import 'CustomerMeasure.dart';
import 'CustomerOrder.dart';

class BaseDetails extends StatefulWidget {
   final Customer post;
   BaseDetails(this.post);

  @override
  _BaseDetailsState createState() => _BaseDetailsState();
}

class _BaseDetailsState extends State<BaseDetails> {
   File imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
        body: DefaultTabController(
            length: 3,
            child: Column(
              children: <Widget>[
                Material(
                    color: WhiteColor,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TabBar(
                          unselectedLabelColor: PurpleColor,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
                          indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: PurpleColor),
                          tabs: [
                            Tab(child: Env.tab('شهرت')),
                            Tab(child: Env.tab('اندازه')),
                            Tab(child: Env.tab('فرمایش')),
                          ]),
                    )),
                Expanded(
                  flex: 1,
                  child: TabBarView(
                    children: [
                      CustomerFame(widget.post),
                      CustomerMeasure(widget.post),
                      CustomerOrder(widget.post),
                    ],
                  ),
                )
              ],
            ))
    );
  }
}








