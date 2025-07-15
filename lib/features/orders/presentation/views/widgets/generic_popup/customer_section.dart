import 'package:flutter/material.dart';
import '../../../../domain/entities/InfomOrder.dart';
import 'info_row.dart';

class CustomerSection extends StatelessWidget {
  final Order order;

  const CustomerSection({required this.order, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoRow(icon: Icons.person, label: 'Name', value: order.customerName),
        InfoRow(icon: Icons.business, label: 'Organization', value: order.customerCity),
        InfoRow(icon: Icons.email, label: 'Email', value: order.customerEmail),
        InfoRow(icon: Icons.phone, label: 'Phone', value: order.customerPhone),
        InfoRow(icon: Icons.location_on, label: 'Address', value: order.customerAddress),
      ],
    );
  }
}
