import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tailor/Components/Rounded_Button.dart';
import 'package:tailor/Constants/ConstantColors.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 70),
        color: WhiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.height * 0.4,
              width: size.width,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('photos/background/noInternet.png'))),
            ),
            Text('No Internet Connection',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Center(
                child: Text(
              'Your are not connected to the Internet. ',
              style: TextStyle(fontSize: 16),
            )),
            Center(
                child: Text(
              'Make sure your Mobile Data is on. ',
              style: TextStyle(fontSize: 16),
            )),
            Center(
                child: Text(
              'or connected to Wi-Fi. ',
              style: TextStyle(fontSize: 16),
            )),
            RoundedButton(
              text: "Go to Setting",
              press: () => null,
            ),
          ],
        ),
      ),
    );
  }
}
