import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:some_name/model/files.dart';
import 'package:some_name/model/friend.dart';
import 'package:some_name/screens/show_friends.dart';
import 'package:some_name/services/api_service.dart';
import 'package:some_name/services/appUtils.dart';

class FilesPage extends StatefulWidget {
  const FilesPage({super.key, required this.files});
  final List<FileDownload> files;
  static BuildContext? context;
  @override
  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  late ProgressDialog pr;
  @override
  Widget build(BuildContext context) {
    FilesPage.context = context;
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
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text("الملفات التي تم تحميلها",
        style: TextStyle(
        color: Colors.black )
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => ListTile(
                title: Text(
                  widget.files[index].name,
                  textAlign: TextAlign.center,
                ),
                leading: IconButton(
                    onPressed: () async {
                      if (widget.files[index].downloaded) {
                        pr.show();
                        final results = await ApiService.readLocalJsonList(
                            widget.files[index].name);
                        List<Friend> list = [];
                        for (var element in results) {
                          list.add(Friend.fromJson(element));
                        }
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowFriendsPage(
                                      friends: list,
                                      userName: '_emailOrUserName',
                                      upload: false,
                                    )));
                      } else {
                        pr.show();
                        final result = await ApiService.downloadFileFromStorage(
                            widget.files[index].name);
                        pr.hide();
                        if (result) {
                          Messages.showSuccessfulMessage(FilesPage.context!,
                              'download', 'File downloaded to local device');

                          setState(() {
                            widget.files[index].downloaded = true;
                          });
                        } else {
                          Messages.showErrorMessage(FilesPage.context!, 'Error',
                              'Error downloading file');
                        }
                      }
                    },
                    icon: widget.files[index].downloaded
                        ? const Icon(Icons.open_in_browser)
                        : const Icon(Icons.download)),
              ),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: widget.files.length),
    );
  }
}
