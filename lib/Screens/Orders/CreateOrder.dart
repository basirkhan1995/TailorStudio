import 'package:flutter/material.dart';
import 'package:tailor/Components/DescriptionField.dart';
import 'package:tailor/Constants/Methods.dart';

class NewOrder extends StatefulWidget {

  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  final _formKey = GlobalKey <FormState>();

  final TextEditingController orderID = new TextEditingController();

  final TextEditingController qty = new TextEditingController();

  final TextEditingController amount = new TextEditingController();

  final TextEditingController orderType = new TextEditingController();

  final TextEditingController advanceAmount = new TextEditingController();

  final TextEditingController orderDate = new TextEditingController();

  final TextEditingController deliveryDate = new TextEditingController();

  String dropdownvalue = 'Pending';
  var items =  ['Complete','Pending','Delivered'];

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

                  Env.myOrder('Order ID', orderID,'#', '#:'),
                  Env.myOrder('QTY', qty,'0', 'جوره '),
                  Env.myOrder('Order Type', qty,'0', 'جوره '),
                  Env.myOrder('Amount', amount,'0 ','Afs'),
                  Env.myOrder('Amount Received', advanceAmount,'  0 ', 'Afs'),
                  Env.myOrder('Balance', orderID,'0', 'Afs'),
                  Row(crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[dropMenu(),Text('Order Status')]),
                  Env.myOrder('Design', orderID,'0', 'Afs'),
                  Env.dateTimePicker('Date of Issue'),
                  Env.dateTimePicker('Delivery Date'),
                  DescriptionField(hintText: 'Remarks',icon: Icons.info,inputType: TextInputType.text),

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
