import 'dart:convert';
import 'package:http/http.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';

class HttpService {

  Future<List<Individuals>> getPosts() async {
    Response res = await get(Uri.parse(Env.url+"Individuals_Select.php"));
    if (res.statusCode == 200) {
      //print(res);
      List<dynamic> body = jsonDecode(res.body);
      List<Individuals> posts =
      body.map((dynamic item) => Individuals.fromJson(item)).toList();
      //print(posts);
      return posts;
    } else {
      throw "Error has occured";
    }
  }
}