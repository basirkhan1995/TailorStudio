import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tailor/Components/Button.dart';
import 'package:tailor/Components/DescriptionField.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';
import 'package:http/http.dart' as http;
import 'package:tailor/Screens/Individuals/ShowCustomer.dart';

class NewOrder extends StatefulWidget {
  final Customer post;
  NewOrder(this.post);
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  final _formKey = GlobalKey <FormState>();
  final DateTime now = DateTime.now();
  String user = "";

  final TextEditingController qty = new TextEditingController();
  final TextEditingController amount = new TextEditingController();
  final TextEditingController orderType = new TextEditingController();
  final TextEditingController collarDesign = new TextEditingController();
  final TextEditingController sleeveDesign = new TextEditingController();
  final TextEditingController designType = new TextEditingController();
  final TextEditingController textTileMeter = new TextEditingController();
  final TextEditingController advanceAmount = new TextEditingController();
  final TextEditingController orderState = new TextEditingController();
  final TextEditingController orderDate = new TextEditingController();
  final TextEditingController deliveryDate = new TextEditingController();
  final TextEditingController remarks = new TextEditingController();

  String valueChoose;
  String valueCollar;
  String valueSleeve;
  String valueOrder;
  var items =  ['پیراهن تنبان','واسکت','یخن قاق','کرتی پطلون','پطلون'];
  var design =  ['هندی','پاکستانی','ترکی','افغانی','عربی','کرزیی'];
  var collar =  ['یخن هندی حلقوی','یخن قاسمی','چپه یخن','یخن چاک دار'];
  var sleeve =  ['کف دار','دکمه دار','محرابی'];
  var status =  ['Complete','Pending','Delivered'];

  void createOrder() async {
    http.Response res = await http.post(Uri.parse(Env.url+"createOrder.php"), body: jsonEncode({
      "orderType": valueChoose,
      "quantity":qty.text,
      "remarks":remarks.text,
      "customer":widget.post.customerId,
      "designType": valueOrder,
      "sleeve_design": valueSleeve,
      "collar_design": valueCollar,
      "textTile_Meter":textTileMeter.text,
      "orderDate":"2021-2-8",
      "deliveryDate":"2021-6-6",
      "amount":amount.text,
      "receivedAmount":advanceAmount.text,

    }));
    String result = res.body.toString();
    print(result);
    if(result == "Success"){
      await Env.responseDialog(
          Env.successTitle,'فرمایش شما موفقانه ثبت گردید',DialogType.SUCCES, context, () { });
      Navigator.push(context, MaterialPageRoute(builder: (context) => Individual()));
    }else {
      print(result);
      await Env.errorDialog(
          Env.errorTitle,'فرمایش شما ثبت نگردید لطفا دوباره کوشش نمایید',DialogType.ERROR, context, () { });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
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
                  dropDownMenu(),
                  designDownMenu(),
                  collarDownMenu(),
                  sleeveDownMenu(),
                  Env.myOrder('متراژ رخت:', 'تعداد متراژ رخت', textTileMeter, '','',TextInputType.number),
                  Env.myOrder('تعداد فرمایش لباس:', 'تعداد جوره لباس', qty, '','',TextInputType.number),
                  Env.myOrder('مقدار پول:', 'قیمت وجوره فرمایش', amount, '','',TextInputType.number),
                  Env.myOrder('رسید:', 'پول پیش پرداخت', advanceAmount, '','',TextInputType.number),
                  //Env.dateTimePicker('تاریخ فرمایش:',orderDate),
                  //Env.dateTimePicker('تاریخ تسلیمی فرمایش:',deliveryDate),
                  DescriptionField(hintText: 'ملاحظات',icon: Icons.info,inputType: TextInputType.text,controller: remarks),
                  //dropMenu(),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Button(text: 'Cancel',paint: WhiteColor,textColor: PurpleColor,press: (){
                        Navigator.pop(context);
                      }),
                      Button(text: 'Save', paint: WhiteColor,textColor: PurpleColor,press: (){
                        if(_formKey.currentState.validate()){
                          /// Function Send Data
                          createOrder();
                        }}),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  dropDownMenu(){
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8,bottom:8.0, top: 8.0 ),
      child: Container(
        padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 8, top: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border:Border.all(color: GreyColor, width: 1)
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: DropdownButton(
            underline: SizedBox(),
            style: Env.style(17, BlackColor.withOpacity(.6)),
            elevation: 20,
            hint: Text('دیزاین لباس را انتخاب کنید'),
            value: valueChoose,
            onChanged: (String newValue){
              setState(() {
                valueChoose = newValue;
              });
            },
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down),
            items:items.map((String items) {
              return DropdownMenuItem(
                  value: items,
                  child: Text(items)
              );
            }
            ).toList(),

          ),
        ),
      ),
    );
 }

  designDownMenu(){
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8,bottom:8.0, top: 8.0 ),
      child: Container(
        padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 8, top: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border:Border.all(color: GreyColor, width: 1)
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: DropdownButton(
            underline: SizedBox(),
            style: Env.style(17, BlackColor.withOpacity(.6)),
            elevation: 20,
            hint: Text('دیزاین لباس را انتخاب کنید'),
            value: valueOrder,
            onChanged: (String newValue){
              setState(() {
                valueOrder = newValue;
              });
            },
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down),
            items:design.map((String items) {
              return DropdownMenuItem(
                  value: items,
                  child: Text(items)
              );
            }
            ).toList(),

          ),
        ),
      ),
    );
  }

  collarDownMenu(){
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8,bottom:8.0, top: 8.0 ),
      child: Container(
        padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 8, top: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border:Border.all(color: GreyColor, width: 1)
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: DropdownButton(
            underline: SizedBox(),
            style: Env.style(17, BlackColor.withOpacity(.6)),
            elevation: 20,
            hint: Text('دوخت یخن لباس را انتخاب کنید'),
            value: valueCollar,
            onChanged: (String newValue){
              setState(() {
                valueCollar = newValue;
              });
            },
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down),
            items:collar.map((String items) {
              return DropdownMenuItem(
                  value: items,
                  child: Text(items)
              );
            }
            ).toList(),

          ),
        ),
      ),
    );
  }

  sleeveDownMenu(){
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8,bottom:8.0, top: 8.0 ),
      child: Container(
        padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 8, top: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border:Border.all(color: GreyColor, width: 1)
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: DropdownButton(
            underline: SizedBox(),
            style: Env.style(17, BlackColor.withOpacity(.6)),
            elevation: 20,
            hint: Text('دوخت آستین را انتخاب کنید'),
            value: valueSleeve,
            onChanged: (String newValue){
              setState(() {
                valueSleeve = newValue;
              });
            },
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down),
            items:sleeve.map((String items) {
              return DropdownMenuItem(
                  value: items,
                  child: Text(items)
              );
            }
            ).toList(),

          ),
        ),
      ),
    );
  }



}
