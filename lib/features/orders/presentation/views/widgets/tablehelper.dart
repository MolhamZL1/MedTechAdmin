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
        return StatusType.paid;
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
        key: 'user',
        title: 'User',
        type: ColumnType.custom,
        width: 250,
        customBuilder: (value) {
          final order = value as OrderEntity;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.user.username ?? 'Unknown User',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                order.user.email ?? 'No Email',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
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
        type: ColumnType.custom, // تغيير النوع إلى custom
        width: 120,
        customBuilder: (value) { // إضافة customBuilder
          final order = value as OrderEntity;
          return Text(
            order.totalAmount.toString(),
            // تطبيق النمط على الإجمالي
            style: Theme.of(context).textTheme.bodySmall,
          );
        },
      ),
      TableColumn(
        key: 'date',
        title: 'Date',
        type: ColumnType.custom,
        width: 180,
        customBuilder: (value) {
          final order = value as OrderEntity;
          final dateText = "${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}";
          return Text(
            dateText,
            style: Theme.of(context).textTheme.bodySmall,
          );
        },
      ),
      TableColumn(
        key: 'address',
        title: 'Address',
        type: ColumnType.custom,
        width: 300,
        customBuilder: (value) {
          final order = value as OrderEntity;
          return Text(
            order.shippingAddress ?? 'No Address Provided',
            style: Theme.of(context).textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          );
        },
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
      TableColumn(
        key: 'actions',
        title: 'Actions',
        type: ColumnType.custom,
        width: 200,
        flex: 2,
        customBuilder: (value) {
          final order = value as OrderEntity;

          if (order.status?.toUpperCase() == 'PENDING') {
            return Wrap(
                spacing: 4.0,
                runSpacing: 4.0,
                alignment: WrapAlignment.start,
                children:[ ElevatedButton.icon(
                  onPressed: () {
                    context.read<OrderCubit>().confirmOrderPayment(order.id, order.totalAmount);
                  },
                  icon: const Icon(Icons.check_circle_outline, size: 16),
                  label: const Text("Confirm Payment"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                ]
            );
          }
          return
            Text("NOthingToDo");

        },
      ),
    ];

    final rows = orders
        .map((order) => {
      'id': 'ORD-${order.id.toString().padLeft(3, '0')}',
      'user': order,
      'status': order,
      'total': order, // تمرير الكائن order بالكامل
      'date': order,
      'address': order,
      'details': order,
      'actions': order,
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
