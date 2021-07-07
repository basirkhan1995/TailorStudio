import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity/connectivity.dart';
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
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool loading = false;

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
              Text(
                "حســـاب جـــدید",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: PurpleColor),
              ),
              Image.asset(
                "photos/background/tailor_logo2.png",
                height: size.height * 0.22,
              ),

              //Input TextFields
              RoundedInputField(
                controller: tailorName,
                hintText: "اســـم خیـــاطی",
                message: "لطفا اسم خیاطی خود را وارید نمایید",
                icon: Icons.person_rounded,
                onChanged: (value) {},
              ),
              RoundedInputField(
                controller: username,
                icon: Icons.account_circle,
                hintText: "حســـاب کاربری",
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
              //CheckBox Buttons
              Row(
              crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  SizedBox(width: 10),
            ]),
             //Sign up Button
              RoundedButton(
                text: "ایجــــاد حساب",
                press: () async{
                  if (_formKey.currentState.validate()) {
                    var networkResult = await Connectivity().checkConnectivity();
                    if (networkResult == ConnectivityResult.none) {
                      return Env.errorDialog(Env.internetTitle, Env.noInternetMessage, DialogType.ERROR, context, () { });
                    }
                    setState(() {
                      loading = true;
                    });
                    http.Response res =
                        await http.post(Uri.parse("https://tailorstudio.000webhostapp.com/register.php"),
                        body: jsonEncode({
                          "tlrName": tailorName.text,
                          "usrName": username.text,
                          "usrPass": password.text,
                        }));
                    String result = res.body.toString();
                    print(res.body);
                    if (result == "Exists") {
                      Env.errorDialog(
                         Env.errorTitle,Env.userExistsMessage,
                          DialogType.ERROR, context, () { });
                    } else {
                    await Env.responseDialog(
                          Env.successTitle,Env.successMessage,
                           DialogType.SUCCES, context, () { });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    }
                  }else{
                    return Env.errorDialog('تــــــوجه', Env.inputError, DialogType.WARNING, context, () { });
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),

              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
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

}
