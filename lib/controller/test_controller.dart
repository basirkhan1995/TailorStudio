import 'dart:convert';
import 'package:get/get.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/helper/dialog_helper.dart';
import 'package:tailor/services/app_exceptions.dart';
import 'package:tailor/services/base_client.dart';
import 'base_controller.dart';

class TestController extends GetxController with BaseController {
  getData(id) async {
    showLoading('Fetching data');
    var response = await BaseClient().get(Env.url , "customerOrders.php?id=" + id).catchError(handleError);
    if (response == null) return;
    hideLoading();
    print(response);
  }

  void postData() async {
    var request = {'message': 'CodeX sucks!!!'};
    showLoading('Posting data...');
    var response = await BaseClient().post('https://jsonplaceholder.typicode.com', '/posts', request).catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message);
        DialogHelper.showErroDialog(description: apiError["reason"]);
      } else {
        handleError(error);
      }
    });
    if (response == null) return;
    hideLoading();
    print(response);
  }
}