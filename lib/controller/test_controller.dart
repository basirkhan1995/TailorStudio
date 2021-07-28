import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/services/base_client.dart';
import 'base_controller.dart';


class TestController extends GetxController with BaseController {
  SharedPreferences loginData;
  String user ="";

  //TextField Controllers
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController measure = new TextEditingController();
  TextEditingController waist = new TextEditingController();
  TextEditingController sleeve = new TextEditingController();
  TextEditingController shoulder = new TextEditingController();
  TextEditingController skirt = new TextEditingController();
  TextEditingController height = new TextEditingController();
  TextEditingController pantHeight = new TextEditingController();
  TextEditingController legWidth = new TextEditingController();
  TextEditingController collar = new TextEditingController();

  void getInstance() async{
    loginData = await SharedPreferences.getInstance();
    user = loginData.getString('userID');
  }

   getData() async {
    showLoading('Fetching data');
    var response = await BaseClient().get(Env.url, '/Individuals_Select.php').catchError(handleError);
    if (response == null) return;
    hideLoading();
    print(response);
  }


  void postData() async {
    var request = {
      "firstName": firstName.text,
      "lastName": lastName.text,
      "phone": phone.text,
      "tailor": "$user",
      "height": height.text,
      "shoulder":shoulder.text,
      "sleeve":sleeve.text,
      "collar":collar.text,
      "waist":waist.text,
      "skirt":skirt.text,
      "pantHeight":pantHeight.text,
      "legWidth":legWidth.text,
    };
    showLoading('Posting data...');
    var response = await BaseClient()
        .post(Env.url, '/customerInsert.php', request)
        .catchError(handleError);
    if (response == null) return;
    hideLoading();
    print(response);
  }
}
