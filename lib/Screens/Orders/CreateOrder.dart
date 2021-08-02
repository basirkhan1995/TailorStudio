import 'package:flutter/material.dart';
import 'package:tailor/Components/DescriptionField.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';

class NewOrder extends StatefulWidget {
  final Customer post;
  NewOrder(this.post);
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  final _formKey = GlobalKey <FormState>();

  final TextEditingController qty = new TextEditingController();
  final TextEditingController amount = new TextEditingController();
  final TextEditingController orderType = new TextEditingController();
  final TextEditingController designType = new TextEditingController();
  final TextEditingController advanceAmount = new TextEditingController();
  final TextEditingController orderDate = new TextEditingController();
  final TextEditingController deliveryDate = new TextEditingController();
  final TextEditingController remarks = new TextEditingController();

  String dropdownvalue = 'Pending';
  var items =  ['Complete','Pending','Delivered'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Env.appBar(context,widget.post.firstName+' '+widget.post.lastName),
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
                  Env.myOrder('نوعیت فرمایش:','پیراهن تنبان، واسکت، کرتی پطلون', designType,'نوع'),
                  Env.myOrder('نوعیت دوخت:', 'هندی، پاکستانی، ترکی', orderType, 'دوخت'),
                  Env.myOrder('تعداد فرمایش:', 'تعداد جوره لباس', qty, '0'),
                  Env.myOrder('مقدار پول:', 'قیمت وجوره فرمایش', amount, '0'),
                  Env.myOrder('رسید:', 'پول پیش پرداخت', advanceAmount, '0'),
                  Env.dateTimePicker('Date of Issue'),
                  Env.dateTimePicker('Delivery Date'),
                  DescriptionField(hintText: 'ملاحظات',icon: Icons.info,inputType: TextInputType.text),
                  dropMenu(),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

   dropMenu(){
    return DropdownButton(
      value: dropdownvalue,
      icon: Icon(Icons.keyboard_arrow_down),
      items:items.map((String items) {
        return DropdownMenuItem(
            value: items,
            child: Text(items)
        );
      }
      ).toList(),
      onChanged: (String newValue){
        setState(() {
          dropdownvalue = newValue;
        });
      },
    );
  }

}
