import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'run.screen.dart';
import 'package:some_name/screens/help_screen.dart';

class LockScreen extends StatefulWidget {
  final TextEditingController keyController = TextEditingController();

  LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  bool isLoading = false;
  var formKey = GlobalKey<FormState>();
  Future<bool> validateSerialNumber({
    required String serialKey,
  }) async {
    setState(() {
      isLoading = true;
    });
    final url =
        'https://bye-thost.com/?wc-api=serial-numbers-api&product_id=15981&serial_key=$serialKey&request=validate';

    final response = await http.get(Uri.parse(url));
    final info = json.decode(response.body);

    print(info);
    if (response.statusCode == 200 && info['success'] == true) {
      setState(() {
        isLoading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RunScreen(),
        ),
      );
      return true;
    }
    setState(() {
      isLoading = false;
    });
    Fluttertoast.showToast(msg: info['data']['message']);

    return false;
  }

  @override
  Widget build(BuildContext context) {
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
                  const Center(
                    child: Text(
                      "Snap0x ios",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Enter your Key",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Material(
                      elevation: 5,
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(5),
                      child: TextField(
                        controller: widget.keyController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'api key',
                        ),
                      ),
                    ),
                  ),
                  Material(
                    elevation: 5,
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                    child: MaterialButton(
                      onPressed: () async {
                        if (widget.keyController.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'Enter your api Key');
                          return;
                        } else {
                          validateSerialNumber(
                              serialKey: widget.keyController.text);
                        }
                      },
                      minWidth: double.infinity,
                      height: 42,
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Please enter your license key, view the help page, or contact us for support from ByE-ThoST.com",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Material(
                    elevation: 5,
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(5),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Scaffold(body: HelpScreen())));
                      },
                      minWidth: double.infinity,
                      height: 42,
                      child: 
                      const Text(
                        'Help',
                        style: TextStyle(
                          color: Colors.black,
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
