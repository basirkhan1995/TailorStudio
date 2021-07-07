import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Components/Already_have_account.dart';
import 'package:tailor/Components/PasswordField.dart';
import 'package:tailor/Components/Rounded_Button.dart';
import 'package:tailor/Components/Rounded_Input_Field.dart';
import 'package:tailor/Constants/ConstantColors.dart';
import 'package:tailor/Constants/Methods.dart';
import 'package:tailor/Screens/HomePage/HomePage.dart';
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

  bool loading = false;
  SharedPreferences loginData;
  bool isLogin = true;

  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  void initState() {
    super.initState();
    checkIfUserIsLogin();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading ?  LoadingCircle() : Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(
                  "خــــوش آمــــدید",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: PurpleColor),
                ),
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
                onChanged: (value){
                },
                hintText: 'رمز عبور',
              ),
              Padding(
                padding: const EdgeInsets.only(right: 180),
                child: Text('بازیابی رمز عبور؟',
                    style: TextStyle(
                        color: PurpleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
              ),
              RoundedButton(
                text: "ورود",
                press: () async {
                  if (_formKey.currentState.validate()) {
                     var networkResult = await Connectivity().checkConnectivity();
                    if (networkResult == ConnectivityResult.none) {
                    return Env.errorDialog(Env.internetTitle, Env.noInternetMessage, DialogType.ERROR, context, () { });
                      }
                    setState(() {
                      loading = true;
                    });
                    http.Response res =
                        await http.post(Uri.parse(Env.url + "login.php"),
                            body: jsonEncode({
                              "usrName": username.text,
                              "usrPass": password.text,
                            }));
                    var jsonData = jsonDecode(res.body);
                    int result = int.parse(jsonData['usrID']);
                    print(jsonData);
                    if (result > 0) {
                      loginData.setBool('login', true);
                      loginData.setString('username', username.text);
                      loginData.setString('tName', jsonData['tlrName']);
                     // loginData.setString('tEmail', jsonData['tlrEmail']);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    } else {
                      setState(() => loading = false);
                      Env.errorDialog(
                          Env.errorTitle,
                          Env.wrongInput,
                          DialogType.ERROR,
                          context,
                              () => {});
                      //Env.aDialog(context, Env.errorTitle, Env.wrongInput);
                    }
                  } else {
                    Env.errorDialog('تـــــوجه', "لطفا حساب کاربری و پســـورد خود را وارید نمایید", DialogType.WARNING, context, () { });
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Remember login
  void checkIfUserIsLogin() async {
    loginData = await SharedPreferences.getInstance();
    isLogin = (loginData.getBool('login') ?? false);
    if (isLogin == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
     }
  }

}