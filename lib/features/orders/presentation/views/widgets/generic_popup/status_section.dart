import 'package:flutter/material.dart';
import '../../../../domain/entities/InfomOrder.dart';
import 'info_row.dart';

class StatusSection extends StatelessWidget {
  final Order order;

  const StatusSection({required this.order, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoRow(icon: Icons.info, label: 'Current Status', value: order.status),
        InfoRow(icon: Icons.calendar_today, label: 'Order Date', value: order.orderDate),
        InfoRow(icon: Icons.local_shipping, label: 'Estimated Delivery', value: order.estimatedDelivery),
        InfoRow(icon: Icons.payment, label: 'Payment Method', value: order.paymentMethod),
      ],
    );
  }
}
