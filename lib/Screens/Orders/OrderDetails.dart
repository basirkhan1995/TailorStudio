import 'package:flutter/material.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyOrder(),
      appBar: Env.appBar(context,'جزئیات فرمایش'),
    );
  }


 Widget MyOrder(){

   return ListView(
     children: [
       myOrderDetails('#50002', 'تکمیل', 'نوید عابدی', 'پیراهن تنبان', '2', '400', '800', '12/2/1400', '12/21/1400', "دیزاین پاکستانی"),
     ],
   );
 }
  //Order Detail Function
  Widget myOrderDetails(orderID,orderStatus, orderBy, orderType, qty, amount, total, orderDate, deliveryDate,remarks ){
    return SingleChildScrollView(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.only(top:18.0),
          child: Column(
            children: [
              Card(
                child: Row(
                  children: [
                    //leading
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('شماره مسلسل:  ',style: PersianFonts.Samim.copyWith(
                        fontSize: 17,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: GreyColor,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                  //title
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(orderID,style: PersianFonts.Samim.copyWith(
                        fontSize: 17,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: GreyColor,
                        fontWeight: FontWeight.w300,
                      )),
                    ),
                  ],
                ),
              ),
  // Ordered By

              Card(
                child: Row(
                  children: [
                    //leading
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('فرمایش دهنده:  ',style: PersianFonts.Samim.copyWith(
                        fontSize: 17,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: GreyColor,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    //title
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(orderBy,style: PersianFonts.Samim.copyWith(
                        fontSize: 17,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: GreyColor,
                        fontWeight: FontWeight.w300,
                      )),
                    ),
                  ],
                ),
              ),
           //Order Status

              Card(
                child: Row(
                  children: [
                    //leading
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('حالت:  ',style: PersianFonts.Samim.copyWith(
                        fontSize: 17,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: GreyColor,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    //title
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(orderStatus,style: PersianFonts.Samim.copyWith(
                        fontSize: 17,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: GreyColor,
                        fontWeight: FontWeight.w300,
                      )),
                    ),
                  ],
                ),
              ),


              Card(
                child: Row(
                  children: [
                    //leading
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('نوع فرمایش:    ',style: PersianFonts.Samim.copyWith(
                        fontSize: 17,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: GreyColor,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    //title
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(orderType,style: PersianFonts.Samim.copyWith(
                        fontSize: 17,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: GreyColor,
                        fontWeight: FontWeight.w300,
                      )),
                    ),
                  ],
                ),
              ),


              Card(
                child: Row(
                  children: [
                    //leading
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('تعداد: ',style: PersianFonts.Samim.copyWith(
                        fontSize: 17,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: GreyColor,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    //title
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(qty,style: PersianFonts.Samim.copyWith(
                        fontSize: 17,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: GreyColor,
                        fontWeight: FontWeight.w300,
                      )),
                    ),
                  ],
                ),
              ),


              Card(
                child: Row(
                  children: [
                    //leading
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('فیات: ',style: PersianFonts.Samim.copyWith(
                        fontSize: 17,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: GreyColor,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    //title
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(amount,style: PersianFonts.Samim.copyWith(
                        fontSize: 17,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: GreyColor,
                        fontWeight: FontWeight.w300,
                      )),
                    ),
                  ],
                ),
              ),


              Card(
                child: Row(
                  children: [
                    //leading
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('مجموعه: ',style: PersianFonts.Samim.copyWith(
                        fontSize: 17,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: GreyColor,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    //title
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(total,style: PersianFonts.Samim.copyWith(
                        fontSize: 17,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: GreyColor,
                        fontWeight: FontWeight.w300,
                      )),
                    ),
                  ],
                ),
              ),


              Card(
                child: Row(
                  children: [
                    //leading
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('تاریخ: ',style: PersianFonts.Samim.copyWith(
                        fontSize: 17,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: GreyColor,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    //title
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(orderDate,style: PersianFonts.Samim.copyWith(
                        fontSize: 17,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: GreyColor,
                        fontWeight: FontWeight.w300,
                      )),
                    ),
                  ],
                ),
              ),

              Card(
                child: Row(
                  children: [
                    //leading
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('تاریخ تسلیمی: ',style: PersianFonts.Samim.copyWith(
                        fontSize: 17,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: GreyColor,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    //title
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(deliveryDate,style: PersianFonts.Samim.copyWith(
                        fontSize: 17,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: GreyColor,
                        fontWeight: FontWeight.w300,
                      )),
                    ),
                  ],
                ),
              ),

              Card(
                child: Row(
                  children: [
                    //leading
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('ملاحظات: ',style: PersianFonts.Samim.copyWith(
                        fontSize: 17,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: GreyColor,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    //title
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(remarks,style: PersianFonts.Samim.copyWith(
                        fontSize: 17,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: GreyColor,
                        fontWeight: FontWeight.w300,
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
