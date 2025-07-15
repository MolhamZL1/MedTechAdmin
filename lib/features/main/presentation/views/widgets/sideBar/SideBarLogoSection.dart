import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/utils/app_images.dart';

class SideBarLogoSection extends StatelessWidget {
  const SideBarLogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.white,
      child: Image.asset(AppImages.imagesLogo, fit: BoxFit.cover),
    );
  }
}
