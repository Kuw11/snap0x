import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListPasswordPage extends StatelessWidget {
  const ListPasswordPage(
      {super.key, required this.passwords, required this.password});
  final List<String> passwords;
  final String password;
  @override
  Widget build(BuildContext context) {
    Fluttertoast.showToast(msg: '$password is correct ');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text("list passwords"),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Text(
            passwords[index],
            textAlign: TextAlign.center,
            style: TextStyle(
                color: passwords[index] == password ? Colors.green : Colors.red,
                fontSize: 18),
          );
        },
        itemCount: passwords.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            thickness: 1,
            indent: 10,
            endIndent: 10,
          );
        },
      ),
    );
  }
}
