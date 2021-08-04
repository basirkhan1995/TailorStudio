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
                  Env.myOrder('نوعیت فرمایش:','پیراهن تنبان، واسکت، کرتی پطلون', designType,''),
                  Env.myOrder('نوعیت دوخت:', 'هندی، پاکستانی، ترکی', orderType, ''),
                  Env.myOrder('نوعیت دوخت یخن:', 'قاسمی، هندی، چپه یخن', orderType, ''),
                  Env.myOrder('دوخت دهن آستین:', 'کف دار، محرابی، دکمه دار', orderType, ' '),
                  Env.myOrder('متراژ رخت:', 'تعداد متراژ رخت', orderType, ''),
                  Env.myOrder('تعداد فرمایش:', 'تعداد جوره لباس', qty, ''),
                  Env.myOrder('مقدار پول:', 'قیمت وجوره فرمایش', amount, ''),
                  Env.myOrder('رسید:', 'پول پیش پرداخت', advanceAmount, ''),
                  Env.dateTimePicker('Date of Issue'),
                  Env.dateTimePicker('Delivery Date'),
                  DescriptionField(hintText: 'ملاحظات',icon: Icons.info,inputType: TextInputType.text),
                  dropMenu(),

                  // DropdownButtonHideUnderline(
                  //   child: ButtonTheme(
                  //     minWidth: 80,
                  //     padding: EdgeInsets.symmetric(vertical: 5,horizontal: 80),
                  //     child: DropdownButton(
                  //       elevation: 20,
                  //       hint: Text('Select value'),
                  //       value: dropdownvalue,
                  //       icon: Icon(Icons.keyboard_arrow_down),
                  //       items:items.map((String items) {
                  //         return DropdownMenuItem(
                  //             value: items,
                  //             child: Text(items)
                  //         );
                  //       }
                  //       ).toList(),
                  //       onChanged: (String newValue){
                  //         setState(() {
                  //           dropdownvalue = newValue;
                  //         });
                  //       },
                  //     )
                  //   ),
                  // )
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
