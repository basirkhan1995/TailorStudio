import 'dart:convert';
import 'package:http/http.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';

class HttpService {
  Future<List<Customer>> getPosts() async {
    Response res = await get(Uri.parse("https://tailorstudio.000webhostapp.com/sigleCustomer.php?userID="));
    if (res.statusCode == 200) {
      //print(res);
      List<dynamic> body = jsonDecode(res.body);
      List<Customer> posts =
      body.map((dynamic item) => Customer.fromJson(item)).toList();
      //print(posts);
      return posts;
    } else {
      throw "Error has occured";
    }
  }
}