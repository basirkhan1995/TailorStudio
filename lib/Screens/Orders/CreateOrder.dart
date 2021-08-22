import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tailor/Components/Button.dart';
import 'package:tailor/Components/DescriptionField.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/HttpServices.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';

class NewOrder extends StatefulWidget {
  final Customer post;
  NewOrder(this.post);
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  final _formKey = GlobalKey <FormState>();
  final controller = CharacterApi();
  String user = "";

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
                  monthsDownMenu(),
                  daysDownMenu(),
                  Env.myOrder('متراژ رخت:', 'تعداد متراژ رخت', controller.textTileMeter, '','',TextInputType.number),
                  Env.myOrder('تعداد فرمایش لباس:', 'تعداد جوره لباس', controller.qty, '','',TextInputType.number),
                  Env.myOrder('مقدار پول:', 'قیمت وجوره فرمایش', controller.amount, '','',TextInputType.number),
                  Env.myOrder('رسید:', 'پول پیش پرداخت', controller.advanceAmount, '','',TextInputType.number),
                  DescriptionField(hintText: 'ملاحظات',icon: Icons.info,inputType: TextInputType.text,controller: controller.remarks),
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
                          controller.createOrder(widget.post.customerId,context);
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


  ///Drop Down Menu
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
            value: controller.valueChoose,
            onChanged: (String newValue){
              setState(() {
                controller.valueChoose = newValue;
              });
            },
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down),
            items:controller.itemType.map((String items) {
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
            value: controller.valueOrder,
            onChanged: (String newValue){
              setState(() {
                controller.valueOrder = newValue;
              });
            },
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down),
            items:controller.designTypeData.map((String items) {
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
            value: controller.valueCollar,
            onChanged: (String newValue){
              setState(() {
                controller.valueCollar = newValue;
              });
            },
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down),
            items:controller.collarListData.map((String items) {
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
            value: controller.valueSleeve,
            onChanged: (String newValue){
              setState(() {
                controller.valueSleeve = newValue;
              });
            },
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down),
            items:controller.sleeveListData.map((String items) {
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

  monthsDownMenu(){
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
            hint: Text('انتخاب تاریخ تسلیمی (ماه):'),
            value: controller.valueMonths,
            onChanged: (String newValue){
              setState(() {
                controller.valueMonths = newValue;
              });
            },
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down),
            items:controller.months.map((String items) {
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

  daysDownMenu(){
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
          child: Center(
            child: DropdownButton(
              menuMaxHeight: 500,
              dropdownColor: WhiteColor,
              iconEnabledColor: GreyColor,
              underline: SizedBox(),
              style: Env.style(17, BlackColor.withOpacity(.6)),
              elevation: 20,
              hint: Text('انتخاب تسلیمی (روز):'),
              value: controller.valueDays,
              onChanged: (String newValue){
                setState(() {
                  controller.valueDays = newValue;
                });
              },
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down),
              items:controller.days.map((String items) {
                return DropdownMenuItem(
                    value: items,
                    child: Text(items)
                );
              }
              ).toList(),

            ),
          ),
        ),
      ),
    );
  }

}
