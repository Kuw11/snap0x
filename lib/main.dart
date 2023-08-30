import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:some_name/screens/lock_screen.dart';
import 'package:some_name/screens/login.dart';
import 'package:some_name/services/api_service.dart';
import 'package:some_name/services/appUtils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthCheckScreen(),
    );
  }
}

class AuthCheckScreen extends StatelessWidget {
  const AuthCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: ApiService.isUserAuthenticated(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          Messages.showErrorMessage(
              context, 'Error', 'Error occurred: ${snapshot.error}');
          return Text('Error occurred: ${snapshot.error}');
        } else {
          final isAuthenticated = snapshot.data ?? false;
          return isAuthenticated ? LockScreen() : LoginPage();
        }
      },
    );
  }
}
