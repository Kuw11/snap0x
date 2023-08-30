import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal:20.0,),
              child: Text(
                "Instructions",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            const Divider(

            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal:20.0,),
              child: Text(
                "1- bye-thost.com بعد شرائك المفتاح، سيتم إرسال الرمز إلى عنوان بريدك",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:70.0,vertical:20),
              child: Column(
              children: [
              SizedBox(
              height: 200,
              child: Image.asset("images/key_login.jpeg"),),
              ],
            ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal:20.0,vertical:20),
              child: Text(
                "2- استخدم رمز التنشيط للتحقق لتسجيل الدخول",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:75.0,vertical:5),
              child: Column(
              children: [
              SizedBox(
              height: 250,
              child: Image.asset("images/Login_cod.jpeg"),),
              ],
            ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal:20.0,vertical:20),
              child: Text(
                "3- يمكنك الآن استخدام التطبيق عن طريق إدخال اسم مستخدم وتحميل ملف نصي لكلمات المرور",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:75.0),
              child: Column(
              children: [
              SizedBox(
              height: 200,
              child: Image.asset("images/File_password.jpeg"),),
              ],
            ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal:20.0,vertical: 20),
              child: Text(
                "4- سيتم فحص الملف وإعطائك كلمة المرور الصحيحة",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:75.0),
              child: Column(
              children: [
              SizedBox(
              height: 150,
              child: Image.asset("images/run.jpeg"),),
              ],
            ),
            ),
            const Center(
                    child: Text(
                      "0xfff0800 إصدار التطبيق 1.0.5 تمت برمجته بواسطة",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: Colors.black),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
