import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';
import '../../../domain/entities/InfomOrder.dart';
import '../../../domain/entities/PopupType.dart';

class ActionsCell extends StatelessWidget {
  final Order order;
  final Function(PopupType, Order) onShowPopup;

  ActionsCell({required this.order, required this.onShowPopup});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => onShowPopup(PopupType.orderSummary, order),
      icon: Icon(Icons.visibility, size: 16),
      label: Text('View'),
      style: TextButton.styleFrom(foregroundColor: AppColors.primary),
    );
  }
}