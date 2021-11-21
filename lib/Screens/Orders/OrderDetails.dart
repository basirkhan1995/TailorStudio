import 'dart:convert';
import 'package:tailor/Components/RoundedBorderedField.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tailor/Components/Button.dart';
import 'package:tailor/Constants/ShowOrderDetails.dart';
import 'package:tailor/HttpServices/OrderList.dart';

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

  _updateData(context, value) {
    value == null ? newValue.text = "N/A" : newValue.text = value;
    var myData;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: WhiteColor,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text('Do you want update ' + newValue.text + "?",
                    style: Env.style(16, PurpleColor)),
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    RoundedBorderedField(
                        hintText: '',
                        controller: newValue,
                        icon: Icons.info_outline),
                    RoundedBorderedField(
                        hintText: '',
                        controller: newValue,
                        icon: Icons.info_outline),
                    RoundedBorderedField(
                        hintText: '',
                        controller: newValue,
                        icon: Icons.info_outline),
                    SizedBox(height: 10),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Button(
                            text: 'Save',
                            textColor: PurpleColor,
                            paint: WhiteColor,
                            press: () async {
                              switch (null) {
                                case 1:
                                  myData = {
                                    "orderID": newValue.text,
                                    "orderType": newValue.text,
                                    "quantity": newValue.text,
                                    "remarks": newValue.text,
                                    "orderState": newValue.text,
                                    "designType": newValue.text,
                                    "sleeve_design": newValue.text,
                                    "collar_design": newValue.text,
                                    "textTile_Meter": newValue.text,
                                    "deliveryDate": newValue.text,
                                    "amount": newValue.text,
                                    "receivedAmount": newValue.text,
                                  };
                                  break;
                                default:
                                  myData = {
                                    "orderID": widget.data.orderId,
                                    "orderType": widget.data.orderType,
                                    "quantity": widget.data.quantity,
                                    "remarks": widget.data.remarks,
                                    "orderState": widget.data.orderState,
                                    "designType": widget.data.designType,
                                    "sleeve_design": widget.data.sleeveDesign,
                                    "collar_design": widget.data.collarDesign,
                                    "textTile_Meter": widget.data.textTileMeter,
                                    "deliveryDate": widget.data.deliveryDate,
                                    "amount": widget.data.amount,
                                    "receivedAmount": widget.data.receivedAmount,
                                  };
                              }
                              http.Response res = await http.post(
                              Uri.parse(Env.url + "orderUpdate.php"), body: jsonEncode(myData));
                              String result = res.body.toString();
                              if (result == "Success") {
                                print("Update Success" + result);
                                await Env.responseDialog(Env.successTitle, 'موفقانه آپدیت شد!', DialogType.SUCCES, context,() {});
                                Navigator.pop(context);
                              } else if (result == "Failed") {
                                await Env.errorDialog(
                                    Env.successTitle,
                                    'خطا در آپدیت',
                                    DialogType.ERROR,
                                    context,
                                        () {});
                              }
                            },
                          ),
                          Button(
                            text: 'Cancel',
                            textColor: PurpleColor,
                            paint: WhiteColor,
                            press: () {
                              Navigator.pop(context);
                            },
                          ),
                        ]),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: PurpleLight.withOpacity(.6),
      //appBar: Env.appBar(context,widget.data.firstName + ' ' + widget.data.lastName ?? ''),
     body: OrderDetails(
       title: widget.data.firstName + " " + widget.data.lastName,
       subtitle: "C"+widget.data.customerId +"ORD" + widget.data.orderId,
       //Order Details
       qty: widget.data.quantity,
       design: widget.data.designType,
       collar: widget.data.collarDesign,
       sleeve: widget.data.sleeveDesign,
       type: widget.data.designType,
       status: widget.data.orderState,
       textTile: widget.data.textTileMeter,
       date: widget.data.deliveryDate,
       price: widget.data.amount,
       advance: widget.data.receivedAmount,
       totalBalance: widget.data.total,
       press: ()=>_updateData(context, widget.data.sleeveDesign),

     ),

      // body: ListView(
      //   physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      //   children: [
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Env.customAppBar(widget.data.firstName + " " + widget.data.lastName,"ID : " + "C" + widget.data.customerId + "ORD" + widget.data.orderId, context),
      //         Center(
      //           child: Padding(
      //             padding: const EdgeInsets.only(top: 40),
      //             child: Container(
      //               child: ListView(
      //                 children: [
      //                   Column(
      //                     //mainAxisSize: MainAxisSize.min,
      //                     children: [
      //                       Env.orderTitle("Order Details", Icons.edit),
      //                       Divider(indent: 10,endIndent: 10),
      //                       Env.order("QTY", widget.data.quantity??""),
      //                       Env.order("Collar", widget.data.collarDesign??""),
      //                       Env.order("Design", widget.data.designType??""),
      //                       Env.order("Sleeve", widget.data.sleeveDesign??""),
      //                       Env.order("Type", widget.data.orderType??""),
      //                       Env.order("TextTile", widget.data.textTileMeter??""),
      //                       Env.order("Date", widget.data.deliveryDate??""),
      //                       Env.order("Status", widget.data.orderState??""),
      //                       Env.order("Remarks", widget.data.remarks??""),
      //                       Divider(indent: 30,endIndent: 30,),
      //                       Env.order("Price", widget.data.amount),
      //                       Env.order("Advance", widget.data.receivedAmount),
      //                       Divider(indent: 30,endIndent: 30),
      //                       Env.order("Total Balance", widget.data.total),
      //                     ],
      //                   ),
      //
      //                 ],
      //               ),
      //               decoration: BoxDecoration(
      //                   boxShadow: [
      //                     BoxShadow(
      //                       color: GreyColor.withOpacity(.4),
      //                       offset: Offset(1,1), //(x,y)
      //                       blurRadius: 5.0,
      //                     ),
      //                   ],
      //                   color: WhiteColor, borderRadius: BorderRadius.all(Radius.circular(20.0))),
      //               height: size.height * .77,
      //               width: size.width * .9,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // )
///Middle
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
