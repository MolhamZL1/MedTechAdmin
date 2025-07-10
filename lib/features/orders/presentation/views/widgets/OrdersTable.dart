import 'package:flutter/material.dart';

import '../../../domain/entities/InfomOrder.dart';
import '../../../domain/entities/PopupType.dart';
import 'OrderRow.dart';
import 'OrdersTableHeader.dart';

class OrdersTable extends StatelessWidget {
  final List<Order> orders;
  final Function(PopupType, Order) onShowPopup;

  OrdersTable({required this.orders, required this.onShowPopup});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          OrdersTableHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) => OrderRow(
                order: orders[index],
                onShowPopup: onShowPopup,
              ),
            ),
          ),
        ],
      ),
    );
  }
}