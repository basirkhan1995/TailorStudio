import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:tailor/Components/Already_have_account.dart';
import 'package:tailor/Components/PasswordField.dart';
import 'package:tailor/Components/Rounded_Button.dart';
import 'package:tailor/Components/Rounded_Input_Field.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/Screens/HomePage/Home.dart';
import 'package:tailor/Screens/SignUp/signup.dart';
import 'package:http/http.dart' as http;
import 'package:tailor/wait.dart';
import 'background.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool loading = false;

  @override
  void initState() {
    Env.checkIfUserIsLogin(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _w = MediaQuery.of(context).size.width;
    return Env.loader
        ? LoadingCircle()
        : Background(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Text(" ورود به سیستم",
                          style: PersianFonts.Samim.copyWith(
                            fontSize: _w / 15,
                            letterSpacing: 1,
                            wordSpacing: 1,
                            color: PurpleColor,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    Image.asset(
                      "photos/background/tailor_logo2.png",
                      height: size.height * 0.35,
                    ),
                    RoundedInputField(
                      controller: username,
                      hintText: "نام کاربری",
                      icon: Icons.account_circle,
                      message: 'لطفا حساب کاربری خود را وارد نمایید',
                      onChanged: (value) {},
                    ),
                    PasswordInputField(
                      icon: Icons.lock_rounded,
                      message: 'لطفا رمز عبور خود را وارید نمایید',
                      controller: password,
                      prefix: Icons.lock_rounded,
                      onChanged: (value) {},
                      hintText: 'رمز عبور',
                    ),

                    //Forgot Password, "Password Recovery"
                    Padding(
                      padding: const EdgeInsets.only(right: 180, top: 10, bottom: 10),
                      child: Text('Forgot password?',
                          style: Env.boldStyle(13, PurpleColor)),
                    ),

                    //Login Button
                    RoundedButton(
                      text: "ورود",
                      press: () async {
                        //Checking the text fields whether they are empty or not.
                        if (_formKey.currentState.validate()) {
                          // loading starts
                          setState(() {
                            Env.loader = true;
                          });

                          //Internet connectivity check
                          Env.checkConnection(context,setState);

                          //Checking login username and password
                          http.Response res = await http.post(Uri.parse(Env.url + "login.php"),
                              body: jsonEncode({
                                "userName": username.text,
                                "password": password.text,
                              }));
                          var jsonData = jsonDecode(res.body);
                          int result = int.parse(jsonData['userID']);
                          print(jsonData);
                          if (result > 0) {

                            //loading stops when user login successfully
                            setState(() {
                              Env.loader = false;
                            });

                            // Values saved in shared preferences, after successfully login
                            Env.loginData.setBool('login', true);
                            Env.loginData.setString('username', username.text);
                            Env.loginData.setString('userID', jsonData['userID']);
                            Env.loginData.setString('tailorName', jsonData['tailorName']);
                            Env.loginData.setString('studioName', jsonData['studioName']);
                            Env.loginData.setString('userEmail', jsonData['userEmail']);
                            Env.loginData.setString('userPhone', jsonData['userPhone']);
                            Env.loginData.setString('userAddress', jsonData['userAddress']);
                            Env.loginData.setString('fileName', jsonData['fileName']);
                            Env.animatedGoto(Dashboard(), context);
                          } else {
                            // If login fails; loading stops and system await for Error Dialog to open.
                            setState(() {
                              Env.loader = false;
                            });

                            //Error Dialog
                            await Env.errorDialog(Env.errorTitle, Env.wrongInput, DialogType.ERROR, context, () => {});
                          }
                        }
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    //If you don't have an account, create one here. (Sign up)
                    AlreadyHaveAnAccountCheck(
                      press: () {
                        // Navigate to Sign up screen
                       Env.animatedGoto(SignUpScreen(), context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
