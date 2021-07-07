import 'package:flutter/material.dart';
import 'package:tailor/Components/Rounded_Input_Field.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/HttpServices/HTTP.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';

class Individual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpService httpService = HttpService();
    return Column(
      children: [
        RoundedInputField(
          icon: Icons.search,
          hintText: 'جستجو',
        ),
        Expanded(
          child: FutureBuilder(
            future: httpService.getPosts(),
            builder: (BuildContext context, AsyncSnapshot<List<Individuals>> snapshot){
              if(snapshot.hasData){
                List<Individuals> posts = snapshot.data;
                return ListView(
                  children: posts.map((Individuals post) => Padding(
                    padding: const EdgeInsets.only(top: 1,),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 0, left: 0),
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: LightColor,
                              foregroundColor: GreyColor,
                              child: Text(post.indId,
                                  style: TextStyle(fontSize: 14))),
                          title: Text(post.indFirstName + " " + post.indLastName, style: TextStyle(fontWeight: FontWeight.bold,color: GreyColor)),
                          subtitle: Text(post.indEmail,style: TextStyle(fontSize: 12)),
                          trailing: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: PopupMenuButton(
                              icon: Icon(Icons.more_vert,color:PurpleColor),
                              elevation: 20,
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: PurpleColor,
                                      width: 2
                                  )
                              ),
                              itemBuilder: (context) => [

                                PopupMenuItem(
                                  value: 1,
                                  child: Text("Create New Order",style: TextStyle(color: GreyColor)),
                                ),

                                PopupMenuItem(
                                  value: 2,
                                  child: Text("Edit",style: TextStyle(color: GreyColor)),
                                ),
                                PopupMenuItem(
                                  value: 3,
                                  child: Text("Delete",style: TextStyle(color: Colors.red)),
                                ),

                              ],
                              onSelected: (item) => {print(item)},
                            ),
                          ),


                        ),
                      ),
                    ),
                  ))
                      .toList(),
                );
              }else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}