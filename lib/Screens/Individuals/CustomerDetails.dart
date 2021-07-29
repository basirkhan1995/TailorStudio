import 'package:flutter/material.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';


class CustomerDetails extends StatelessWidget {
  final Customer post;
  CustomerDetails(this.post);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Env.appBar(context, 'معلومات مشتری'),
      body: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                  unselectedLabelColor: PurpleColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: PurpleColor),
                  tabs: [
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: PurpleColor, width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("APPS"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: PurpleColor, width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("MOVIES"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: PurpleColor, width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("GAMES"),
                        ),
                      ),
                    ),
                  ]),
            ),
            body: TabBarView(children: [
              Icon(Icons.apps),
              Icon(Icons.movie),
              Icon(Icons.games),
            ]),
          ))
      //Center(
        // child: ContainedTabBarView(
        //   tabs: [
        //     Text('شهرت مشتری',style: Env.style(17, PurpleColor)),
        //     Text('اندازه مشـتری',style: Env.style(17, PurpleColor)),
        //     Text('فرمایش مشتری',style: Env.style(17, PurpleColor)),
        //   ],
        //   views: <Widget> [
        //     Example1(),
        //     Example1(),
        //     Example1(),
        //
        //     // Container(color: Purple.withOpacity(.3)),
        //     // Container(
        //     //   child: Column(
        //     //     children: [
        //     //       Text('ID Number#: ' + post.customerID),
        //     //       Text('First Name: ' + post.firstName),
        //     //       Text('Last Name: ' + post.lastName),
        //     //       Text('Phone: ' + post.phone),
        //     //
        //     //     ],
        //     //   ),
        //     // ),
        //     // Container(color: Purple.withOpacity(.3))
        //   ],
        //   onChange: (index) => print(index),
        // ),
      //),
    );
  }
}

class Example1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(8.0),

        ),
      ),
    );
  }
}

