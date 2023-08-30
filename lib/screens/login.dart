import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:some_name/screens/lock_screen.dart';
import 'package:some_name/screens/register.dart';
import 'package:some_name/screens/reset_password.dart';
import 'package:some_name/services/api_service.dart';
import 'package:some_name/services/appUtils.dart';

class LoginPage extends StatefulWidget {
  static BuildContext? buildContext;
  @override
  _GetLoginPageState createState() => _GetLoginPageState();
}

class _GetLoginPageState extends State<LoginPage> {
  FocusNode focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String _emailOrUserName = '';
  String _password = '';
  late ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    LoginPage.buildContext = context;
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.normal,
      textDirection: TextDirection.ltr,
      isDismissible: true,
    );
    pr.style(
      message: 'جاري تسجيل الدخول',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressWidgetAlignment: Alignment.center,
      progressTextStyle: const TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: const TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: Image.asset("images/snapcht_logo.png"),
                  ),
                  const Text(
                    "Snap0x ios",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Material(
                          elevation: 5,
                          color: Colors.yellow,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Type your   email";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) => _emailOrUserName = value!,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 11.0, horizontal: 10.0),
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Material(
                          elevation: 5,
                          color: Colors.yellow,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "type your password";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) => _password = value!,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'password',
                              labelStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 11.0, horizontal: 10.0),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () async {},
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: MaterialButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    pr.show();

                    final result =
                        await ApiService.loginUser(_emailOrUserName, _password);
                    pr.hide();
                    if (result.status) {
                      Navigator.pushAndRemoveUntil(
                        LoginPage.buildContext!,
                        MaterialPageRoute(
                          builder: (context) => LockScreen(),
                        ),
                        (route) => false,
                      );
                    } else {
                      Messages.showErrorMessage(
                          LoginPage.buildContext!, 'Error', result.message);
                    }
                  }
                },
                minWidth: 200,
                height: 42,
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        LoginPage.buildContext!,
                        MaterialPageRoute(
                          builder: (context) => ResetPasswordPagePage(),
                        ),
                      );
                    },
                    child: const Text('Reset password')),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        LoginPage.buildContext!,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    },
                    child: const Text('Register Now'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
