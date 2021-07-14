import 'package:flutter/material.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Screens/HomePage/home.dart';

class AboutTailor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('درباره',style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Dashboard()));
            },
          ),
          elevation: 0,
          backgroundColor: PurpleColor,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: <Widget>[
                      Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        color: PurpleColor,
                        child: Image.asset('photos/background/tailor_logo.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 9.0),
                        child: Text('Tailor Studio',
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0, left: 10, right: 10),
                          child: Text(
                              'Tailor Studio is an application to manage orders, Measurements, Customers, Gallery Design and Payment System for Customers '
                                  'is an ease for tailors to avoid writing in a physical notebook that may loss one day or ruin.',
                              style: TextStyle(
                                  color: GreyColor,
                                  fontSize: 15,
                                  fontFamily: 'TimeRoman')),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 100.0),
                        child: Column(
                          children: [
                            Text('Developed by:',
                                style:
                                TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text('Mohammad Basir', style: TextStyle(fontSize: 13)),
                            ),
                            Text('© 2021', style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Text('Contact',
                                style:
                                TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            Text('Email: basirkhan.hashemi@gmail.com',
                                style: TextStyle(fontSize: 13)),
                            Text('WhatsApp: 0787130301 - 0790128308',
                                style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
