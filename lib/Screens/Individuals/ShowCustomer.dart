import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Components/SearchField.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';
import 'package:tailor/Screens/Individuals/CustomerDetails.dart';
import 'package:tailor/Screens/NewClient/New_Client_Form.dart';
import 'package:tailor/Screens/Orders/CreateOrder.dart';
import '../../wait.dart';
import 'package:http/http.dart' as http;

class Individual extends StatefulWidget {

  @override
  _IndividualState createState() => _IndividualState();
}

class _IndividualState extends State<Individual> {


//Delete Customer
  deleteCustomer(id) async {
    final http.Response response = await http.get(
        Env.url+'Individuals_Delete.php?id=$id',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode == 200) {
      //print('delete success\n' + response.body);
      return Customer.fromJson(json.decode(response.body));
    } else {
      //print('delete not success \n' + response.body);
      throw Exception('Failed to delete album.');
    }
  }

  SharedPreferences loginData;
  String user = "";
  String customerID;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      user = loginData.getString('userID');
    });
  }


  Future<List<Customer>> fetchCustomer(context) async {
    try{
      Response res = await get(Uri.parse(Env.url + "singleCustomer.php?id=$user")).timeout(Duration(seconds: 10));
      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);
        List<Customer> posts =
        body.map((dynamic item) => Customer.fromJson(item)).toList();
        return posts;
      }
    } on SocketException catch(_){
    return Env.errorDialog('No Internet', Env.noInternetMessage, DialogType.ERROR, context, () { });
    }on TimeoutException catch(_){
      return Env.errorDialog('خطا در شبکه', Env.timeOut, DialogType.ERROR, context, () {
      });
  }
  return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Env.appBar(context, 'مشتریان'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PurpleColor,
        child: Icon(Icons.person_add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewClient()));
        },
      ),
      body: Column(
        children: [
          SearchField(
            icon: Icons.search,
            hintText: 'جستجو',
          ),
          Expanded(
            child: RefreshIndicator(
              color: PurpleColor,
              strokeWidth: 3,
              onRefresh: () {
                return Future.delayed(
                  Duration(microseconds: 1),() {
                  setState(() {
                    fetchCustomer(context);
                  });
                },
                );
              },
              child: FutureBuilder(
                future: fetchCustomer(context),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Customer>> snapshot) {
                  if (snapshot.hasData) {List<Customer> posts = snapshot.data;
                    return ListView(
                      children: posts.map((Customer post) => Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[300],
                            child: post.fileName == null ?
                                CircleAvatar(radius: 60,
                                 backgroundImage: AssetImage('photos/background/no_user.jpg'),
                            ):CircleAvatar(
                              radius: 30,
                              foregroundImage: NetworkImage(Env.urlPhoto + post.fileName),
                              backgroundImage: AssetImage('photos/background/no_user.jpg'),
                            ),
                          ),
                          title: Text(
                              post.firstName + " " + post.lastName, style: TextStyle(fontWeight: FontWeight.bold,
                              color: GreyColor)),
                          subtitle: Text(
                              "CUSTOMER ID#: "+ post.customerId, style: TextStyle(fontSize: 12)),
                          trailing: PopupMenuButton(
                            icon: Icon(Icons.more_vert,
                                color: PurpleColor),
                            elevation: 20,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  child: Row(
                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(child: Text('Create order'),
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>NewOrder(post)));
                                      },
                                      ),
                                      Spacer(),
                                      Icon(Icons.shopping_cart,color: PurpleColor),
                                      Divider(height: 1),
                                    ],
                                  )),
                              PopupMenuItem(
                                  child: Row(
                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(child: Text('Edit'),
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerDetails(post)));
                                        },
                                      ),
                                      Icon(Icons.edit,color: PurpleColor)
                                    ],
                                  )),
                              PopupMenuItem(
                                  child: Row(
                                    children: [
                                      InkWell(
                                        child: Text('Delete',style: Env.style(16, Colors.red.shade900)),
                                        onTap: ()async{
                                          Env.checkYesNoLogin = false;
                                          await Env.confirmDelete('Delete', 'آیا میخواهید این مشتری را حذف کنید؟', DialogType.QUESTION, context, setState);
                                          if(Env.checkYesNoLogin == true){
                                            print("result = " + Env.checkYesNoLogin.toString());
                                            deleteCustomer(post.customerId);
                                            Navigator.pop(context);
                                          }else{
                                            print("result = "+ Env.checkYesNoLogin.toString());
                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                      Spacer(),
                                      Icon(Icons.delete,color:Colors.red.shade900)],
                                  )),
                            ],
                          ),
                          //Individuals Details
                          onTap: () {Navigator.push(context,
                              MaterialPageRoute(builder: (context) => CustomerDetails(post)));
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
          ),
        ],
      ),
    );
  }
}
