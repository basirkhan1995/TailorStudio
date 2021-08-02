import 'package:flutter/material.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';
import 'package:tailor/Screens/Individuals/Base_Details.dart';


class CustomerDetails extends StatelessWidget {
  final Customer post;
  CustomerDetails(this.post);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Env.appBar(context, post.firstName + " " + post.lastName),
        body: BaseDetails(post)
    );
  }
}


