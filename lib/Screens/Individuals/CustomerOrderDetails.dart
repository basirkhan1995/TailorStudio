import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tailor/Components/Button.dart';
import 'package:tailor/Components/RoundedBorderedField.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:http/http.dart' as http;
import 'package:tailor/HttpServices/CustomerOrdersModel.dart';

class CustomerOrderDetails extends StatefulWidget {
  final Orders data;
  CustomerOrderDetails(this.data);

  @override
  _CustomerOrderDetailsState createState() => _CustomerOrderDetailsState();
}

class _CustomerOrderDetailsState extends State<CustomerOrderDetails> {
  TextEditingController newValue = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Env.appBar(
          context, widget.data.firstName + ' ' + widget.data.lastName),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            child: ListView(
          children: [
            SizedBox(height: 10),
            Env.orderDetails(
                'شماره مسلسل:',
                'C' + widget.data.customerId + 'ORD' + widget.data.orderId ??
                    '',
                null,
                'id.png',
                VoidCallback,
                context),
            Env.orderDetails(
                'نوعیت فرمایش:',
                widget.data.orderType ?? '',
                Icons.edit,
                'receipt.png',
                () => _updateData(context, widget.data.orderType, 1),
                context),
            Env.orderDetails(
                'دیزاین فرمایش:',
                widget.data.designType ?? '',
                Icons.edit,
                'design.png',
                () => _updateData(context, widget.data.designType, 2),
                context),
            Env.orderDetails(
                'تعداد فرمایش:',
                widget.data.quantity ?? '' + ' جوره ' ?? '',
                Icons.edit,
                'qty.png',
                () => _updateData(context, widget.data.quantity, 3),
                context),
            Env.orderDetails(
                'حالت فرمایش:',
                widget.data.orderState ?? '',
                Icons.edit,
                'checklist.png',
                () => _updateData(context, widget.data.orderState, 4),
                context),
            Env.orderDetails(
                'دیزاین یخن:',
                widget.data.collarDesign ?? '',
                Icons.edit,
                'price.png',
                () => _updateData(context, widget.data.collarDesign, 5),
                context),
            Env.orderDetails(
                'دیزاین آستین:',
                widget.data.sleeveDesign ?? '',
                Icons.edit,
                'design.png',
                () => _updateData(context, widget.data.sleeveDesign, 6),
                context),
            Env.orderDetails(
                'متراژ رخت:',
                widget.data.textTileMeter ?? '',
                Icons.edit,
                'qty.png',
                () => _updateData(context, widget.data.textTileMeter, 7),
                context),
            Env.orderDetails(
                'تاریخ تسلیمی:',
                widget.data.deliveryDate ?? '',
                Icons.edit,
                'deliverDate.png',
                () => _updateData(context, widget.data.deliveryDate, 8),
                context),
            Env.orderDetails(
                'پول فی جوره:',
                widget.data.amount ?? '',
                Icons.edit,
                'price-tag.png',
                () => _updateData(context, widget.data.amount, 9),
                context),
            Env.orderDetails(
                'رسید پول:',
                widget.data.receivedAmount ?? '',
                Icons.edit,
                'price.png',
                () => _updateData(context, widget.data.receivedAmount, 10),
                context),
            Env.orderDetails('بیلانس:', widget.data.total ?? '', null,
                'bill3.png', VoidCallback, context),
            Env.orderDetails(
                'ملاحظات:',
                widget.data.remarks ?? '',
                Icons.edit,
                'remarks.png',
                () => _updateData(context, widget.data.remarks, 11),
                context),
            SizedBox(height: 10),
          ],
        )),
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
                            inputType: fieldNo == 3 ||
                                    fieldNo == 7 ||
                                    fieldNo == 9 ||
                                    fieldNo == 10
                                ? TextInputType.number
                                : TextInputType.text,
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
                                  switch (fieldNo) {
                                    case 1:
                                      myData = {
                                        "orderID": widget.data.orderId,
                                        "orderType": newValue.text,
                                        "quantity": widget.data.quantity,
                                        "remarks": widget.data.remarks,
                                        "orderState": widget.data.orderState,
                                        "designType": widget.data.designType,
                                        "sleeve_design":
                                            widget.data.sleeveDesign,
                                        "collar_design":
                                            widget.data.collarDesign,
                                        "textTile_Meter":
                                            widget.data.textTileMeter,
                                        "deliveryDate":
                                            widget.data.deliveryDate,
                                        "amount": widget.data.amount,
                                        "receivedAmount":
                                            widget.data.receivedAmount,
                                      };
                                      break;
                                    case 2:
                                      myData = {
                                        "orderID": widget.data.orderId,
                                        "orderType": widget.data.orderType,
                                        "quantity": widget.data.quantity,
                                        "remarks": widget.data.remarks,
                                        "orderState": widget.data.orderState,
                                        "designType": newValue.text,
                                        "sleeve_design":
                                            widget.data.sleeveDesign,
                                        "collar_design":
                                            widget.data.collarDesign,
                                        "textTile_Meter":
                                            widget.data.textTileMeter,
                                        "deliveryDate":
                                            widget.data.deliveryDate,
                                        "amount": widget.data.amount,
                                        "receivedAmount":
                                            widget.data.receivedAmount,
                                      };
                                      break;
                                    case 3:
                                      myData = {
                                        "orderID": widget.data.orderId,
                                        "orderType": widget.data.orderType,
                                        "quantity": newValue.text,
                                        "remarks": widget.data.remarks,
                                        "orderState": widget.data.orderState,
                                        "designType": widget.data.designType,
                                        "sleeve_design":
                                            widget.data.sleeveDesign,
                                        "collar_design":
                                            widget.data.collarDesign,
                                        "textTile_Meter":
                                            widget.data.textTileMeter,
                                        "deliveryDate":
                                            widget.data.deliveryDate,
                                        "amount": widget.data.amount,
                                        "receivedAmount":
                                            widget.data.receivedAmount,
                                      };
                                      break;
                                    case 4:
                                      myData = {
                                        "orderID": widget.data.orderId,
                                        "orderType": widget.data.orderType,
                                        "quantity": widget.data.quantity,
                                        "remarks": widget.data.remarks,
                                        "orderState": newValue.text,
                                        "designType": widget.data.designType,
                                        "sleeve_design":
                                            widget.data.sleeveDesign,
                                        "collar_design":
                                            widget.data.collarDesign,
                                        "textTile_Meter":
                                            widget.data.textTileMeter,
                                        "deliveryDate":
                                            widget.data.deliveryDate,
                                        "amount": widget.data.amount,
                                        "receivedAmount":
                                            widget.data.receivedAmount,
                                      };
                                      break;
                                    case 5:
                                      myData = {
                                        "orderID": widget.data.orderId,
                                        "orderType": widget.data.orderType,
                                        "quantity": widget.data.quantity,
                                        "remarks": widget.data.remarks,
                                        "orderState": widget.data.orderState,
                                        "designType": widget.data.designType,
                                        "sleeve_design":
                                            widget.data.sleeveDesign,
                                        "collar_design": newValue.text,
                                        "textTile_Meter":
                                            widget.data.textTileMeter,
                                        "deliveryDate":
                                            widget.data.deliveryDate,
                                        "amount": widget.data.amount,
                                        "receivedAmount":
                                            widget.data.receivedAmount,
                                      };
                                      break;
                                    case 6:
                                      myData = {
                                        "orderID": widget.data.orderId,
                                        "orderType": widget.data.orderType,
                                        "quantity": widget.data.quantity,
                                        "remarks": widget.data.remarks,
                                        "orderState": widget.data.orderState,
                                        "designType": widget.data.designType,
                                        "sleeve_design": newValue.text,
                                        "collar_design":
                                            widget.data.collarDesign,
                                        "textTile_Meter":
                                            widget.data.textTileMeter,
                                        "deliveryDate":
                                            widget.data.deliveryDate,
                                        "amount": widget.data.amount,
                                        "receivedAmount":
                                            widget.data.receivedAmount,
                                      };
                                      break;
                                    case 7:
                                      myData = {
                                        "orderID": widget.data.orderId,
                                        "orderType": widget.data.orderType,
                                        "quantity": widget.data.quantity,
                                        "remarks": widget.data.remarks,
                                        "orderState": widget.data.orderState,
                                        "designType": widget.data.designType,
                                        "sleeve_design":
                                            widget.data.sleeveDesign,
                                        "collar_design":
                                            widget.data.collarDesign,
                                        "textTile_Meter": newValue.text,
                                        "deliveryDate":
                                            widget.data.deliveryDate,
                                        "amount": widget.data.amount,
                                        "receivedAmount":
                                            widget.data.receivedAmount,
                                      };
                                      break;
                                    case 8:
                                      myData = {
                                        "orderID": widget.data.orderId,
                                        "orderType": widget.data.orderType,
                                        "quantity": widget.data.quantity,
                                        "remarks": widget.data.remarks,
                                        "orderState": widget.data.orderState,
                                        "designType": widget.data.designType,
                                        "sleeve_design":
                                            widget.data.sleeveDesign,
                                        "collar_design":
                                            widget.data.collarDesign,
                                        "textTile_Meter":
                                            widget.data.textTileMeter,
                                        "deliveryDate": newValue.text,
                                        "amount": widget.data.amount,
                                        "receivedAmount":
                                            widget.data.receivedAmount,
                                      };
                                      break;
                                    case 9:
                                      myData = {
                                        "orderID": widget.data.orderId,
                                        "orderType": widget.data.orderType,
                                        "quantity": widget.data.quantity,
                                        "remarks": widget.data.remarks,
                                        "orderState": widget.data.orderState,
                                        "designType": widget.data.designType,
                                        "sleeve_design":
                                            widget.data.sleeveDesign,
                                        "collar_design":
                                            widget.data.collarDesign,
                                        "textTile_Meter":
                                            widget.data.textTileMeter,
                                        "deliveryDate":
                                            widget.data.deliveryDate,
                                        "amount": newValue.text,
                                        "receivedAmount":
                                            widget.data.receivedAmount,
                                      };
                                      break;
                                    case 10:
                                      myData = {
                                        "orderID": widget.data.orderId,
                                        "orderType": widget.data.orderType,
                                        "quantity": widget.data.quantity,
                                        "remarks": widget.data.remarks,
                                        "orderState": widget.data.orderState,
                                        "designType": widget.data.designType,
                                        "sleeve_design":
                                            widget.data.sleeveDesign,
                                        "collar_design":
                                            widget.data.collarDesign,
                                        "textTile_Meter":
                                            widget.data.textTileMeter,
                                        "deliveryDate":
                                            widget.data.deliveryDate,
                                        "amount": widget.data.amount,
                                        "receivedAmount": newValue.text,
                                      };
                                      break;
                                    case 11:
                                      myData = {
                                        "orderID": widget.data.orderId,
                                        "orderType": widget.data.orderType,
                                        "quantity": widget.data.quantity,
                                        "remarks": newValue.text,
                                        "orderState": widget.data.orderState,
                                        "designType": widget.data.designType,
                                        "sleeve_design":
                                            widget.data.sleeveDesign,
                                        "collar_design":
                                            widget.data.collarDesign,
                                        "textTile_Meter":
                                            widget.data.textTileMeter,
                                        "deliveryDate":
                                            widget.data.deliveryDate,
                                        "amount": widget.data.amount,
                                        "receivedAmount":
                                            widget.data.receivedAmount,
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
                                        "sleeve_design":
                                            widget.data.sleeveDesign,
                                        "collar_design":
                                            widget.data.collarDesign,
                                        "textTile_Meter":
                                            widget.data.textTileMeter,
                                        "deliveryDate":
                                            widget.data.deliveryDate,
                                        "amount": widget.data.amount,
                                        "receivedAmount":
                                            widget.data.receivedAmount,
                                      };
                                  }
                                  http.Response res = await http.post(
                                      Uri.parse(Env.url + "orderUpdate.php"),
                                      body: jsonEncode(myData));
                                  String result = res.body.toString();
                                  if (result == "Success") {
                                    print("Update Success" + result);
                                    await Env.responseDialog(
                                        Env.successTitle,
                                        'موفقانه آپدیت شد!',
                                        DialogType.SUCCES,
                                        context,
                                        () {});
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
}
