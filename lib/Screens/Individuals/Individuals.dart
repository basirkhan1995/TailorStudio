import 'package:flutter/material.dart';
import 'package:tailor/Components/Rounded_Input_Field.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/HttpServices/HTTP.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';
import 'package:tailor/Screens/Individuals/Individual_Details.dart';

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
            builder: (BuildContext context,
                AsyncSnapshot<List<Individuals>> snapshot) {
              if (snapshot.hasData) {
                List<Individuals> posts = snapshot.data;
                return ListView(

                  children: posts.map((Individuals post) =>
                      Padding( padding: const EdgeInsets.only( top: 1),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                radius: 25,
                                 backgroundImage: NetworkImage(""),
                                child: Image.asset('photos/background/emptyAcc.png',color: Colors.grey[600]),
                              ),
                              title: Text(
                                  post.indFirstName + " " + post.indLastName, style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: GreyColor)),
                              subtitle: Text(post.indEmail == null ? " " : post.indEmail,
                                  style: TextStyle(fontSize: 12)),
                              trailing: PopupMenuButton(
                                onSelected: (item) => {print(item)},
                                icon: Icon(Icons.more_vert, color: PurpleColor),
                                elevation: 20,
                                shape: UnderlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: PurpleColor, width: 5)
                                ),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Create order'),
                                        Icon(Icons.shopping_cart,color: PurpleColor)
                                      ],
                                    )
                                  ),
                                  PopupMenuItem(
                                    value: 2,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Edit'),
                                        Icon(Icons.edit,color: PurpleColor)
                                      ],
                                    )
                                  ),
                                  PopupMenuItem(
                                    value: 3,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Delete',style: TextStyle(color: Colors.red.shade900),),
                                        Icon(Icons.delete,color: Colors.red.shade900)
                                      ],
                                    )
                                  ),
                                ],

                              ),

                              //Individuals Details
                              onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>IndDetails()));
                              },
                            ),
                          ))
                      .toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}
