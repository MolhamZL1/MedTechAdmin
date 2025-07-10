import 'package:flutter/material.dart';

import '../../../domain/entities/InfomOrder.dart';
import '../../../domain/entities/PopupType.dart';

class OrderIdCell extends StatelessWidget {
  final Order order;
  final Function(PopupType, Order) onShowPopup;

  OrderIdCell({required this.order, required this.onShowPopup});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onShowPopup(PopupType.orderSummary, order),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(order.orderId, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF374151))),
          Text('Sale', style: TextStyle(fontSize: 12, color:Color(0xFF6B7280))),
        ],
      ),
    );
  }
}