import 'package:flutter/material.dart';
import '../../../../domain/entities/InfomOrder.dart';
import 'info_row.dart';

class SummarySection extends StatelessWidget {
  final Order order;

  const SummarySection({required this.order, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoRow(icon: Icons.receipt, label: 'Order ID', value: order.orderId),
        InfoRow(icon: Icons.attach_money, label: 'Total Amount', value: '\$${order.total.toStringAsFixed(2)}'),
        InfoRow(icon: Icons.info, label: 'Status', value: order.status),
        InfoRow(icon: Icons.payment, label: 'Payment', value: order.paymentMethod),
        if (order.notes.isNotEmpty)
          InfoRow(icon: Icons.note, label: 'Notes', value: order.notes),
      ],
    );
  }
}
