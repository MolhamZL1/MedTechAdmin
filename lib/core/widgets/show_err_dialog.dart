import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void showerrorDialog({
  required BuildContext context,
  required String title,
  required String description,
}) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    // animType: AnimType.rightSlide,
    title: title,
    desc: description,
    btnOkOnPress: () {},
    width: 600,
  ).show();
}
