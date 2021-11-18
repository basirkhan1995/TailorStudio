import 'package:flutter/material.dart';
import 'package:tailor/Constants/ClassMethods.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/OrderList.dart';
import 'package:tailor/Screens/Login/background.dart';

class UserOrderDetails extends StatefulWidget {
  final MyOrders data;
  UserOrderDetails(this.data);

  @override
  _UserOrderDetailsState createState() => _UserOrderDetailsState();
}

class _UserOrderDetailsState extends State<UserOrderDetails> {
  final TextEditingController newValue = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: PurpleLight.withOpacity(.6),
      //appBar: Env.appBar(context,widget.data.firstName + ' ' + widget.data.lastName ?? ''),
      body: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Env.customAppBar(widget.data.firstName + " " + widget.data.lastName,"ID : " + "C" + widget.data.customerId + "ORD" + widget.data.orderId, context),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Container(
                    child: ListView(
                      children: [
                        Column(
                          //mainAxisSize: MainAxisSize.min,
                          children: [
                            Env.orderTitle("Order Details", Icons.edit),
                            Divider(indent: 10,endIndent: 10),
                            Env.order("QTY", widget.data.quantity??""),
                            Env.order("Collar", widget.data.collarDesign??""),
                            Env.order("Design", widget.data.designType??""),
                            Env.order("Sleeve", widget.data.sleeveDesign??""),
                            Env.order("Type", widget.data.orderType??""),
                            Env.order("TextTile", widget.data.textTileMeter??""),
                            Env.order("Date", widget.data.deliveryDate??""),
                            Env.order("Status", widget.data.orderState??""),
                            Env.order("Remarks", widget.data.remarks??""),
                            Divider(indent: 30,endIndent: 30,),
                            Env.order("Price", widget.data.amount),
                            Env.order("Advance", widget.data.receivedAmount),
                            Divider(indent: 30,endIndent: 30),
                            Env.order("Total Balance", widget.data.total),
                          ],
                        ),

                      ],
                    ),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: GreyColor.withOpacity(.4),
                            offset: Offset(1,1), //(x,y)
                            blurRadius: 5.0,
                          ),
                        ],
                        color: WhiteColor, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    height: size.height * .77,
                    width: size.width * .9,
                  ),
                ),
              ),
            ],
          ),
        ],
      )

      // body: Directionality(
      //   textDirection: TextDirection.rtl,
      //   child: Container(
      //       child: ListView(
      //     children: [
      //       SizedBox(height: 10),
      //       Env.customTile(
      //           'شماره مسلسل:',
      //           'C' + widget.data.customerId + 'ORD' + widget.data.orderId ??
      //               '',
      //           'id.png',
      //           null,
      //           context),
      //       Env.customTile('نوعیت فرمایش:', widget.data.orderType ?? '',
      //           'receipt.png', null, context),
      //       Env.customTile('دیــــزاین فرمایش:', widget.data.designType ?? '',
      //           'design.png', null, context),
      //       Env.customTile(
      //           'تعداد فرمایش:',
      //           widget.data.quantity + ' جوره ' ?? '',
      //           'qty.png',
      //           null,
      //           context),
      //       Env.customTile('مقدار پول:', widget.data.amount ?? '',
      //           'price-tag.png', null, context),
      //       Env.customTile('رسید پول:', widget.data.receivedAmount ?? '',
      //           'price.png', null, context),
      //       Env.customTile('مجموعه بیلانس:', widget.data.total ?? '',
      //           'bill3.png', null, context),
      //       Env.customTile('حالت فرمایش:', widget.data.orderState ?? '',
      //           'checklist.png', null, context),
      //       Env.customTile('تاریخ تسلیمی:', widget.data.deliveryDate ?? '',
      //           'deliverDate.png', null, context),
      //       Env.customTile('ملاحظات:', widget.data.remarks ?? '', 'remarks.png',
      //           null, context),
      //       SizedBox(height: 10),
      //     ],
      //   )),
      // ),
    );
  }
}
