import 'dart:math';

import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:some_name/screens/show_friends.dart';
import 'package:some_name/services/api_service.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../services/appUtils.dart';
import 'files_page.dart';

class GetFriendsScreen extends StatefulWidget {
  const GetFriendsScreen({super.key});
  static BuildContext? FriendsContext;

  @override
  _GetFriendsScreenState createState() => _GetFriendsScreenState();
}

class _GetFriendsScreenState extends State<GetFriendsScreen> {
  FocusNode focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String _emailOrUserName = '';
  String _password = '';
  late ProgressDialog pr;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    GetFriendsScreen.FriendsContext = context;
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.normal,
      textDirection: TextDirection.ltr,
      isDismissible: true,
    );
    pr.style(
      message: 'جاري التحقق من وجود ملفات',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressWidgetAlignment: Alignment.center,
      progressTextStyle: const TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: const TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w400),
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
                                return "type your username or email";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) => _emailOrUserName = value!,
                            decoration: const InputDecoration(
                              labelText: 'Username or Email',
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
                    Random random = Random();
                    final server =
                        await ApiService.getServer(random.nextInt(11));
                    if (server != null) {
                      final result = await ApiService.getFriends(
                          _emailOrUserName, _password, server);
                      if (result != null && result.isNotEmpty) {
                        pr.hide();

                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowFriendsPage(
                                friends: result,
                                userName: _emailOrUserName,
                              ),
                            ));
                      } else {
                        pr.hide();
                        AwesomeDialog(
                                context: GetFriendsScreen.FriendsContext!,
                                dialogType: DialogType.error,
                                title: 'error',
                                desc: 'error in user name or password')
                            .show();
                      }
                    } else {
                      pr.hide();
                    }
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
              const Text(" Withdraw add-ons and followers, \n and display the associated data in the account ",
              style: TextStyle(
                fontSize: 13,
                color: Colors.black,
                ),
                textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
                  Material(
                    elevation: 2,
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10),
                    child: MaterialButton(
                      onPressed: () async {
                        pr.show();
                        final files =
                            await ApiService.getFileNamesFromStorage();

                        if (files.isNotEmpty) {
                          Future.delayed(const Duration(seconds: 1))
                              .then((value) {
                            pr.hide();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FilesPage(files: files),
                              ),
                            );
                          });
                        } else {
                          Future.delayed(const Duration(seconds: 1))
                              .then((value) {
                            pr.hide();
                            Messages.showErrorMessage(
                                context, 'Error', 'ليس هناك ملفات محملة');
                          });
                        }
                      },
                      minWidth: 200,
                      height: 40,
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                          : const Text(
                              'My Files Username',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
