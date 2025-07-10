import 'package:flutter/cupertino.dart';
import '../../../domain/entities/6.dart';
import '../../../domain/entities/InfomOrder.dart';
import '_buildStatusCell.dart';

class TotalCell extends StatelessWidget {
  final Order order;

  TotalCell({required this.order});

  @override
  Widget build(BuildContext context) {
    return Text(
        AppHelpers.formatCurrency(order.total),
        style: TextStyle(fontWeight: FontWeight.w600,
            color: Color(0xFF374151)));
  }
}