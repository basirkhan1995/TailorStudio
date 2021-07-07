import 'package:flutter/material.dart';
import 'package:tailor/Constants/ConstantColors.dart';

class Dashboard extends StatelessWidget {
  List data = [
    {
      "color": Color(0xffff6968),
      "icon": Icons.supervisor_account,
      'number': '30',
      "name": 'مشــــتری'
    },
    {
      "color": Color(0xff7a54ff),
      "icon": Icons.shopping_cart,
      'number': '19',
      "name": 'فرمــــایش'
    },
    {
      "color": Color(0xFF6F35A5),
      "icon": Icons.access_time_rounded,
      'number': '13',
      "name": 'ناتکمـــیل'
    },
    {
      "color": Color(0xffff99cc),
      "icon": Icons.check_circle,
      'number': '11',
      "name": 'تکمـــــیل'
    },
    {
      "color": Color(0xff932336),
      "icon": Icons.add_shopping_cart,
      'number': '19',
      "name": 'تسلـــــیم شده'
    },
    {
      "color": Color(0xff004d7c),
      "icon": Icons.attach_money_outlined,
      'number': '15000',
      "name": 'پرداخــــت شده'
    },
    {
      "color": Color(0xFF6F35A5),
      "icon": Icons.attach_money_outlined,
      'number': '28000',
      "name": 'مجمــــوعه'
    },
    {
      "color": Color(0xff07b8b4),
      "icon": Icons.attach_money_outlined,
      'number': '28000',
      "name": 'قابـــل پرداخت'
    },
  ];
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return GridView.builder(
      padding: EdgeInsets.all(3.0),
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Card(
                  elevation: 20,
                  color: data[index]['color'],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Icon(
                                data[index]['icon'],
                                color: WhiteColor,
                                size: 50,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(4.0),
                              child: Column(
                                children: [
                                  Text(
                                    data[index]['number'],
                                    style: TextStyle(
                                        color: WhiteColor, fontSize: 35
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              data[index]['name'],
                              style: TextStyle(
                                color: WhiteColor,
                                fontSize: 20,fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]);
      },
    );
  }

}
