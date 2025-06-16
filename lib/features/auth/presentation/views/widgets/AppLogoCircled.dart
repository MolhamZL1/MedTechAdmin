import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';
import 'package:med_tech_admin/core/utils/app_images.dart';

class AppLogoCircled extends StatelessWidget {
  const AppLogoCircled({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.primary,
      radius: 71.5,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 70,
        child: Image.asset(AppImages.imagesLogo),
      ),
    );
  }
}
