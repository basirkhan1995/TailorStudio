import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: WhiteColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 5
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text('STATISTICS',style: Env.style(28, BlackColor.withOpacity(.5)),),
              ),
              Divider(endIndent: 30,indent: 30,height: 0,),
              Env.dashboard('photos/app_icons/user.png', 'Customers', '62', context),
              Env.dashboard('photos/app_icons/clipboard.png', 'Orders', '54', context),
              Env.dashboard('photos/app_icons/accept.png', 'Pending', '4', context),
              Env.dashboard('photos/app_icons/compliant.png', 'Complete', '12', context),
              Env.dashboard('photos/app_icons/bill2.png', 'Paid', '4200', context),
              Env.dashboard('photos/app_icons/invoice2.png', 'UnPaid', '3200', context),
              SizedBox(height: 10,)

            ],
          ),
        )
    );
  }
}
