import 'package:flutter/material.dart';
import '../../../../domain/entities/InfomOrder.dart';
import 'info_row.dart';

class DateSection extends StatelessWidget {
  final Order order;

  const DateSection({required this.order, Key? key}) : super(key: key);

  String _calculateProcessingTime() {
    try {
      final orderDate = DateTime.parse(order.orderDate);
      final deliveryDate = DateTime.parse(order.estimatedDelivery);
      final diff = deliveryDate.difference(orderDate).inDays;
      return '$diff days';
    } catch (_) {
      return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoRow(icon: Icons.event, label: 'Order Date', value: order.orderDate),
        InfoRow(icon: Icons.schedule, label: 'Estimated Delivery', value: order.estimatedDelivery),
        InfoRow(icon: Icons.access_time, label: 'Processing Time', value: _calculateProcessingTime()),
      ],
    );
  }
}
