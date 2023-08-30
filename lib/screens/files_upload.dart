import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:some_name/model/files.dart';
import 'package:some_name/services/api_service.dart';
import 'package:video_player/video_player.dart';

class FilesUploadPage extends StatefulWidget {
  const FilesUploadPage({Key? key}) : super(key: key);
  static BuildContext? context;

  @override
  State<FilesUploadPage> createState() => _FilesUploadPageState();
}

class _FilesUploadPageState extends State<FilesUploadPage> {
  late ProgressDialog pr;
  List<FileDownload>? files;
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.normal,
      textDirection: TextDirection.ltr,
      isDismissible: false,
    );
    pr.style(
      message: 'جاري جلب الملفات',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressWidgetAlignment: Alignment.center,
      progressTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
      ),
      messageTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 19.0,
        fontWeight: FontWeight.w400,
      ),
    );

    _loadFileNames();
  }

  Future<void> _loadFileNames() async {
    List<FileDownload> fileNames = await ApiService.getFileNames();

    await pr.hide();
    setState(() {
      files = fileNames;
    });
  }

  @override
  Widget build(BuildContext context) {
    FilesUploadPage.context = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('الملفات المحملة'),
        actions: [
          IconButton(
            onPressed: () async {
              // await ApiService.pickFileAndUpload(pr);

              showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    // <-- SEE HERE
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50.0),
                    ),
                  ),
                  builder: (context) {
                    return SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              pr.update(message: "جاري رفع الملف");
                              pr.show();
                              ApiService.uploadImages(pr);
                              _loadFileNames();
                            },
                            child: const Card(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Image(
                                      image: AssetImage("images/upload.png"),
                                      width: 50,
                                    ),
                                    Text('رفع صورة')
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              pr.update(message: "جاري رفع الملف");
                              pr.show();
                              ApiService.uploadVideos(pr);
                              _loadFileNames();
                            },
                            child: const Card(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Image(
                                      image: AssetImage("images/video.png"),
                                      width: 50,
                                    ),
                                    Text('رفع فديو')
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              pr.update(message: "جاري رفع الملف");
                              pr.show();
                              ApiService.uploadText(pr);
                              _loadFileNames();
                            },
                            child: const Card(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Image(
                                      image: AssetImage("images/open-folder.png"),
                                      width: 50,
                                    ),
                                    Text('رفع ملف')
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  });
            },
            icon: const Icon(
              Icons.cloud_upload_rounded,
            ),
          ),
        ],
      ),
      body: files == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : ListView.builder(
              itemCount: files!.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(files![index].name),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () async {
                              if (files![index].downloaded) {
                                try {
                                  Directory appDocDir =
                                      await getApplicationDocumentsDirectory();
                                  if (files![index].type == 'videos') {
                                    _controller = VideoPlayerController.file(File(
                                        '${appDocDir.path}/${files![index].name}'))
                                      ..initialize().then((_) {
                                        AwesomeDialog(
                                          dialogType: DialogType.noHeader,
                                          context: FilesUploadPage.context!,
                                          body: files![index].type == 'videos'
                                              ? Container(
                                                  child: _controller
                                                          .value.isInitialized
                                                      ? AspectRatio(
                                                          aspectRatio:
                                                              _controller.value
                                                                  .aspectRatio,
                                                          child: VideoPlayer(
                                                              _controller),
                                                        )
                                                      : const CircularProgressIndicator(),
                                                )
                                              : Image.file(File(
                                                  '${appDocDir.path}/${files![index].name}')),
                                          onDismissCallback: (type) {
                                            _controller.dispose();
                                          },
                                        ).show();
                                        _controller.play();
                                      });
                                  } else if (files![index].type == 'txt') {
                                    File file = File(
                                        '${appDocDir.path}/${files![index].name}');
                                    String all = await file.readAsString();
                                    AwesomeDialog(
                                            dialogType: DialogType.noHeader,
                                            context: FilesUploadPage.context!,
                                            body: SingleChildScrollView(
                                                child: Text(all)))
                                        .show();
                                  } else {
                                    AwesomeDialog(
                                            dialogType: DialogType.noHeader,
                                            context: FilesUploadPage.context!,
                                            body: Image.file(File(
                                                '${appDocDir.path}/${files![index].name}')))
                                        .show();
                                  }
                                } catch (e) {
                                  print(e.toString());
                                }
                              } else {
                                pr.update(message: 'جاري تنزيل الملف');
                                pr.show();
                                await ApiService.downloadFile(
                                    files![index].name, files![index].type, pr);

                                setState(() {
                                  files![index].downloaded = true;
                                });
                              }
                            },
                            icon: files![index].downloaded
                                ? Image.asset("images/upload-2.png",
                                width: 25 
                                )
                                : Image.asset("images/download.png",
                                width: 25 
                                )
                              ),
                        IconButton(
                            onPressed: () async {
                              Directory appDocDir =
                                  await getApplicationDocumentsDirectory();
                              AwesomeDialog(
                                      context: FilesUploadPage.context!,
                                      title: 'ملاحظة',
                                      btnOkOnPress: () {
                                        pr.update(message: 'جاري مسح الملف');
                                        File file = File(
                                            '${appDocDir.path}/${files![index].name}');
                                        file.delete();

                                        ApiService.deleteFileFromStorage(
                                            files![index].name,
                                            files![index].type,
                                            pr);
                                        setState(() {
                                          files = null;
                                        });
                                        _loadFileNames();
                                      },
                                      desc: 'هل أنت متأكد من رغبتك في الحذف؟ سيتم أيضًا حذف البيانات من مجلد التنزيل على الجهاز')
                                  .show();
                            },
                            icon: Image.asset("images/delete.png",
                            width: 25
                            )
                          )
                      ],
                    ),
                    trailing: files![index].type == 'videos'
                        ? Image.asset("images/video.png",
                        width: 25
                        )
                        : files![index].type == 'txt'
                            ? Image.asset("images/open-folder.png",
                            width: 25
                            )
                            : Image.asset("images/upload.png",
                            width: 25
                            )
                          );
              },
            ),
    );
  }
}
