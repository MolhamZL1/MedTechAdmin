import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';

import '../../../domain/entities/6.dart';
import '../../../domain/entities/order_constant.dart';

class StatusChip extends StatelessWidget {
  final String status;

  StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final color = AppHelpers.getStatusColor(status);
    final icon = AppHelpers.getStatusIcon(status);

    Color backgroundColor;
    switch (status.toLowerCase()) {
      case 'processing':
        backgroundColor = AppColors.warning;
        break;
      case 'shipped':
        backgroundColor = AppColors.primary;
        break;
      case 'delivered':
        backgroundColor = AppColors.success;
        break;
      default:
        backgroundColor =Color(0xFFF9FAFB);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: Constants.spacingM, vertical: Constants.spacingXS + 2),
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: Constants.fontSizeM, color: color),
          SizedBox(width: Constants.spacingXS),
          Text(
              status,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Constants.fontSizeS,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
