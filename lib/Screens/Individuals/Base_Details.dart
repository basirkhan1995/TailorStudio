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
                            Tab(
                              child: Container(

                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: PurpleColor, width: 1.5)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("شهرت",style: Env.txtStyle(15)),
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: PurpleColor, width: 1.5)
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("اندازه",style: Env.txtStyle(15)),
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: PurpleColor, width: 1.5)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("فرمایش",style: Env.txtStyle(15)),
                                ),
                              ),
                            ),
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








