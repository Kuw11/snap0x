import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListPasswordPage extends StatelessWidget {
  const ListPasswordPage(
      {super.key, required this.passwords, required this.password});
  final List<String> passwords;
  final String password;
  @override
  Widget build(BuildContext context) {
    Fluttertoast.showToast(msg: '$password Good Hacker');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text("Contact Data", 
        style: TextStyle(
        color: Colors.black )
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side:const BorderSide(
                color: Colors.black,
                width: 1.2
                ),
            ),
            child: SelectableText(
                "Password : " + passwords[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: passwords[index] == password ? Colors.green : Colors.red,
                    fontSize: 18,
                    height: 2,
                    ),
            
            ),
          );
        },
        itemCount: passwords.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10,);
        },
      ),
    );
  }
}
