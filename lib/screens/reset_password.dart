import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:some_name/services/api_service.dart';
import 'package:some_name/services/appUtils.dart';

class ResetPasswordPagePage extends StatefulWidget {
  static BuildContext? buildContext;
  @override
  _ResetPasswordPagePageState createState() => _ResetPasswordPagePageState();
}

class _ResetPasswordPagePageState extends State<ResetPasswordPagePage> {
  FocusNode focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String _emailOrUserName = '';
  late ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    ResetPasswordPagePage.buildContext = context;
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.normal,
      textDirection: TextDirection.ltr,
      isDismissible: true,
    );
    pr.style(
      message: 'جاري ارسال الرابط',
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
                                return "Type your email";
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

                    final result = await ApiService.resetPassword(
                      _emailOrUserName,
                    );
                    pr.hide();
                    if (result.status) {
                      Messages.showSuccessfulMessage(
                          ResetPasswordPagePage.buildContext!,
                          'Reset password',
                          result.message);
                    } else {
                      Messages.showErrorMessage(
                          ResetPasswordPagePage.buildContext!,
                          'Error',
                          result.message);
                    }
                  }
                },
                minWidth: 200,
                height: 42,
                child: const Text(
                  'Send',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
