import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_tech_admin/features/products/presentation/cubits/get%20products/get_products_cubit.dart';

import '../utils/app_colors.dart';

class InfoCardEntity {
  Color? color;
  final String text;
  final String count;
  final Widget icon;

  InfoCardEntity({
    this.color,
    required this.text,
    required this.count,
    required this.icon,
  });
}

List<InfoCardEntity> productinfolist(BuildContext context) {
  return [
    InfoCardEntity(
      // color: Colors.black87,
      text: "Total Products",
      count:
          context.watch<GetProductsCubit>().products.isEmpty
              ? "...."
              : context.watch<GetProductsCubit>().products.length.toString(),
      icon: Icon(FontAwesomeIcons.cube, size: 35),
    ),
    InfoCardEntity(
      color: AppColors.success,
      text: "Available",
      count: "5",
      icon: CircleAvatar(
        backgroundColor: AppColors.success.withOpacity(.2),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(
            FontAwesomeIcons.cube,
            color: AppColors.success,
            size: 25,
          ),
        ),
      ),
    ),
    InfoCardEntity(
      color: AppColors.warning,
      text: "Low Stock",
      count: "1",
      icon: Icon(
        Icons.warning_amber_rounded,
        color: AppColors.warning,
        size: 35,
      ),
    ),
    InfoCardEntity(
      color: AppColors.error,
      text: "Out of Stock",
      count: "4",
      icon: CircleAvatar(
        backgroundColor: AppColors.error.withOpacity(.2),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(Icons.close, color: AppColors.error, size: 25),
        ),
      ),
    ),
  ];
}

List<InfoCardEntity> orderslistinfo = [
  InfoCardEntity(
    // color: Colors.black87,
    text: "Total Orders",
    count: "5",
    icon: Icon(Icons.shopping_cart_outlined, size: 35),
  ),
  InfoCardEntity(
    color: AppColors.warning,
    text: "Processing",
    count: "3",
    icon: Icon(Icons.timelapse_outlined, size: 35, color: AppColors.warning),
  ),
  InfoCardEntity(
    color: AppColors.success,
    text: "Delivered",
    count: "1",
    icon: Icon(Icons.library_add_check, color: AppColors.success, size: 35),
  ),
  InfoCardEntity(
    color: AppColors.error,
    text: "Total Revenue",
    count: "411",
    icon: Icon(Icons.attach_money_sharp, size: 35, color: AppColors.error),
  ),
];
List<InfoCardEntity> Rentalslistinfo = [
  InfoCardEntity(
    // color: Colors.black87,
    text: "Active Rentals",
    count: "5",
    icon: Icon(Icons.notifications_active, size: 35),
  ),
  InfoCardEntity(
    color: AppColors.warning,
    text: "Expiring Soon",
    count: "3",
    icon: Icon(Icons.timelapse_outlined, size: 35, color: AppColors.warning),
  ),
  InfoCardEntity(
    color: AppColors.success,
    text: "Overdue",
    count: "1",
    icon: Icon(Icons.error, color: AppColors.success, size: 35),
  ),
  InfoCardEntity(
    color: AppColors.error,
    text: "Total Revenue",
    count: "411",
    icon: Icon(Icons.attach_money_sharp, size: 35, color: AppColors.error),
  ),
];
List<InfoCardEntity> Userslistinfo = [
  InfoCardEntity(
    // color: Colors.black87,
    text: "Total Users",
    count: "5",
    icon: Icon(Icons.person_sharp, size: 35),
  ),
  InfoCardEntity(
    color: AppColors.success,
    text: "Active Users",
    count: "3",
    icon: Icon(Icons.check_circle_outline, size: 35, color: AppColors.success),
  ),
  InfoCardEntity(
    color: AppColors.primary,
    text: "Customers",
    count: "1",
    icon: Icon(Icons.people_alt_outlined, color: AppColors.primary, size: 35),
  ),
];
