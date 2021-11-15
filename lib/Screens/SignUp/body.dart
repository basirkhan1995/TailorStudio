import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tailor/Components/Already_have_account.dart';
import 'package:tailor/Components/PasswordField.dart';
import 'package:tailor/Components/Rounded_Button.dart';
import 'package:tailor/Components/Rounded_Input_Field.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/Screens/Login/login.dart';
import '../../wait.dart';
import 'background.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginScreen lgn = new LoginScreen();
  TextEditingController tailorName = new TextEditingController();
  TextEditingController studioName = new TextEditingController();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Env.loader
        ? LoadingCircle()
        : Background(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.symmetric(vertical: 25)),
                    Text(
                      "Sign up",
                      style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: PurpleColor),
                    ),
                    Image.asset(
                      "photos/background/tailor_logo.png",
                      height: size.height * 0.40,
                    ),

                    //Input TextFields
                    RoundedInputField(
                      controller: tailorName,
                      hintText: "اسـم خیاط",
                      message: "لطفا اسم خیاط را وارید نمایید",
                      icon: Icons.person_rounded,
                      onChanged: (value) {},
                    ),
                    RoundedInputField(
                      controller: studioName,
                      hintText: "خیاطی",
                      message: "لطفا اسم خیاطی خود را وارید نمایید",
                      icon: Icons.home,
                      onChanged: (value) {},
                    ),
                    RoundedInputField(
                      controller: username,
                      icon: Icons.account_circle,
                      hintText: "حساب کاربری",
                      message: "لطفا حساب کاربری خود را وارید نمایید",
                      onChanged: (value) {},
                    ),
                    PasswordInputField(
                      hintText: 'رمز عبور',
                      message: 'لطفا رمز عبور را وارید نمایید',
                      icon: Icons.lock_rounded,
                      controller: password,
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 10),
                    //Sign up Button
                    RoundedButton(
                      text: "ایجاد حساب",
                      press: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            Env.loader = true;
                          });
                          Env.checkConnection(context,setState);
                          http.Response res = await http.post(
                              Uri.parse(Env.url + "register.php"),
                              body: jsonEncode({
                                "tailorName": tailorName.text,
                                "studioName": studioName.text,
                                "userName": username.text,
                                "password": password.text,
                              }));
                          String result = res.body.toString();
                          print(res.body);
                          if (result == "Exists") {
                            setState(() {
                              Env.loader = false;
                            });
                            Env.errorDialog(Env.errorTitle, Env.userExistsMessage, DialogType.ERROR, context, () {});
                          } else {
                            setState(() {
                              Env.loader = false;
                            });
                            await Env.responseDialog(
                                Env.successTitle,
                                Env.successMessage,
                                DialogType.SUCCES,
                                context,
                                () {});
                            Env.goto(LoginScreen(), context);
                          }
                        }
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    AlreadyHaveAnAccountCheck(
                      login: false,
                      press: () {
                        Env.animatedGoto(LoginScreen(), context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
