import 'package:flutter/cupertino.dart';

import '../../../domain/entities/InfomOrder.dart';
import '../../../domain/entities/PopupType.dart';

class DateCell extends StatelessWidget {
  final Order order;
  final Function(PopupType, Order) onShowPopup;

  DateCell({required this.order, required this.onShowPopup});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onShowPopup(PopupType.date, order),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(order.orderDate, style: TextStyle(color: Color(0xFF6B7280), decoration: TextDecoration.underline, decorationColor: Color(0xFF6B7280))),
          Text('Est. ${order.estimatedDelivery}', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
        ],
      ),
    );
  }
}