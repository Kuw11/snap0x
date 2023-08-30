import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'body_dialog.dart';

class ReportUserPage extends StatefulWidget {
  const ReportUserPage({super.key});
  static BuildContext? ReportContext;
  static late ProgressDialog pr;
  @override
  _GetReportUserPage createState() => _GetReportUserPage();
}

class _GetReportUserPage extends State<ReportUserPage> {
  FocusNode focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String _emailOrUserName = '';

  @override
  Widget build(BuildContext context) {
    ReportUserPage.ReportContext = context;
    ReportUserPage.pr = ProgressDialog(
      context,
      type: ProgressDialogType.normal,
      textDirection: TextDirection.ltr,
      isDismissible: false,
    );
    ReportUserPage.pr.style(
      message: 'جاري تكوين الخادم',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      progressWidgetAlignment: Alignment.center,
      maxProgress: 10,
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
                                return "Type Your Username Snapchat";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) => _emailOrUserName = value!,
                            decoration: const InputDecoration(
                              labelText: 'Username Snapchat',
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
                    // ReportUserPage.pr.show();

                    AwesomeDialog(
                        dialogType: DialogType.noHeader,
                        dismissOnBackKeyPress: false,
                        onDismissCallback: (type) {},
                        autoDismiss: false,
                        btnCancelOnPress: () {
                          stopRepo = true;
                          Navigator.pop(context);
                        },
                        context: context,
                        body: BoodyDialog(
                          userName: _emailOrUserName,
                        )).show();
                  }
                },
                minWidth: 200,
                height: 42,
                child: const Text(
                  'Run',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
              const SizedBox(height: 20),
              const Text(" Send the report continuously and randomly to the user \n  Enter the username and view the report",
              style: TextStyle(
                fontSize: 13,
                color: Colors.black,
                ),
                textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
