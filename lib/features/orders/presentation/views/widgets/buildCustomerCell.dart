import 'package:flutter/cupertino.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';

import '../../../domain/entities/InfomOrder.dart';
import '../../../domain/entities/PopupType.dart';


class CustomerCell extends StatelessWidget {
  final Order order;
  final Function(PopupType, Order) onShowPopup;

  CustomerCell({required this.order, required this.onShowPopup});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onShowPopup(PopupType.customer, order),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(order.customerName, style: TextStyle(fontWeight: FontWeight.w600,
              color: AppColors.primary,
              decoration: TextDecoration.underline)),
          Text(order.customerCity,
              style: TextStyle(fontSize: 12,
                  color:Color(0xFF6B7280))),
        ],
      ),
    );
  }
}