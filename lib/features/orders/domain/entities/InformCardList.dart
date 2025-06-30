import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/app_colors.dart';

class InformCardEntity {
  final Color color;
  final String text;
  final int count;
  final Widget icon;

  InformCardEntity({
    required this.color,
    required this.text,
    required this.count,
    required this.icon,
  });
}

List<InformCardEntity> entitiess = [
  InformCardEntity(
    color: Colors.black87,
    text: "Total Orders",
    count: 5,
    icon: Icon(Icons.shopping_cart_outlined, size: 35),
  ),
  InformCardEntity(
    color: AppColors.warning,
    text: "Processing",
    count: 3,
    icon: Icon(Icons.timelapse_outlined, size: 35,color: AppColors.warning,),
  ),
  InformCardEntity(
    color: AppColors.success,
    text: "Delivered",
    count: 1,
    icon: Icon(Icons.library_add_check, color: AppColors.success, size: 35),
  ),
  InformCardEntity(
    color: AppColors.error,
    text: "Total Revenue",
    count: 411,
    icon: Icon(Icons.attach_money_sharp, size: 35, color: AppColors.error,),
  ),
];
