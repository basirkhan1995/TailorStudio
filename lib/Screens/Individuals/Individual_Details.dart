import 'package:flutter/material.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:slimy_card/slimy_card.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/Screens/NewClient/New_Client_Form.dart';
 

class IndDetails extends StatefulWidget {
  @override
  _IndDetailsState createState() => _IndDetailsState();
}
class _IndDetailsState extends State<IndDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: Env.appBar(context,'معلومات مشتری'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            SlimyCard(
              topCardHeight: 180,
              width: size.width * .95,
              bottomCardHeight: 280,
              color: PurpleColor,
              topCardWidget: topCardWidget(),
              bottomCardWidget: bottomCardWidget(),
            ),
          ],
        ),
      ),
    );
  }

  // This widget will be passed as Top Card's Widget.
  Widget topCardWidget() {
    double _w = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
         Row(children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text('اسم: ',style: PersianFonts.Samim.copyWith(
             fontSize: _w /20,
             letterSpacing: 1,
             wordSpacing: 1,
             color: WhiteColor,
             fontWeight: FontWeight.w600,
         ))),
           Padding(
               padding: const EdgeInsets.only(right: 5),
               child: Text(""+ " " + " ی",style: PersianFonts.Samim.copyWith(
                 fontSize: _w /20,
                 letterSpacing: 1,
                 wordSpacing: 1,
                 color: WhiteColor,
                 fontWeight: FontWeight.w500,
               ))),

         ]),

          Row(children: [
            Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text('تماس: ',style: PersianFonts.Samim.copyWith(
                  fontSize: _w /20,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: WhiteColor,
                  fontWeight: FontWeight.w600,
                ))),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('0787130301 ',style: PersianFonts.Samim.copyWith(
                  fontSize: _w /20,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: WhiteColor,
                  fontWeight: FontWeight.w500,
                ))),
          ]),
          Row(children: [
            Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text('ایمل: ',style: PersianFonts.Samim.copyWith(
                  fontSize: _w /20,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: WhiteColor,
                  fontWeight: FontWeight.w600,
                ))),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Jawidabedi@gmail.com ',style: PersianFonts.Samim.copyWith(
                  fontSize: _w /20,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: WhiteColor,
                  fontWeight: FontWeight.w500,
                ))),
          ]),
        ],
      ),
    );
  }

  // This widget will be passed as Bottom Card's Widget.
  Widget bottomCardWidget() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          ListTile(
            title: Text('قد اندام مشتری',style: PersianFonts.Samim.copyWith(
              fontSize: 17,
              letterSpacing: 1,
              wordSpacing: 1,
              color: WhiteColor,
              fontWeight: FontWeight.w600,
            )),
            trailing: TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NewClient()));
              },
              child: Icon(Icons.edit,color:WhiteColor),
            ),
          ),
          Divider(height: 5,thickness: 1, color: WhiteColor),
          Row(children: [
            Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text('یخن:   ',style: PersianFonts.Samim.copyWith(
                  fontSize: 17,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: WhiteColor,
                  fontWeight: FontWeight.w600,
                ))),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('  25 ',style: PersianFonts.Samim.copyWith(
                  fontSize: 17,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: WhiteColor,
                  fontWeight: FontWeight.w500,
                ))),

            Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text('     قد:        ',style: PersianFonts.Samim.copyWith(
                  fontSize: 17,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: WhiteColor,
                  fontWeight: FontWeight.w600,
                ))),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('25',style: PersianFonts.Samim.copyWith(
                  fontSize: 17,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: WhiteColor,
                  fontWeight: FontWeight.w500,
                ))),

          ]),
          Row(children: [
            Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text('شانه:   ',style: PersianFonts.Samim.copyWith(
                  fontSize: 17,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: WhiteColor,
                  fontWeight: FontWeight.w600,
                ))),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('  25 ',style: PersianFonts.Samim.copyWith(
                  fontSize: 17,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: WhiteColor,
                  fontWeight: FontWeight.w500,
                ))),

            Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text('    پاچه:       ',style: PersianFonts.Samim.copyWith(
                  fontSize: 17,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: WhiteColor,
                  fontWeight: FontWeight.w600,
                ))),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('25',style: PersianFonts.Samim.copyWith(
                  fontSize: 17,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: WhiteColor,
                  fontWeight: FontWeight.w500,
                ))),

          ]),
          Row(children: [
            Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text('آستین:  ',style: PersianFonts.Samim.copyWith(
                  fontSize: 17,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: WhiteColor,
                  fontWeight: FontWeight.w600,
                ))),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(' 25 ',style: PersianFonts.Samim.copyWith(
                  fontSize: 17,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: WhiteColor,
                  fontWeight: FontWeight.w500,
                ))),
            Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text('    قد تنبان:   ',style: PersianFonts.Samim.copyWith(
                  fontSize: 17,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: WhiteColor,
                  fontWeight: FontWeight.w600,
                ))),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('25',style: PersianFonts.Samim.copyWith(
                  fontSize: 17,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: WhiteColor,
                  fontWeight: FontWeight.w500,
                ))),
          ]),
          Row(children: [
            Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text('دامن:  ',style: PersianFonts.Samim.copyWith(
                  fontSize: 17,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: WhiteColor,
                  fontWeight: FontWeight.w600,
                ))),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('  25 ',style: PersianFonts.Samim.copyWith(
                  fontSize: 17,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: WhiteColor,
                  fontWeight: FontWeight.w500,
                ))),
            Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text('     بغل:       ',style: PersianFonts.Samim.copyWith(
                  fontSize: 17,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: WhiteColor,
                  fontWeight: FontWeight.w600,
                ))),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text( '25 ',style: PersianFonts.Samim.copyWith(
                  fontSize: 17,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  color: WhiteColor,
                  fontWeight: FontWeight.w500,
                ))),

          ]),
        ],
      ),
    );
  }

}