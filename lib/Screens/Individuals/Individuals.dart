import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Components/Rounded_Input_Field.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';
import 'package:tailor/Screens/Individuals/CustomerDetails.dart';
import 'package:tailor/Screens/NewClient/New_Client_Form.dart';
import '../../wait.dart';
import 'package:http/http.dart' as http;

class Individual extends StatefulWidget {
  @override
  _IndividualState createState() => _IndividualState();
}

class _IndividualState extends State<Individual> {

  deleteAlbum(id) async {
    print('start');
    final http.Response response = await http.get(
      'https://tailorstudio.000webhostapp.com/Individuals_Delete.php?id=$id', headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',},);
    print('end');

    if (response.statusCode == 200) {
      //print('delete success\n' + response.body);
      return Customer.fromJson(json.decode(response.body));
    } else {
      //print('delete not success \n' + response.body);
      throw Exception('Failed to delete album.');
    }
  }

  SharedPreferences loginData;
  String user ="";
  String customerID ;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async{
    loginData = await SharedPreferences.getInstance();
    setState(() {
      user = loginData.getString('userID');
    });
  }
  Future<List<Customer>> fetchCustomer() async {
    Response res = await get(Uri.parse(Env.url + "sigleCustomer.php?id=$user")).timeout(Duration(seconds: 5));
    if (res.statusCode == 200) {
      //print(res);
      List<dynamic> body = jsonDecode(res.body);
      List<Customer> posts = body.map((dynamic item) => Customer.fromJson(item)).toList();
      //print(posts);
      return posts;
    } else {
      throw "Error";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Env.appBar(context, 'مشتریان'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PurpleColor,
        child: Icon(Icons.person_add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewClient()));
        },
      ),
      body: Column(
        children: [
          RoundedInputField(
            icon: Icons.search,
            hintText: 'جستجو',
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchCustomer(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Customer>> snapshot) {
                if (snapshot.hasData) {
                  List<Customer> posts = snapshot.data;
                  return ListView(
                    children: posts
                        .map((Customer post) => Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: ListTile(
                                leading:CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey[300],
                                  child: post.fileName == null ? Icon(Icons.person_rounded, color: Colors.black.withOpacity(.5), size: 35) :
                                  CircleAvatar(
                                    radius: 30,
                                     backgroundImage: NetworkImage(Env.urlPhoto+post.fileName),
                                     ),
                                ),
                                title: Text(
                                    post.firstName + " " + post.lastName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: GreyColor)),
                                subtitle: Text(
                                    post.email == null ? " " : post.email,
                                    style: TextStyle(fontSize: 12)),
                                trailing: PopupMenuButton(
                                  // onSelected: (int index) {
                                  //   if (index == 1) {
                                  //     Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 NewOrder()));
                                  //   } else {
                                  //     ///Delete
                                  //     //deleteAlbum(post.customerID);
                                  //   }
                                  // },
                                  icon:
                                      Icon(Icons.more_vert, color: PurpleColor),
                                  elevation: 20,
                                  shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: PurpleColor, width: 2)),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                        value: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Create order'),
                                            Icon(Icons.shopping_cart,
                                                color: PurpleColor),
                                            Divider(
                                              height: 1,
                                            ),
                                          ],
                                        )),
                                    PopupMenuItem(
                                        value: 2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                                child: Text('Edit')),
                                            Icon(Icons.edit, color: PurpleColor)
                                          ],
                                        )),
                                    PopupMenuItem(
                                        value: 3,
                                        child: TextButton(
                                          child: Text('Delete'),
                                          onPressed: (){
                                            deleteAlbum(post.customerID);
                                            Navigator.pop(context);
                                          }

                                        )),
                                  ],
                                ),
                                //Individuals Details
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CustomerDetails(post)));
                                },
                              ),
                            ))
                        .toList(),
                  );
                } else {
                  return LoadingCircle();
                  //return LoadingCircle();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
