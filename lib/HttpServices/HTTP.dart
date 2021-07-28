import 'dart:convert';
import 'package:http/http.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';
import 'package:http/http.dart' as http;


class HttpService {
  Future<List<Customer>> getPosts() async {
    Response res = await get(Uri.parse("https://tailorstudio.000webhostapp.com/sigleCustomer.php"));
    if (res.statusCode == 200) {
      //print(res);
      List<dynamic> body = jsonDecode(res.body);
      List<Customer> posts =
      body.map((dynamic item) => Customer.fromJson(item)).toList();
      //print(posts);
      return posts;
    } else {
      throw "Error has occurred";
    }
  }

  //Single Customer
  Future<List<Customer>> fetchCustomer() async {
    Response res = await get(Uri.parse("https://tailorstudio.000webhostapp.com/Individuals_Select.php"));
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

  Future<List<Customer>> getCustomer() async {
    Response res = await get(Uri.parse("https://tailorstudio.000webhostapp.com/Individuals_Select.php"));
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

  //Update
  Future<http.Response> updateAlbum(String title) {
    return http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );
  }

  // Future<http.Response> deleteCustomer(String title) {
  //   return http.delete(
  //     Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'title': title,
  //     }),
  //   );
  // }

  Future<Customer> deleteAlbum(int id) async {
    final http.Response response = await http.delete(
      'https://tailorstudio.000webhostapp.com/Individuals_Delete.php/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return Customer.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to delete album.');
    }
  }

}