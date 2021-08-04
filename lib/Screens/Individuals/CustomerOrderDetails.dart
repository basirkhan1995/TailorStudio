import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tailor/Components/Button.dart';
import 'package:tailor/Components/RoundedBorderedField.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:http/http.dart' as http;
import 'package:tailor/HttpServices/IndividualsModel.dart';
import 'package:tailor/HttpServices/OrderList.dart';

class CustomerOrderDetails extends StatefulWidget {
  final MyOrders data;
  final Customer post;
  CustomerOrderDetails(this.data,this.post);

  @override
  _CustomerOrderDetailsState createState() => _CustomerOrderDetailsState();
}

class _CustomerOrderDetailsState extends State<CustomerOrderDetails> {
  final TextEditingController newValue = new TextEditingController();

   @override
   void initState() {
     super.initState();
   }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Env.appBar(context, 'Order Details'),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            child: ListView(
              children: [
                SizedBox(height: 10),
                Env.customTile('شماره مسلسل:','C'+widget.post.customerId+'ORD'+widget.post.orderId??'',VoidCallback, context),
                Env.customTile('نوعیت فرمایش:',widget.post.orderType??'',()=>_updateData(context, widget.post.orderType, 1), context),
                Env.customTile('دیزاین:',widget.post.designType??'',()=>_updateData(context, widget.post.designType, 2), context),
                Env.customTile('تعداد فرمایش:',widget.post.quantity+' جوره '??'',()=>_updateData(context, widget.post.quantity, 3), context),
                Env.customTile('قیمت:',widget.post.amount??'',()=>_updateData(context, widget.post.amount, 4), context),
                Env.customTile('رسید پول:',widget.post.receivedAmount??'',()=>_updateData(context, widget.post.receivedAmount, 5), context),
                Env.customTile('مجموعه بیلانس:',widget.post.total??'',VoidCallback, context),
                Env.customTile('وضعیت:',widget.post.orderState??'',()=>_updateData(context, widget.post.orderState, 6), context),
                Env.customTile('تاریخ:',widget.post.orderType??'',()=>_updateData(context, widget.post.orderType, 7), context),
                Env.customTile('تاریخ تسلیمی:',widget.post.orderType??'',()=>_updateData(context, widget.post.orderType, 8), context),
                Env.customTile('ملاحظات:',widget.post.remarks??'',()=>_updateData(context, widget.post.remarks, 9), context),
                SizedBox(height: 10),
              ],
            )
        ),
      ),
    );
  }

   _updateData(context, value, int fieldNo) {
     value == null ? newValue.text = "N/A" : newValue.text = value;
     var myData;
     showModalBottomSheet(
         shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
         backgroundColor: WhiteColor,
         context: context,
         isScrollControlled: true,
         builder: (context) => Padding(
           padding: const EdgeInsets.symmetric(horizontal:18 ),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisSize: MainAxisSize.min,
             children: <Widget>[
               SizedBox(height: 10),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
                 child: Text('Do you want update ' + newValue.text + "?", style:Env.style(16, PurpleColor)),
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
                         inputType:TextInputType.number,
                         hintText: '',
                         controller: newValue,
                         icon: Icons.info_outline
                     ),
                     SizedBox(height: 10),
                     Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Button(text: 'Save',textColor: PurpleColor,paint: WhiteColor,
                             press: () async {
                               switch(fieldNo){
                                 case 1:
                                   myData = {

                                   };
                                   break;
                                 default:
                                   myData = {



                                   };
                               }
                               http.Response res = await http.post(Uri.parse(Env.url+"measureUpdate.php"),body: jsonEncode(myData));
                               String result = res.body.toString();
                               if (result == "Success"){
                                 print("Update Success"+result);
                                 await Env.responseDialog(Env.successTitle,'موفقانه آپدیت شد!',DialogType.SUCCES, context, () { });
                                 Navigator.pop(context);
                               }else if (result == "Failed"){
                                 await Env.errorDialog(
                                     Env.successTitle,'خطا در آپدیت',DialogType.ERROR, context, () { });
                               }
                             },
                           ),
                           Button(text: 'Cancel',textColor: PurpleColor,paint: WhiteColor,press: (){
                             Navigator.pop(context);
                           },),
                         ]),
                   ],
                 ),
               ),
               SizedBox(height: 10),
             ],
           ),
         ));
   }

}
