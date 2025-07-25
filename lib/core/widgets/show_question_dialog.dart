import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void showQuestionDialog({
  required BuildContext context,
  required String title,
  required String description,
  required void Function() btnOkOnPress,
}) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.question,
    animType: AnimType.rightSlide,
    title: title,
    desc: description,
    btnCancelOnPress: () {},
    btnOkOnPress: btnOkOnPress,
    width: 600,
  ).show();
}
