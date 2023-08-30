import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:some_name/model/friend.dart';
import 'package:some_name/services/api_service.dart';
import 'package:some_name/services/appUtils.dart';

class ShowFriendsPage extends StatefulWidget {
  ShowFriendsPage(
      {super.key,
      required this.friends,
      required this.userName,
      this.upload = true});
  final List<Friend> friends;
  final String userName;
  bool upload;

  @override
  State<ShowFriendsPage> createState() => _ShowFriendsPageState();
}

class _ShowFriendsPageState extends State<ShowFriendsPage> {
  late ProgressDialog pr;
  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.normal,
      textDirection: TextDirection.ltr,
      isDismissible: true,
    );
    pr.style(
      message: 'جاري تحميل الملف',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressWidgetAlignment: Alignment.center,
      progressTextStyle: const TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: const TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w400),
    );
    var myStyle = const TextStyle(fontSize: 15);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text("friends", style: TextStyle(color: Colors.black)),
        actions: [
          if (widget.upload)
            IconButton(
              onPressed: () async {
                pr.show();
                List<Map<String, dynamic>> jsonData =
                    widget.friends.map((obj) => obj.toJson()).toList();
                final result = await ApiService.uploadMapAsJsonToStorage(
                    jsonData, widget.userName);
                pr.hide();
                if (result) {
                  Messages.showSuccessfulMessage(
                      context, 'upload file', 'done upload file');
                  setState(() {
                    widget.upload = false;
                  });
                } else {
                  Messages.showErrorMessage(
                      context, 'upload file', 'error during upload file');
                }
              },
              icon: const Icon(Icons.upload_file_rounded),
              color: Colors.black,
            )
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                    child: Image.asset("images/snapcht_logo.png"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'اليوزر =>',
                        style: myStyle,
                      ),
                      Text(
                        widget.friends[index].userName,
                        style: myStyle,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'الاسم =>',
                        style: myStyle,
                      ),
                      Text(
                        widget.friends[index].name,
                        style: myStyle,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('وقت الاضافة =>', style: myStyle),
                      Text(
                        widget.friends[index].addFriendTime,
                        style: myStyle,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'تم تغيير الاسم =>',
                        style: myStyle,
                      ),
                      Text(
                        widget.friends[index].changedName ?? '',
                        style: myStyle,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'تم تغيير اليورز =>',
                        style: myStyle,
                      ),
                      Text(
                        widget.friends[index].changedUserName ?? '',
                        style: myStyle,
                      )
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: widget.friends.length),
    );
  }
}
