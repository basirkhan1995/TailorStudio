import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tailor/Components/Button.dart';
import 'package:tailor/Components/RoundedBorderedField.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/HttpServices/IndividualsModel.dart';
import 'package:http/http.dart' as http;

class CustomerMeasure extends StatelessWidget {
  final Customer post;
  CustomerMeasure(this.post);

  final TextEditingController newValue = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
          child: ListView(
        children: [
          SizedBox(height: 10),
          Env.customTile('شانه', post.shoulder ?? '',
              'compliant.png',() => _updateData(context, post.shoulder, 1), context),
          Env.customTile('یخن', post.collar ?? '',
              'compliant.png',() => _updateData(context, post.collar, 2), context),
          Env.customTile('آستین', post.sleeve ?? '',
              'compliant.png',() => _updateData(context, post.sleeve, 3), context),
          Env.customTile('بغل', post.waist ?? '',
              'compliant.png', () => _updateData(context, post.waist, 4), context),
          Env.customTile('قد', post.height ?? '',
              'compliant.png', () => _updateData(context, post.height, 5), context),
          Env.customTile('دامن', post.skirt ?? '',
              'compliant.png', () => _updateData(context, post.skirt, 6), context),
          Env.customTile('قد تنبان', post.pantHeight ?? '',
              'compliant.png',() => _updateData(context, post.pantHeight, 7), context),
          Env.customTile('پاچه', post.legWidth ?? '',
              'compliant.png', () => _updateData(context, post.legWidth, 8), context),
          SizedBox(height: 10),
        ],
      )),
    );
  }

  _updateData(context, value, int fieldNo) {
    value == null ? newValue.text = "N/A" : newValue.text = value;
    var myData;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: WhiteColor,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Do you want update ' + newValue.text + "?",
                        style: Env.style(16, PurpleColor)),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      children: [
                        RoundedBorderedField(
                            inputType: TextInputType.number,
                            hintText: '',
                            controller: newValue,
                            icon: Icons.info_outline),
                        SizedBox(height: 10),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Button(
                                text: 'Save',
                                textColor: PurpleColor,
                                paint: WhiteColor,
                                press: () async {
                                  switch (fieldNo) {
                                    case 1:
                                      myData = {
                                        "shoulder": newValue.text,
                                        "collar": post.collar,
                                        "sleeve": post.sleeve,
                                        "waist": post.waist,
                                        "height": post.height,
                                        "skirt": post.skirt,
                                        "pantHeight": post.pantHeight,
                                        "legWidth": post.legWidth,
                                        "measureID": post.measureId
                                      };
                                      break;
                                    case 2:
                                      myData = {
                                        "shoulder": post.shoulder,
                                        "collar": newValue.text,
                                        "sleeve": post.sleeve,
                                        "waist": post.waist,
                                        "height": post.height,
                                        "skirt": post.skirt,
                                        "pantHeight": post.pantHeight,
                                        "legWidth": post.legWidth,
                                        "measureID": post.measureId
                                      };
                                      break;
                                    case 3:
                                      myData = {
                                        "shoulder": post.shoulder,
                                        "collar": post.collar,
                                        "sleeve": newValue.text,
                                        "waist": post.waist,
                                        "height": post.height,
                                        "skirt": post.skirt,
                                        "pantHeight": post.pantHeight,
                                        "legWidth": post.legWidth,
                                        "measureID": post.measureId
                                      };
                                      break;
                                    case 4:
                                      myData = {
                                        "shoulder": post.shoulder,
                                        "collar": post.collar,
                                        "sleeve": post.sleeve,
                                        "waist": newValue.text,
                                        "height": post.height,
                                        "skirt": post.skirt,
                                        "pantHeight": post.pantHeight,
                                        "legWidth": post.legWidth,
                                        "measureID": post.measureId
                                      };
                                      break;
                                    case 5:
                                      myData = {
                                        "shoulder": post.shoulder,
                                        "collar": post.collar,
                                        "sleeve": post.sleeve,
                                        "waist": post.waist,
                                        "height": newValue.text,
                                        "skirt": post.skirt,
                                        "pantHeight": post.pantHeight,
                                        "legWidth": post.legWidth,
                                        "measureID": post.measureId
                                      };
                                      break;
                                    case 6:
                                      myData = {
                                        "shoulder": post.shoulder,
                                        "collar": post.collar,
                                        "sleeve": post.sleeve,
                                        "waist": post.waist,
                                        "height": post.height,
                                        "skirt": newValue.text,
                                        "pantHeight": post.pantHeight,
                                        "legWidth": post.legWidth,
                                        "measureID": post.measureId
                                      };
                                      break;
                                    case 7:
                                      myData = {
                                        "shoulder": post.shoulder,
                                        "collar": post.collar,
                                        "sleeve": post.sleeve,
                                        "waist": post.waist,
                                        "height": post.height,
                                        "skirt": post.skirt,
                                        "pantHeight": newValue.text,
                                        "legWidth": post.legWidth,
                                        "measureID": post.measureId
                                      };
                                      break;
                                    case 8:
                                      myData = {
                                        "shoulder": post.shoulder,
                                        "collar": post.collar,
                                        "sleeve": post.sleeve,
                                        "waist": post.waist,
                                        "height": post.height,
                                        "skirt": post.skirt,
                                        "pantHeight": post.pantHeight,
                                        "legWidth": newValue.text,
                                        "measureID": post.measureId
                                      };
                                      break;
                                    default:
                                      myData = {
                                        "shoulder": post.shoulder,
                                        "collar": post.collar,
                                        "sleeve": post.sleeve,
                                        "waist": post.waist,
                                        "height": post.height,
                                        "skirt": post.skirt,
                                        "pantHeight": post.pantHeight,
                                        "legWidth": post.legWidth,
                                        "measureID": post.measureId
                                      };
                                  }
                                  http.Response res = await http.post(
                                      Uri.parse(Env.url + "measureUpdate.php"),
                                      body: jsonEncode(myData));
                                  String result = res.body.toString();
                                  if (result == "Success") {
                                    print("Update Success" + result);
                                    await Env.responseDialog(
                                        Env.successTitle,
                                        'موفقانه آپدیت شد!',
                                        DialogType.SUCCES,
                                        context,
                                        () {});
                                    Navigator.pop(context);
                                  } else if (result == "Failed") {
                                    await Env.errorDialog(
                                        Env.successTitle,
                                        'خطا در آپدیت',
                                        DialogType.ERROR,
                                        context,
                                        () {});
                                  }
                                },
                              ),
                              Button(
                                text: 'Cancel',
                                textColor: PurpleColor,
                                paint: WhiteColor,
                                press: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ]),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ));
  }
}
