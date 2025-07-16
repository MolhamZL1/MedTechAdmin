import 'package:flutter/material.dart';

import '../../../../domain/entities/InfomOrder.dart';
import 'info_row.dart';

class ProductSection extends StatelessWidget {
  final Order order;

  const ProductSection({required this.order, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoRow(icon: Icons.inventory, label: 'Product', value: order.productName),
        InfoRow(icon: Icons.numbers, label: 'Quantity', value: order.productQuantity.toString()),
        InfoRow(icon: Icons.attach_money, label: 'Unit Price', value: '\$${order.productPrice.toStringAsFixed(2)}'),
        InfoRow(icon: Icons.calculate, label: 'Total', value: '\$${order.total.toStringAsFixed(2)}'),
      ],
    );
  }
}
