import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ConstantColors.dart';
import 'Methods.dart';

class OrderDetails extends StatelessWidget {
  final String title;
  final String subtitle;
  final press;
  final Widget widget;

  final String qty;
  final String collar;
  final String design;
  final String sleeve;
  final String type;
  final String textTile;
  final String date;
  final String status;
  final String remarks;
  final String price;
  final String advance;
  final String totalBalance;
  const OrderDetails({
    Key key,
    this.title="",
    this.subtitle="",
    this.press,
    this.widget,
    this.collar,
    this.design,
    this.sleeve,
    this.type,
    this.textTile,
    this.date,
    this.status,
    this.remarks,
    this.price,
    this.qty,
    this.advance,
    this.totalBalance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: [
        //Custom AppBar
        Padding(
          padding: const EdgeInsets.only(top:15),
          child: ListTile(
            leading: IconButton(icon: Icon(Icons.arrow_back_ios,size: 15,color:WhiteColor),onPressed: ()=> Navigator.pop(context),),
            title: Text(title??"",style: TextStyle(fontSize: 22,color: WhiteColor)),
            subtitle: Text(subtitle??"",style: TextStyle(fontSize: 18,color: WhiteColor)),
          ),
        ),
    Column(
    children: [
    Padding(
      padding: const EdgeInsets.only(top: 26),
      child: Container(
        child: ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            Padding(
              padding: const EdgeInsets.only(top:11.0),
              child: ListTile(
                title: Text("Order Details",style: TextStyle(fontSize: 22,color: PurpleColor),),
                trailing: IconButton(icon: Icon(Icons.edit),onPressed: ()=>press()),
                visualDensity: VisualDensity(
                  vertical: -4
                ),
              ),
            ),
            Divider(endIndent: 39, indent: 30),
            ///Orders to be listed here
            Env.order("QTY", qty??""),
            Env.order("Collar", collar??""),
            Env.order("Design", design??""),
            Env.order("Sleeve", sleeve??""),
            Env.order("Order Type", type??""),
            Env.order("Total TextTile", textTile??""),
            Env.order("Date", date??""),
            Env.order("Status", status??""),
            Env.order("Remarks", remarks??""),
            Divider(endIndent: 39, indent: 30),
            Env.order("Price", price??""),
            Env.order("Advance", advance??""),
            Divider(endIndent: 39, indent: 30),
            Env.order("Total Balance", totalBalance??""),
          ],
        ),
      height: size.height * .77,
        width: size.width * .9,
        decoration: BoxDecoration(
          color: WhiteColor,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: GreyColor.withOpacity(.04),
              offset: Offset(1,1), //(x,y)
              blurRadius: 5.0,
            ),
          ],
        ),

      ),
    ),
    ],
    ),
      ],
    );
  }
}

