import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:some_name/screens/Login_screen.dart';
import 'package:some_name/screens/files_page.dart';
import 'package:some_name/screens/files_upload.dart';
import 'package:some_name/screens/get_friends.dart';
import 'package:some_name/screens/login.dart';
import 'package:some_name/screens/phone_screen.dart';
import 'package:some_name/screens/send_report.dart';
import 'package:some_name/services/api_service.dart';
import 'package:some_name/services/appUtils.dart';

class RunScreen extends StatefulWidget {
  final TextEditingController keyController = TextEditingController();

  @override
  State<RunScreen> createState() => _RunScreenState();
}

class _RunScreenState extends State<RunScreen> {
  late ProgressDialog pr;
  PopupMenuItem<String> _buildMenuItem(String index, String value) {
    return PopupMenuItem<String>(
      value: index,
      child: Text(
        value,
      ),
    );
  }

  bool isLoading = false;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.normal,
      textDirection: TextDirection.ltr,
      isDismissible: true,
    );
    pr.style(
      message: 'جاري جلب الملفات',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SafeArea(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      height: 120,
                      child: Image.asset("images/snapcht_logo.png"),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const Center(
                    child: Text(
                      "welcome to Snap0x",
                      style: TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Material(
                    elevation: 5,
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Scaffold(body: Login())));
                      },
                      minWidth: double.infinity,
                      height: 42,
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                          : const Text(
                              'تخمين على الحسابات',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Material(
                    elevation: 5,
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Scaffold(body: phone())));
                      },
                      minWidth: double.infinity,
                      height: 42,
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                          : const Text(
                              'استعلام عن رقم هاتف',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Material(
                    elevation: 5,
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Scaffold(body: ReportUserPage())));
                      },
                      minWidth: double.infinity,
                      height: 42,
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                          : const Text(
                              'بلاغات على الحسابات',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Material(
                    elevation: 5,
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const GetFriendsScreen()));
                      },
                      minWidth: double.infinity,
                      height: 42,
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                          : const Text(
                              'سحب المتابعين و المضافين',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      height: 200,
                      child: Image.asset("images/snapchat.png"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "1.0.5 | 0xfff0800 \n \nLook at our available services, choose from the list and enjoy",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Material(
                    elevation: 5,
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    child: MaterialButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FilesUploadPage(),
                          ),
                        );
                      },
                      minWidth: double.maxFinite,
                      height: 42,
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'ادارة الملفات',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Material(
                    elevation: 5,
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    child: MaterialButton(
                      onPressed: () async {
                        await ApiService.auth.signOut();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                          (route) => false,
                        );
                      },
                      minWidth: double.maxFinite,
                      height: 42,
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'خروج',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
