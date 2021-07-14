import 'package:flutter/material.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';
import 'package:tailor/HttpServices/HTTP.dart';
import 'package:tailor/wait.dart';
class Orders extends StatelessWidget {
  final HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
     body: FutureBuilder(
       future: httpService.getPosts(),
         builder: (BuildContext context, AsyncSnapshot snapshot) {
           if (snapshot.hasData) {
             List<Customer> posts = snapshot.data;
              return ListView(
                children: posts.map((Customer post) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(post.firstName),
                    subtitle: Text(post.lastName),
                    //tileColor: Colors.lightBlueAccent,
                  ),
                ))
                    .toList(),
              );
           } else if (snapshot.hasError) {
             return Container(
                   child: Text(snapshot.error),
             );
           } else {
              return Container(
                 child: LoadingCircle(),
              );
           }
         }
     ),
    );
  }
}