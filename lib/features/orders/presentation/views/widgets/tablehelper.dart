import 'package:flutter/material.dart';
import '../../../../rentaling/domain/table_column.dart';
import '../../../../rentaling/domain/table_data.dart';
import '../../../../rentaling/presentaion/widgets/status_badge.dart';
import '../../../../rentaling/utils/constants.dart';
import '../../../domain/entities/order_entity.dart';
import 'dialogs/rental_details_dialog.dart';

class OrderTableHelper {
  static TableData fromOrderList(List<OrderEntity> orders, BuildContext context) {
    final columns = [
      TableColumn(
        key: 'id',
        title: 'Order ID',
        type: ColumnType.text,
        width: 100,
      ),
      TableColumn(
        key: 'user',
        title: 'User',
        type: ColumnType.custom,
        width: 250,
        customBuilder: (value) {
          final order = value as OrderEntity;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(order.user.username,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(order.user.email,
                  style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          );
        },
      ),
      TableColumn(
        key: 'status',
        title: 'Status',
        type: ColumnType.custom,
        width: 160,
        customBuilder: (value) {
          final order = value as OrderEntity;
          return StatusBadge(
            status: order.status == "PENDING"
                ? StatusType.pending
                : StatusType.active,
          );
        },
      ),
      TableColumn(
        key: 'total',
        title: 'Total',
        type: ColumnType.text,
        width: 120,
      ),
      TableColumn(
        key: 'date',
        title: 'Date',
        type: ColumnType.text,
        width: 180,
      ),
      TableColumn(
        key: 'address',
        title: 'Address',
        type: ColumnType.text,
        width: 300,
      ),
      TableColumn(
        key: 'details',
        title: 'Details',
        type: ColumnType.custom,
        width: 120,
        customBuilder: (value) {
          final order = value as OrderEntity;
          return ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => OrderDetailsDialog(order: order),
              );
            },
            child: const Text("View Details"),
          );
        },
      ),
    ];

    final rows = orders
        .map((order) => {
      'id': 'ORD-${order.id.toString().padLeft(3, '0')}', // Example: ORD-001

      'user': order,
      'status': order,
      'total': order.totalAmount.toString(),
      'date':
      "${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}",
      'address': order.shippingAddress,
      'details': order,
    })
        .toList();

    return TableData(
      showBorder: true,
      showHeader: true,
      columns: columns,
      rows: rows,
    );
  }
}

