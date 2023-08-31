import 'package:flutter/material.dart';

class ButtonSnap0x extends StatelessWidget {
  const ButtonSnap0x({super.key, required this.fun, required this.title});
  final Function fun;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: Colors.yellow,
      borderRadius: BorderRadius.circular(5),
      child: MaterialButton(
        onPressed: () {
          fun.call();
        },
        minWidth: double.infinity,
        height: 42,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
