import 'package:flutter/material.dart';

import '../../../domain/entities/InfomOrder.dart';
import '../../../domain/entities/PopupType.dart';
import '_buildDateCell.dart';
import '_buildOrderIdCell.dart';
import '_buildProductCell.dart';
import '_buildStatusCell.dart';
import '_buildTotalCell.dart';
import 'buildActionsCell.dart';
import 'buildCustomerCell.dart';

class OrderRow extends StatelessWidget {
  final Order order;
  final Function(PopupType, Order) onShowPopup;

  OrderRow({required this.order, required this.onShowPopup});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1)),
      ),
      child: Row(
        children: [
          Expanded(flex: 2, child: OrderIdCell(order: order, onShowPopup: onShowPopup)),
          Expanded(flex: 3, child: CustomerCell(order: order, onShowPopup: onShowPopup)),
          Expanded(flex: 3, child: ProductCell(order: order, onShowPopup: onShowPopup)),
          Expanded(flex: 2, child: TotalCell(order: order)),
          Expanded(flex: 2, child: StatusCell(order: order, onShowPopup: onShowPopup)),
          Expanded(flex: 2, child: DateCell(order: order, onShowPopup: onShowPopup)),
          Expanded(flex: 2, child: ActionsCell(order: order, onShowPopup: onShowPopup)),
        ],
      ),
    );
  }
}