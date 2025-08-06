import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void showsuccessDialog({
  required BuildContext context,
  required String title,
  required String description,
  void Function()? btnOkOnPress,
}) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    // animType: AnimType.rightSlide,
    title: title,
    desc: description,
    btnOkOnPress: btnOkOnPress,
    width: 600,
  ).show();
}
