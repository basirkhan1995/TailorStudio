import 'package:flutter/material.dart';
import 'package:tailor/Constants/Methods.dart';

class NewOrder extends StatelessWidget {
  final _formKey = GlobalKey <FormState>();
  final TextEditingController orderID = new TextEditingController();
  final TextEditingController qty = new TextEditingController();
  final TextEditingController amount = new TextEditingController();
  final TextEditingController orderType = new TextEditingController();
  final TextEditingController advanceAmount = new TextEditingController();
  final TextEditingController orderDate = new TextEditingController();
  final TextEditingController deliveryDate = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Env.appBar(context,'فرمایش جدید'),
      body:Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Env.myOrder('آی دی فرمایش', orderID,'#00000', '#:'),
                  Env.myOrder('تعداد جوره', qty,'00', 'جوره '),
                  Env.myOrder('مقدار پول', amount,'0.0000 ','Afs'),
                  Env.myOrder('رسید', advanceAmount,'  0.0000 ', 'Afs'),
                  Env.myOrder('مجموعه بیلانس', orderID,'0.0000', 'Afs'),
                  Env.dateTimePicker('تاریخ فرمایش'),
                  Env.dateTimePicker('تاریخ تاریخ تسلیمی'),

                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
