import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:tailor/Constants/Methods.dart';
import 'CustomerOrdersModel.dart';
import 'IndividualsModel.dart';
import 'OrderList.dart';

class CharacterApi {
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
  ///////////////////////////////////////////////////////////////////////////
  TextEditingController newValue = new TextEditingController();
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController waist = new TextEditingController();
  TextEditingController sleeve = new TextEditingController();
  TextEditingController shoulder = new TextEditingController();
  TextEditingController skirt = new TextEditingController();
  TextEditingController height = new TextEditingController();
  TextEditingController pantHeight = new TextEditingController();
  TextEditingController legWidth = new TextEditingController();
  TextEditingController collar = new TextEditingController();

  String valueChoose;
  String valueCollar;
  String valueSleeve;
  String valueMonths;
  String valueDays;
  String valueOrder;
  File imageFile;

  var days = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10',
    '11', '12', '13', '14', '15', '16', '17', '18', '19', '20',
    '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31'];

  var months = ['حمل', 'ثور', 'جوزا', 'سرطان', 'اسد', 'سنبله', 'میزان', 'عقرب', 'قوس', 'جدی', 'دلو', 'حوت'];
  var itemType = ['پیراهن تنبان', 'واسکت', 'یخن قاق', 'کرتی پطلون', 'پطلون', 'دیگر'];
  var designTypeData = ['هندی', 'پاکستانی', 'ترکی', 'افغانی', 'عربی', 'کرزیی', 'دیگر'];
  var collarListData = ['یخن هندی حلقوی', 'یخن قاسمی', 'چپه یخن', 'یخن چاک دار', 'دیگر'];
  var sleeveListData = ['کف دار', 'دکمه دار', 'محرابی', 'دیگر'];

  //POST DATA, Create Order Function
  void createOrder(customerID, voidCallBack, context) async {
    http.Response res = await http.post(Uri.parse(Env.url + "createOrder.php"),
        body: jsonEncode({
          "orderType": valueChoose,
          "quantity": qty.text,
          "remarks": remarks.text,
          "customer": customerID,
          "designType": valueOrder,
          "sleeve_design": valueSleeve,
          "collar_design": valueCollar,
          "textTile_Meter": textTileMeter.text,
          "orderDate": "$valueMonths " + " $valueDays",
          "deliveryDate": "$valueMonths " + " $valueDays",
          "amount": amount.text,
          "receivedAmount": advanceAmount.text,
        }));
    String result = res.body.toString();
    print(result);
    if (result == "Success") {
      voidCallBack(() {
        Env.loader = false;
      });
      await Env.responseDialog(Env.successTitle, 'فرمایش شما موفقانه ثبت گردید', DialogType.SUCCES, context, () {});
      Navigator.pop(context);
    } else {
      voidCallBack(() {
        Env.loader = false;
      });
      print(result + ' empty field recognised');
      await Env.errorDialog('Empty fields',
          'لطفا تمام گزینه های فرمایش را درست انتخاب نمایید', DialogType.ERROR, context, () {});
    }
  }


  //GET DATA, Fetch Customer's Orders
  Future<List<Orders>> fetchCustomerOrders(String userID) async {
    var response = await get(Uri.parse(Env.url + "customerOrders.php?id=" + userID)).timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      //print(response.body);
      List<dynamic> body = jsonDecode(response.body);
      List<Orders> posts = body.map((dynamic item) => Orders.fromJson(item)).toList();
      //print(posts);
      return posts;
    } else {
      throw "Error";
    }
  }

//DELETE POST, Delete Customer
  deleteCustomer(id,context) async {
    final http.Response response = await http.get(
        Uri.parse(Env.url + 'Individuals_Delete.php?id=$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode == 200) {
      //print('delete success\n' + response.body);
      return Customer.fromJson(json.decode(response.body));
    } else {
      //await Future.delayed(Duration(seconds: 5));
      await Env.errorDialog('Error', 'Access Denied Try again.', DialogType.WARNING, context, () { });
      //print('delete not success \n' + response.body);
      throw Exception('Failed to delete album.');
    }
  }

  //GET DATA, Fetch Customers List
  Future<List<Customer>> fetchCustomer(String userID, context) async {
    try {
        Response res = await get(Uri.parse(Env.url + "singleCustomer.php?id=" + userID)).timeout(Duration(seconds: 5));
        if (res.statusCode == 200) {
          List<dynamic> body = jsonDecode(res.body);
          List<Customer> posts = body.map((dynamic item) => Customer.fromJson(item)).toList();
          return posts;
        }
    } on SocketException catch (_) {
      return null;
    } on TimeoutException catch (_) {
      return null;
    }
    return null;
  }

  //GET DATA, Total Orders of a user
  Future<List<MyOrders>> fetchUserOrders(String userID) async {
    var response = await get(Uri.parse(Env.url + "userOrders.php?id=" + userID))
        .timeout(Duration(seconds: 10));
    if (response.statusCode == 200) {
      //print(res);
      List<dynamic> body = jsonDecode(response.body);
      List<MyOrders> posts =
          body.map((dynamic item) => MyOrders.fromJson(item)).toList();
      //print(posts);
      return posts;
    } else {
      throw "Error";
    }
  }

  //POST DATA, Insert Customer AND measurement
  void sendData(String userID, context) async {
    http.Response res =
        await http.post(Uri.parse(Env.url + "customerInsert.php"),
            body: jsonEncode({
              "firstName": firstName.text,
              "lastName": lastName.text,
              "phone": phone.text,
              "tailor": userID,
              "height": height.text,
              "shoulder": shoulder.text,
              "sleeve": sleeve.text,
              "collar": collar.text,
              "waist": waist.text,
              "skirt": skirt.text,
              "pantHeight": pantHeight.text,
              "legWidth": legWidth.text,
            }));
    String result = res.body.toString();
    print(result);
    if (result == "Success") {
      Env.loader = false;
      await Env.responseDialog(Env.successTitle, Env.successCustomerAcc,
          DialogType.SUCCES, context, () {});
      Navigator.pop(context);
    } else {
      Env.loader = false;
      print(result);
      await Env.errorDialog(
          Env.errorTitle, 'مشتری شما ثبت نگردید لطفا دوباره کوشش نمایید!',
          DialogType.ERROR,
          context,
          () {});
    }
  }


  //Upload
  void uploadProfile(customerID, context) async {
    http.Response res = await http.post(Uri.parse(Env.url + "uploadImage.php"),
        body: jsonEncode({
          "fileName": imageFile.path.split('/').last,
          "customerID": customerID,
        }));
    String result = res.body.toString();
    // print(widget.post.customerID);
    if (imageFile.path == null) {
    } else if (result == "Success") {
      print(result);
    } else if (result == "Failed") {

    }
  }
}
