import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/HttpServices.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';
import 'package:tailor/Screens/Individuals/CustomerDetails.dart';
import 'package:tailor/Screens/NewClient/New_Client_Form.dart';
import 'package:tailor/Screens/Orders/CreateOrder.dart';
import 'package:tailor/controller/test_controller.dart';
import '../../wait.dart';


class Individual extends StatefulWidget {
  @override
  _IndividualState createState() => _IndividualState();
}
class _IndividualState extends State<Individual> {

  ScrollController _scrollController;
  bool showFab = true;
  SharedPreferences loginData;
  String user = "";
  final access = CharacterApi();
  final controller = TestController();
  bool loading = false;
  bool refresh = false;
  @override
  void initState() {
    super.initState();
    initial();
    _scrollController = ScrollController();
    access.fetchCustomer(user, context);
    //controller.getData(user);
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      user = loginData.getString('userID');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      floatingActionButton: showFab ? FloatingActionButton(
        backgroundColor: PurpleColor,
        child: Icon(Icons.add),
        onPressed:(){
          Env.animatedGoto(NewClient(), context);
          if (_scrollController.hasClients) {
            final maxScroll = _scrollController.position.maxScrollExtent;
            final currentScroll = _scrollController.offset;
            return currentScroll >= (maxScroll * 0.9);
          }
          //_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        },
      ):null,
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: RefreshIndicator(
              color: PurpleColor,
              strokeWidth: 3,
              onRefresh: () {
                return Future.delayed(
                  Duration(microseconds: 1),() {
                  setState(() {
                    //controller.getData(user);
                    access.fetchCustomer(user,context);
                  });
                },
                );
              },
              child: FutureBuilder(
                future: access.fetchCustomer(user,context),
                //controller.getData(user),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Customer>> snapshot) {
                  if (!snapshot.hasData){
                    return LoadingCircle();
                  }else if(snapshot.hasData && snapshot.data.isEmpty){
                    return Env.emptyBox();
                  }else {
                    List<Customer> posts = snapshot.data;
                    return NotificationListener<UserScrollNotification>(
                      onNotification: (notification){
                        setState(() {
                          if(notification.direction == ScrollDirection.forward){
                            showFab = true;
                          }else if(notification.direction == ScrollDirection.reverse){
                            showFab = false;
                          }
                        });
                        return true;
                      },
                      child: ListView(
                        controller: _scrollController,
                        children: posts.map((Customer post) => Padding(
                          padding: const EdgeInsets.only(top: 8,left: 15,right: 15),
                          child: Container(
                            padding: EdgeInsets.only(right: 0, left: 10),
                            decoration: BoxDecoration(
                              color: WhiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: GreyColor.withOpacity(.24),
                                  offset: Offset(1,1), //(x,y)
                                  blurRadius: 2.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: post.fileName == null ?
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: Env.noUser(),
                              ):
                              Env.image(post.fileName??"no_user.jpg",30),
                              title: Text(post.firstName + " " + post.lastName??"",
                                  style: TextStyle(fontWeight: FontWeight.w400, color: GreyColor)),
                              subtitle: Text(
                                  post.phone??"", style: TextStyle(fontSize: 12)),
                              trailing: PopupMenuButton(
                                icon: Icon(Icons.more_vert, color: PurpleColor),
                                elevation: 20,
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                      child: InkWell(
                                        onTap: (){
                                          Env.animatedGoto(NewOrder(post), context);
                                        },
                                        child: Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('فرمایش جدید'),
                                            Spacer(),
                                            Icon(Icons.shopping_cart,color: PurpleColor),
                                            Divider(height: 1),
                                          ],
                                        ),
                                      )),
                                  PopupMenuItem(
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerDetails(post)));
                                        },
                                        child: Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('اصلاح کردن'),
                                            Icon(Icons.edit,color: PurpleColor)
                                          ],
                                        ),
                                      )),
                                  PopupMenuItem(
                                      child: InkWell(
                                        child: Row(
                                          children: [
                                            InkWell(
                                              child: Text('حذف کردن',style: Env.style(16, Colors.red.shade900)),
                                            ),
                                            Spacer(),
                                            Icon(Icons.delete,color:Colors.red.shade900)],
                                        ),
                                        onTap: ()async{
                                          Env.deleteYesNo = false;
                                          await Env.confirmDelete('Delete', 'آیا میخواهید این مشتری را حذف کنید؟', DialogType.QUESTION, context, setState);
                                          if(Env.deleteYesNo == true){
                                            print("result = " + Env.deleteYesNo.toString());
                                            access.deleteCustomer(post.customerId,context);
                                            Navigator.pop(context);
                                          }else{
                                            print("result = "+ Env.deleteYesNo.toString());
                                            Navigator.pop(context);
                                          }
                                        },
                                      )),
                                ],
                              ),
                              //Individuals Details
                              onTap: () {Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => CustomerDetails(post)));
                              },
                            ),
                          ),
                        ))
                            .toList(),
                      ),
                    );
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