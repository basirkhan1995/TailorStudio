import 'package:flutter/material.dart';
import 'package:tailor/Constants/ConstantColors.dart';


class AboutTailor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'About',
            style: TextStyle(fontSize: 17),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
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
                        padding: const EdgeInsets.only(top: 13.0),
                        child: Text('About Tailor Studio', style: TextStyle(
                                color: GreyColor, fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text('1.0.0', style: TextStyle(
                            fontSize: 15,color: PurpleColor)),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 10, right: 10),
                          child: Text(
                              'Tailor Studio is an application to manage orders, Measurements, Customers, Gallery Design and Payment System for Customers '
                                  'is an ease for tailors to avoid writing in a physical notebook that may loss one day or ruin.',
                              style: TextStyle(
                                  color: GreyColor,
                                  fontSize: 15)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 100.0),
                        child: Column(
                          children: [
                            Text('Developed by:',
                                style: TextStyle(
                                    color: GreyColor,fontSize: 20, fontWeight: FontWeight.bold)),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text('Mohammad Basir',
                                  style: TextStyle(color: GreyColor,fontSize: 13)),
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
                                style: TextStyle(color: GreyColor,
                                    fontSize: 20, fontWeight: FontWeight.bold)),
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
        ));
  }
}