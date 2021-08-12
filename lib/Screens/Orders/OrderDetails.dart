import 'package:flutter/material.dart';
import 'package:tailor/Constants/Methods.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Env.appBar(context, 'C' + widget.data.customerId + 'ORD' + widget.data.orderId??''),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            child: ListView(
          children: [
            SizedBox(height: 10),
            Env.customTile('شماره مسلسل:', 'C' + widget.data.customerId + 'ORD' + widget.data.orderId ?? '','id.png',null, context),
            Env.customTile('نوعیت فرمایش:', widget.data.orderType ?? '','receipt.png',null, context),
            Env.customTile('دیــــزاین فرمایش:', widget.data.designType ?? '', 'design.png',null,  context),
            Env.customTile('تعداد فرمایش:', widget.data.quantity + ' جوره '??'','qty.png',null, context),
            Env.customTile('مقدار پول:', widget.data.amount ?? '', 'price-tag.png',null, context),
            Env.customTile('رسید پول:', widget.data.receivedAmount ?? '','price.png',null, context),
            Env.customTile('مجموعه بیلانس:', widget.data.total ?? '', 'bill3.png',null, context),
            Env.customTile('حالت فرمایش:', widget.data.orderState ?? '','checklist.png',null, context),
            Env.customTile('تاریخ تسلیمی:', widget.data.deliveryDate ?? '','deliverDate.png',null, context),
            Env.customTile('ملاحظات:', widget.data.remarks ?? '', 'remarks.png',null, context),
            SizedBox(height: 10),
          ],
        )),
      ),
    );
  }


}
