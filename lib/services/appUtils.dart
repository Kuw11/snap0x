import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class Messages {
  static showSuccessfulMessage(BuildContext context, String title, String des) {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            title: title,
            desc: des)
        .show();
  }

  static showErrorMessage(BuildContext context, String title, String des) {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            title: title,
            desc: des)
        .show();
  }
}
