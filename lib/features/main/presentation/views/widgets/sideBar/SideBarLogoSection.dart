import 'package:flutter/material.dart';

class SideBarLogoSection extends StatelessWidget {
  const SideBarLogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: 100,
      height: 150,
      fit: BoxFit.cover,
    );
  }
}
