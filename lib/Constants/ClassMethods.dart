import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ConstantColors.dart';

class Tile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData trailing;
  final Widget widget;
  final voidCallback;
  final double width;
  final double height;
  const Tile({
    Key key,
    this.title="",
    this.subtitle="",
    this.trailing,
    this.widget,
    this.voidCallback,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: BlackColor.withOpacity(.06),
            borderRadius: BorderRadius.circular(40),
          ),
          child: widget),
      title: Text(title),
      subtitle: Text(title),
      trailing: Icon(trailing),
      onTap: ()=> voidCallback(),
    );
  }
}

