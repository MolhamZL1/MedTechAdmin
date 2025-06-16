import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomCircleLoading extends StatelessWidget {
  const CustomCircleLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(color: AppColors.primary);
  }
}
