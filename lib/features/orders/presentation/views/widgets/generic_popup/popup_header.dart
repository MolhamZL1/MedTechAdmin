import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';
import '../../../../domain/entities/PopupType.dart';
import '../../../../domain/entities/InfomOrder.dart';

class PopupHeader extends StatelessWidget {
  final PopupData popupData;
  final VoidCallback onClose;

  const PopupHeader({required this.popupData, required this.onClose, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData icon;
    String title;
    Color color;

    switch (popupData.type) {
      case PopupType.customer:
        icon = Icons.person;
        title = 'Customer Information';
        color = AppColors.primary;
        break;
      case PopupType.product:
        icon = Icons.inventory;
        title = 'Product Details';
        color = AppColors.success;
        break;
      case PopupType.status:
        icon = Icons.info;
        title = 'Order Status';
        color = AppColors.warning;
        break;
      case PopupType.date:
        icon = Icons.calendar_today;
        title = 'Date Information';
        color = AppColors.error;
        break;
      case PopupType.orderSummary:
        icon = Icons.receipt;
        title = 'Order Summary';
        color = AppColors.primary;
        break;
    }

    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primary),
        ),
        Spacer(),
        IconButton(
          onPressed: onClose,
          icon: Icon(Icons.close, size: 18),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
      ],
    );
  }
}
