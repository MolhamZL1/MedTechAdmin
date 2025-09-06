import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/show_err_dialog.dart';
import '../../../../../core/widgets/showsuccessDialog.dart';
import '../../../../rentaling/domain/table_column.dart';
import '../../../../rentaling/domain/table_data.dart';
import '../../../../rentaling/presentaion/widgets/status_badge.dart';
import '../../../../rentaling/utils/constants.dart'; // تأكد من أن هذا المسار صحيح
import '../../../domain/entities/order_entity.dart';
import '../cubits/cubit.dart';
import 'dialogs/order_details_dialog.dart';

class OrderTableHelper {
  static final List<String> orderStatuses = [
    "PENDING",
    "PAID",
    "CONFIRMED",
    "SHIPPED",
    "DELIVERED",
    "CANCELLED",
    "RETURNED",
  ];

  static StatusType _mapStatusToType(String? status) {
    switch (status?.toUpperCase()) {
      case 'PENDING':
        return StatusType.pending;
      case 'PAID':
        return StatusType.confirmed;
      case 'SHIPPED':
        return StatusType.shipped;
      case 'DELIVERED':
        return StatusType.delivered;
      case 'CANCELLED':
        return StatusType.cancelled;
      case 'RETURNED':
        return StatusType.returned;
      default:
        return StatusType.unknown;
    }
  }

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
              Text(order.user.username ?? 'Unknown User',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(order.user.email ?? 'No Email',
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
          return Builder(
            builder: (context) {
              return InkWell(
                onTap: () async {
                  final RenderBox button = context.findRenderObject() as RenderBox;
                  final Offset buttonPosition = button.localToGlobal(Offset.zero);
                  final Size buttonSize = button.size;

                  final selectedStatus = await showMenu<String>(
                    context: context,
                    position: RelativeRect.fromLTRB(
                      buttonPosition.dx,
                      buttonPosition.dy + buttonSize.height,
                      buttonPosition.dx + buttonSize.width,
                      buttonPosition.dy,
                    ),
                    items: orderStatuses.map((status) {
                      return PopupMenuItem<String>(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                  );

                  if (selectedStatus != null && selectedStatus != order.status) {
                    context.read<OrderCubit>().changeOrderStatus(order.id, selectedStatus);
                  }
                },
                child: StatusBadge(
                  status: _mapStatusToType(order.status),
                ),
              );
            },
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
      'id': 'ORD-${order.id.toString().padLeft(3, '0')}',
      'user': order,
      'status': order,
      'total': order.totalAmount.toString(),
      'date':
      "${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}",
      // --- تعديل رقم 3: إضافة قيمة افتراضية لعنوان الشحن ---
      'address': order.shippingAddress ?? 'No Address Provided',
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
