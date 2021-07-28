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
      appBar: Env.appBar(context, 'Customer Details'),
      body:Center(
        child: ContainedTabBarView(
          tabs: [
            Text('اندازه مشــــــتری',style: Env.style(17, PurpleColor)),
            Text('فرمایش مشتری',style: Env.style(17, PurpleColor)),
          ],
          views: [
            ListView(children: [
              Container(
                child: Column(
                  children: [
                    Text('Number   '+post.phone),
                    Text('Number   '+post.phone),
                    Text('Number   '+post.phone),
                    Text('Number   '+post.phone),
                    Text('Number   '+post.phone),
                    Text('Number   '+post.phone),
                    Text('Number   '+post.phone),
                    Text('Number   '+post.phone),
                  ],
                ),
              )
            ],),
            Container(color: Purple.withOpacity(.3))
          ],
          onChange: (index) => print(index),
        ),
      ),
    );
  }
}

class Example1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example 1'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.blue,
          width: 200,
          height: 300,
          child: ContainedTabBarView(
            tabs: [
              Text('First'),
              Text('Second'),
            ],
            views: [
              Container(color: Colors.red),
              Container(color: Colors.green)
            ],
            onChange: (index) => print(index),
          ),
        ),
      ),
    );
  }
}

class Example2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example 2'),
      ),
      body: ContainedTabBarView(
        tabs: [
          Text('First', style: TextStyle(color: Colors.black)),
          Text('Second', style: TextStyle(color: Colors.black))
        ],
        views: [
          Container(color: Colors.red),
          Container(color: Colors.green),
        ],
        onChange: (index) => print(index),
      ),
    );
  }
}
