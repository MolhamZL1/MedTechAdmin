import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/app_colors.dart';

class InfoCardEntity {
  final Color color;
  final String text;
  final int count;
  final Widget icon;

  InfoCardEntity({
    required this.color,
    required this.text,
    required this.count,
    required this.icon,
  });
}

List<InfoCardEntity> entities = [
  InfoCardEntity(
    color: Colors.black87,
    text: "Total Products",
    count: 10,
    icon: Icon(FontAwesomeIcons.cube, size: 35),
  ),
  InfoCardEntity(
    color: AppColors.success,
    text: "Available",
    count: 5,
    icon: CircleAvatar(
      backgroundColor: AppColors.success.withOpacity(.2),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Icon(FontAwesomeIcons.cube, color: AppColors.success, size: 25),
      ),
    ),
  ),
  InfoCardEntity(
    color: AppColors.warning,
    text: "Low Stock",
    count: 1,
    icon: Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: 35),
  ),
  InfoCardEntity(
    color: AppColors.error,
    text: "Out of Stock",
    count: 4,
    icon: CircleAvatar(
      backgroundColor: AppColors.error.withOpacity(.2),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Icon(Icons.close, color: AppColors.error, size: 25),
      ),
    ),
  ),
];
