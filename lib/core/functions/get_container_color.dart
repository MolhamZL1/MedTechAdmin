import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';

Color getContainerColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? AppColors.cardColorDark
      : AppColors.cardColorlight;
}
