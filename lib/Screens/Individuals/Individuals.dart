import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tailor/Components/Rounded_Input_Field.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';
import 'package:tailor/Screens/Individuals/Individual_Details.dart';
import 'package:tailor/Screens/NewClient/New_Client_Form.dart';
import 'package:tailor/Screens/Orders/CreateOrder.dart';
import '../../wait.dart';


class Individual extends StatefulWidget {

  @override
  _IndividualState createState() => _IndividualState();
}
class _IndividualState extends State<Individual> {

  Future<List<Customer>> fetchCustomer() async {
    Response res = await get(Uri.parse(Env.url + "Individuals_Select.php"));
    if (res.statusCode == 200) {
      //print(res);
      List<dynamic> body = jsonDecode(res.body);
      List<Customer> posts =
      body.map((dynamic item) => Customer.fromJson(item)).toList();
      //print(posts);
      return posts;
    } else {
      throw "Error";
    }
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Env.appBar(context,'مشتریان'),
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
            icon: Icons.search, hintText: 'جستجو',
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchCustomer(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Customer>> snapshot) {
                if (snapshot.hasData) {
                  List<Customer> posts = snapshot.data;
                  return ListView(
                    children: posts.map((Customer post) => Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[300], radius: 25,
                                  //backgroundImage: NetworkImage(""),
                                  child: Container(
                                    decoration: BoxDecoration( color: Colors.black.withOpacity(.1),
               borderRadius: BorderRadius.circular(30)), width: 150, height: 150,
               child: Icon( Icons.person_rounded, color: Colors.black.withOpacity(.5), size: 35))),
             title: Text(
             post.firstName + " " + post.lastName, style: TextStyle(fontWeight: FontWeight.bold, color: GreyColor)),
                                subtitle: Text(
                                    post.email == null ? " " : post.email,
                                    style: TextStyle(fontSize: 12)),
                                trailing: PopupMenuButton(
                                  onSelected: (int index) {
                                    if (index == 1) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NewOrder()));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NewOrder()));
                                    }
                                  },
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
                                            Text('Edit'),
                                            Icon(Icons.edit, color: PurpleColor)
                                          ],
                                        )),
                                    PopupMenuItem(
                                        value: 3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Delete',
                                              style: TextStyle(
                                                  color: Colors.red.shade900),
                                            ),
                                            Icon(Icons.delete,
                                                color: Colors.red.shade900)
                                          ],
                                        )),
                                  ],
                                ),
                                //Individuals Details
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => IndDetails()));
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

